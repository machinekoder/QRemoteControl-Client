#include "qremotecontrolclient.h"

#ifdef Q_OS_SYMBIAN
//#include "sym_iap_util.h"
#endif

QRemoteControlClient::QRemoteControlClient(QObject *parent)
    : QObject(parent)
{
    m_screenOrientation = ScreenOrientationAuto;
    m_version = QString(VERSION);
    m_runCount = 0;

    // initialize translators
    m_emptyString = "";
    m_language = "en";
    translator1 = new QTranslator(this);

    loadSettings();

    tcpSocket = NULL;

    tcpServer =         new QTcpServer(this);
    udpSocket =         new QUdpSocket(this);
    broadcastTimer =    new QTimer(this);
    connectionRequestTimer = new QTimer(this);

    connect(tcpServer, SIGNAL(newConnection()), this, SLOT(newConnection()));
    connect(broadcastTimer, SIGNAL(timeout()), this, SLOT(sendBroadcast()));
    connect(connectionRequestTimer, SIGNAL(timeout()), this, SLOT(sendConnectionRequest()));

    // now begin the process of opening the network link
    session = NULL;
    netConfigManager = new QNetworkConfigurationManager;
    connect(netConfigManager, SIGNAL(updateCompleted()),
            this, SLOT(openNetworkSession()));
    netConfigManager->updateConfigurations();
    // update the connections cyclically
    netConfigTimer = new QTimer(this);
    netConfigTimer->setInterval(5000);
    connect(netConfigTimer, SIGNAL(timeout()),
            this, SLOT(updateNetConfig()));
    netConfigTimer->start();

    // initialize network timeout
    m_networkTimeout = 4500;
    initializeNetworkTimeoutTimer();

    // trial
#ifdef TRIAL
    networkAccesManager = new QNetworkAccessManager(this);
    connect(networkAccesManager, SIGNAL(finished(QNetworkReply*)),
        this, SLOT(replyFinished(QNetworkReply*)));
    trialTimer = new QTimer(this);
    trialTimer->setInterval(10000);
    trialTimer->start();
    connect(trialTimer, SIGNAL(timeout()),
            this, SLOT(trialTimerTimeout()));

    m_trialVersion = true;
    m_trialExpirationTime = QDateTime();
#else
    m_trialVersion = false;
#endif
}

QRemoteControlClient::~QRemoteControlClient()
{
    saveSettings();

    if (tcpSocket)
        tcpSocket->disconnectFromHost();
}

void QRemoteControlClient::openNetworkSession()
{
    // use the default network configuration and make sure that
    // the link is open
    QNetworkConfiguration networkConfig;

    if ((netConfigManager->defaultConfiguration().bearerType() == QNetworkConfiguration::BearerEthernet)
            || (netConfigManager->defaultConfiguration().bearerType() == QNetworkConfiguration::BearerWLAN))
    {
        networkConfig = netConfigManager->defaultConfiguration();
    }
    else
    foreach (QNetworkConfiguration config, netConfigManager->allConfigurations(QNetworkConfiguration::Discovered))
    {
        if ((config.bearerType() == QNetworkConfiguration::BearerEthernet) ||
                (config.bearerType() == QNetworkConfiguration::BearerWLAN))
        {
            networkConfig = config;
#ifdef QT_DEBUG
            //qDebug() << config.bearerTypeName() << config.bearerName() << config.name();
#endif
        }
    }

    if (networkConfig.isValid())
    {
        if (session != NULL)
        {
            session->deleteLater();
        }

        session = new QNetworkSession(networkConfig);

        if (session->isOpen()) {
            initialize();
        } else {
            connect(session, SIGNAL(opened()),
                    this, SLOT(initialize()));
            connect(session, SIGNAL(opened()),
                    this, SIGNAL(networkOpened()));
            connect(session, SIGNAL(closed()),
                    this, SIGNAL(networkClosed()));
            session->open();
        }
    }
}

bool QRemoteControlClient::sendWakeOnLan()
{
    WakeOnLanPacket wakeOnLanPacket;
    QByteArray macAddress = QByteArray();
    QString hostname = m_wolHostname;
    bool status = true;

    macAddress.append(m_wolMacAddress);

    if (!wakeOnLanPacket.setMacAddress(macAddress))
    {
#ifdef QT_DEBUG
        qDebug() << "mac address wrong";
#endif
        status = false;
    }

    if (hostname.isEmpty()) //empty means LAN
    {
        wakeOnLanPacket.setHostname(QString("255.255.255.255"));
    }
    else if (!wakeOnLanPacket.setHostname(hostname))
    {
#ifdef QT_DEBUG
        qDebug() << "hostname wrong";
#endif
        status = false;
    }

    if (!status)
    {
#ifdef QT_DEBUG
        qDebug() << "not sending magic packet";
#endif
        return status;
    }

    for (int i = 0; i < m_wolDatagramNumber; i++)   //send as often as needed
    {
        if (!wakeOnLanPacket.send())
            status = false;
    }

#ifdef QT_DEBUG
    if (!status)
    {
        qDebug() << "Probably no network connection";
    }
#endif

    return status;
}

void QRemoteControlClient::updateLastConnections()
{
    emit lastConnectionsCleared();
    for (int i = lastConnectionList.count()-1; i >= 0; --i)
    {
        emit lastConnectionAdded(lastConnectionList.at(i).hostName,
                                 lastConnectionList.at(i).password,
                                 lastConnectionList.at(i).port);
    }
}

void QRemoteControlClient::addLastConnection(QString hostName, QString password, int port)
{
    QRCConnection connection;

    for (int i = lastConnectionList.count()-1; i >= 0; --i)
    {
        if ((lastConnectionList.at(i).hostName == hostName)
             && (lastConnectionList.at(i).port == port) )
        {
            lastConnectionList.removeAt(i);
        }
    }

    connection.hostName = hostName;
    connection.password = password;
    connection.port = port;
    lastConnectionList.append(connection);

    updateLastConnections();
}

void QRemoteControlClient::clearLastConnections()
{
    lastConnectionList.clear();
}

void QRemoteControlClient::initialize()
{
    tcpServer->close();
    tcpServer->listen(QHostAddress::Any, m_port);

    udpSocket->close();
    connect(udpSocket, SIGNAL(readyRead()), this, SLOT(incomingUdpData()));
    udpSocket->bind(m_port, QUdpSocket::DontShareAddress | QUdpSocket::ReuseAddressHint);
}

void QRemoteControlClient::connectToHost()
{
    if (!m_password.isEmpty())
    {
        //here the host address should be added
        passwordHash = QCryptographicHash::hash(m_password.toUtf8(), QCryptographicHash::Sha1);
    }
    else
        passwordHash.clear();

    sendConnectionRequest();
    connectionRequestTimer->start(5000);

    addLastConnection(m_hostname, m_password, m_port);

    emit connectingStarted();
}

void QRemoteControlClient::connectToServer(int id)
{
    QRCServer qrcServer = serverList[id];
    setHostAddress(qrcServer.hostAddress);
    abortBroadcasting();
    connectToHost();
}

void QRemoteControlClient::startBroadcasting()
{
    initialize();
    sendBroadcast();
    broadcastTimer->start(5000);

    emit broadcastingStarted();
}

void QRemoteControlClient::abortBroadcasting()
{
    broadcastTimer->stop();
}

void QRemoteControlClient::abortConnectionRequest()
{
    connectionRequestTimer->stop();
}

void QRemoteControlClient::saveSettings()
{
    QSettings settings("", "qremotecontrol-client", this);

    settings.setValue("password", m_password);
    settings.setValue("hostname", m_hostname);
    settings.setValue("port", m_port);
    settings.setValue("uiColor", m_uiColor);
    settings.setValue("uiRoundness", m_uiRoundness);
    settings.setValue("screenOrientation", static_cast<int>(m_screenOrientation));
    settings.setValue("language", m_language);
    settings.setValue("runCount", m_runCount);

    settings.beginGroup("wol");
        settings.setValue("macAddress", m_wolMacAddress);
        settings.setValue("hostname", m_wolHostname);
        settings.setValue("port", m_wolPort);
        settings.setValue("datagramNumber", m_wolDatagramNumber);
    settings.endGroup();

    settings.beginWriteArray("lastConnection");
    for (int i = 0; i < lastConnectionList.count(); ++i)
    {
        settings.setArrayIndex(i);
        settings.setValue("hostName", lastConnectionList.at(i).hostName);
        settings.setValue("password", lastConnectionList.at(i).password);
        settings.setValue("port", lastConnectionList.at(i).port);
    }
    settings.endArray();
}

void QRemoteControlClient::loadSettings()
{
    QSettings settings("", "qremotecontrol-client", this);

    m_password  = settings.value("password", QString()).toString();
    m_hostname  = settings.value("hostname", QString()).toString();
    m_port      = settings.value("port", 5487).toInt();
#if !defined(Q_OS_SAILFISH)
    m_uiColor   = settings.value("uiColor", "fancyblack").toString();
#else
    m_uiColor   = settings.value("uiColor", "ambience").toString();
#endif
    m_uiRoundness = settings.value("uiRoundness", 10).toDouble();
    m_screenOrientation = static_cast<ScreenOrientation>(settings.value("screenOrientation", ScreenOrientationAuto).toInt());
    m_runCount = settings.value("runCount", 0).toInt();
    m_runCount++;
    emit runCountChanged(m_runCount);

    setLanguage(settings.value("language", QLocale::system().name()).toString());

    settings.beginGroup("wol");
        m_wolMacAddress     = settings.value("macAddress",QString()).toString();
        m_wolHostname       = settings.value("hostname",QString()).toString();
        m_wolPort           = settings.value("port",80).toInt();
        m_wolDatagramNumber = settings.value("datagramNumber",5).toInt();
    settings.endGroup();

    int count = settings.beginReadArray("lastConnection");
    for (int i = 0; i < count; ++i)
    {
        QRCConnection connection;

        settings.setArrayIndex(i);
        connection.hostName = settings.value("hostName", "test").toString();
        connection.password = settings.value("password", "").toString();
        connection.port = settings.value("port", 5487).toInt();
        lastConnectionList.append(connection);
    }
    settings.endArray();
}

void QRemoteControlClient::sendConnectionRequest()
{
    QByteArray datagram = "QRC:Hello";

    if (!passwordHash.isEmpty())        //for password protection
        datagram.append(passwordHash);

#ifdef QT_DEBUG
    qDebug() << "Connection request target: " << m_hostAddress;
#endif

    udpSocket->writeDatagram(datagram, m_hostAddress, m_port);
}

void QRemoteControlClient::sendBroadcast()
{
    QByteArray datagram = "QRC:Broadcast";

    udpSocket->writeDatagram(datagram, QHostAddress::Broadcast, m_port);
}

void QRemoteControlClient::newConnection()
{
    if (!tcpSocket) {
        tcpSocket = tcpServer->nextPendingConnection();

        connect(tcpSocket, SIGNAL(disconnected()), this, SLOT(deleteConnection()));
        connect(tcpSocket, SIGNAL(readyRead()), this, SLOT(incomingData()));

        emit connected();
        abortConnectionRequest();
        saveSettings();
        sendVersion();

        networkTimeoutTimer->start();
    }
}

void QRemoteControlClient::deleteConnection()
{
    tcpSocket->abort();
    tcpSocket->deleteLater();
    tcpSocket = NULL;

    networkTimeoutTimer->stop();

    emit disconnected();
}

void QRemoteControlClient::incomingData()
{
#ifdef QT_DEBUG
    qDebug() << "incoming data";
#endif
    QByteArray data = tcpSocket->readAll();
    int type = data.left(1).toInt();

    int payloadsize = data.mid(1,10).toInt();   //getting the size of the whole payload
                    data = data.mid(11);                        //removing obsolete data
                    while (data.size() != payloadsize) {        //wait for the missing data
                        tcpSocket->waitForReadyRead();
                        data.append(tcpSocket->readAll());
                    }

    switch (type) {
        case 1: incomingIcon(data);                         //process the data
                break;
        case 2: incomingAmarokData(data);
                break;
    }
}

void QRemoteControlClient::incomingUdpData()
{
    QHostAddress hostAddress;
#ifdef Q_OS_SYMBIAN
    QByteArray datagram(2^16,0);    //Workaround for a bug in Qt 4.8
#else
    QByteArray datagram;
    datagram.resize(udpSocket->pendingDatagramSize());
#endif

    udpSocket->readDatagram(datagram.data(), datagram.size(), &hostAddress);

    const QString magicMessageConnected = "QRC:Connected";
    const QString magicMessageNotConnected = "QRC:NotConnected";
    const QString magicMessagePasswordIncorrect = "QRC:PasswordIncorrect";
    const QString magicMessageServerConnecting = "QRC:ServerConnecting";
    const QString magicMessageBoxNotConnected = "QRC:BoxNotConnected";

    if (datagram == magicMessageConnected)
    {
#ifdef QT_DEBUG
        qDebug() << "Server found, State: connected";
#endif
        addServer(hostAddress, QRCServerType_PC, true);
    }
    else if (datagram == magicMessageNotConnected)
    {
#ifdef QT_DEBUG
        qDebug() << "Server found, State: not connected" << hostAddress;
#endif
        addServer(hostAddress, QRCServerType_PC, false);
    }
    else if (datagram == magicMessagePasswordIncorrect)
    {
#ifdef QT_DEBUG
        qDebug() << "Password incorrect";
#endif
        emit passwordIncorrect();
    }
    else if (datagram == magicMessageServerConnecting)
    {
#ifdef QT_DEBUG
        qDebug() << "Server connecting";
#endif
        emit serverConnecting();
    }
    else if (datagram == magicMessageBoxNotConnected)
    {
#ifdef QT_DEBUG
        qDebug() << "Box found, State: not connected" << hostAddress;
#endif
        addServer(hostAddress, QRCServerType_Box, false);
    }
}

void QRemoteControlClient::addServer(QHostAddress hostAddress, QRCServerType serverType, bool connected)
{
    bool found = false;
    for (int i = 0; i < serverList.size(); i++)
    {
        if (serverList.at(i).hostAddress == hostAddress) {
            found = true;
            serverList[i].connected = connected;
            break;
        }
    }
    if (!found)
    {
        QRCServer qrcServer;
        qrcServer.hostAddress = hostAddress;
        qrcServer.hostName = hostAddress.toString();
        qrcServer.serverType = serverType;
        qrcServer.connected = connected;
        serverList.append(qrcServer);

        QHostInfo::lookupHost(hostAddress.toString(),
                               this, SLOT(saveResolvedHostName(QHostInfo)));
    }

    emit serversCleared();
    for (int i = 0; i < serverList.size(); i++)
    {
        emit serverFound(serverList.at(i).hostAddress.toString(),
                         serverList.at(i).hostName,
                         serverList.at(i).serverType,
                         serverList.at(i).connected);
    }
}

void QRemoteControlClient::initializeNetworkTimeoutTimer()
{
    networkTimeoutTimer = new QTimer(this);
    networkTimeoutTimer->setInterval(m_networkTimeout);
    connect(networkTimeoutTimer, SIGNAL(timeout()),
            this, SLOT(sendKeepAlive()));
}

void QRemoteControlClient::saveResolvedHostName(QHostInfo hostInfo)
{
    for (int i = 0; i < serverList.size(); i++)
    {
        if (serverList.at(i).hostName == hostInfo.addresses().first().toString())
        {
            serverList[i].hostName = hostInfo.hostName();
        }
    }

    emit serversCleared();
    for (int i = 0; i < serverList.size(); i++)
    {
        emit serverFound(serverList.at(i).hostAddress.toString(),
                         serverList.at(i).hostName,
                         serverList.at(i).serverType,
                         serverList.at(i).connected);
    }
}

void QRemoteControlClient::updateNetConfig()
{
    if ((session == NULL) || (!session->isOpen()))
    {
        netConfigManager->updateConfigurations();
    }
}

#ifdef TRIAL
void QRemoteControlClient::checkTrialExpiration()
{
    QSystemDeviceInfo *deviceInfo;
    QString imei;
    QNetworkRequest *request;
    bool valid;

    if (m_trialExpirationTime.isNull())
    {
        deviceInfo  = new QSystemDeviceInfo(this);
        imei        = deviceInfo->imei();
        imei.remove("-");
        request     = new QNetworkRequest(QUrl("http://qremote.org/trail.php?imei=" + imei));
        networkAccesManager->get(*request);
    }
    else
    {
        if (QDateTime::currentDateTime() < m_trialExpirationTime)
        {
            valid = true;
        } else
        {
            valid = false;
        }

        if (valid == false)
        {
            emit trialExpired();
        }
#ifdef QT_DEBUG
        qDebug() <<  m_trialExpirationTime << valid;
#endif
    }
}

void QRemoteControlClient::replyFinished(QNetworkReply *reply)
{
    QByteArray  data;
    QString     timeString;
    QDateTime   dateTime;
    bool        valid;

    data        = reply->readAll();
    timeString  = QString(data).trimmed();
    dateTime    = QDateTime::fromString(timeString.trimmed(), Qt::ISODate);

    if (dateTime.isValid())
    {
        m_trialExpirationTime = dateTime;
        emit trialExpirationTimeChanged(m_trialExpirationTime);

        if (QDateTime::currentDateTime() < dateTime)
        {
            valid = true;
        } else
        {
            valid = false;
        }

        if (valid == false)
        {
            emit trialExpired();
        }
#ifdef QT_DEBUG
        qDebug() << timeString << dateTime << valid;
#endif
    } else
    {
        emit trialExpired();
#ifdef QT_DEBUG
        qDebug() << "checking failed";
#endif
    }


}

void QRemoteControlClient::trialTimerTimeout()
{
    checkTrialExpiration();
}
#endif

void QRemoteControlClient::clearServerList()
{
    serverList.clear();
    emit serversCleared();
}

void QRemoteControlClient::incomingIcon(QByteArray data)
{
    QDataStream in(data);

    emit clearActions();
    while (!in.atEnd()) {
        quint8 id;
        QPixmap icon;
        QString name;
        QString filePath = QDir::tempPath() + "/";
        in >> id >> name >> icon;
        if (!icon.isNull())
        {
            filePath += QString("qrc%1.png").arg(id);

            if (QFile::exists(filePath))
                QFile::remove(filePath);

            icon.save(filePath);
        }

        emit actionReceived(id, name, filePath);
    }
}

void QRemoteControlClient::incomingAmarokData(QByteArray data)
{
#ifdef QT_DEBUG
    qDebug() << "incoming Amarok data";
#endif
    QDataStream in(data);
    QString title,
            artist;
    in >> title >> artist;

    //ui->songLabel->setText(tr("%1<br>%2").arg(title,
    //                                          artist)); //GUI
}

void QRemoteControlClient::sendKey(quint32 key, quint32 modifiers,  bool keyPressed)
{   
    quint8 mode1 = 1;

    QByteArray data;
    QDataStream streamOut(&data, QIODevice::WriteOnly);
    streamOut << mode1;
    streamOut << key;
    streamOut << modifiers;
    streamOut << keyPressed;

    udpSocket->writeDatagram(data, tcpSocket->peerAddress(), m_port);
}

void QRemoteControlClient::sendButton(quint8 id, bool keyPressed)
{
    quint8 mode1 = 5;

    QByteArray data;
    QDataStream streamOut(&data, QIODevice::WriteOnly);
    streamOut << mode1;
    streamOut << id;
    streamOut << keyPressed;

    udpSocket->writeDatagram(data, tcpSocket->peerAddress(), m_port);
}

void QRemoteControlClient::sendKeyPress(quint8 id)
{
    sendButton(id, true);
}

void QRemoteControlClient::sendKeyRelease(quint8 id)
{
   sendButton(id, false);
}

 void QRemoteControlClient::sendMouseMove(int deltaX, int deltaY)
 {
     QPoint delta(deltaX, deltaY);

     if (delta == QPoint(0,0))
         return;

    quint8 mode1 = 2;
    quint8 mode2 = 0;

    QByteArray data;
    QDataStream streamOut(&data, QIODevice::WriteOnly);
    streamOut << mode1;
    streamOut << mode2;
    streamOut << delta;

    udpSocket->writeDatagram(data, tcpSocket->peerAddress(), m_port);
 }

 void QRemoteControlClient::sendHorizontalScroll(int delta)
 {
     sendMouseScroll(1,delta);
 }

 void QRemoteControlClient::sendVerticalScroll(int delta)
 {
     sendMouseScroll(2,delta);
 }

 void QRemoteControlClient::sendMouseScroll(quint8 direction, qint8 delta)
 {
     if (delta == 0)
         return;

     quint8 mode1 = 2;
     quint8 mode2 = 2;

     QByteArray data;
     QDataStream streamOut(&data, QIODevice::WriteOnly);
     streamOut << mode1;
     streamOut << mode2;
     streamOut << direction;
     streamOut << delta;

     udpSocket->writeDatagram(data, tcpSocket->peerAddress(), m_port);
 }

 void QRemoteControlClient::sendMouseButton(quint8 button, bool buttonPressed)
 {
     quint8 mode1 = 2;
     quint8 mode2 = 1;

     QByteArray data;
     QDataStream streamOut(&data, QIODevice::WriteOnly);
     streamOut << mode1;
     streamOut << mode2;
     streamOut << button;
     streamOut << buttonPressed;

     udpSocket->writeDatagram(data, tcpSocket->peerAddress(), m_port);
 }

 void QRemoteControlClient::sendMousePress(quint8 button)
 {
     sendMouseButton(button, true);
 }

 void QRemoteControlClient::sendMouseRelease(quint8 button)
 {
     sendMouseButton(button, false);
 }

 void QRemoteControlClient::sendControlClicked(bool down)
 {
     sendKey(Qt::Key_unknown, Qt::ControlModifier, down);
 }

 void QRemoteControlClient::sendAltClicked(bool down)
 {
     sendKey(Qt::Key_unknown, Qt::AltModifier, down);
 }

 void QRemoteControlClient::sendShiftClicked(bool down)
 {
     sendKey(Qt::Key_unknown, Qt::ShiftModifier, down);
 }

void QRemoteControlClient::sendAction(int id, bool pressed)
{
    quint8 mode1 = 3;

    QByteArray data;
    QDataStream streamOut(&data, QIODevice::WriteOnly);
    streamOut << mode1;
    streamOut << (quint8)id;
    streamOut << pressed;

    udpSocket->writeDatagram(data, tcpSocket->peerAddress(), m_port);
}

void QRemoteControlClient::sendLight(int code)
{
    quint8 mode1 = 4;

    QByteArray data;
    QDataStream streamOut(&data, QIODevice::WriteOnly);
    streamOut << mode1;
    streamOut << (quint16)code;

    udpSocket->writeDatagram(data, tcpSocket->peerAddress(), m_port);
}

void QRemoteControlClient::sendText(QString text)
{
    quint8 mode1 = 8;

    QByteArray data;
    QDataStream streamOut(&data, QIODevice::WriteOnly);
    streamOut << mode1;
    streamOut << text;

    udpSocket->writeDatagram(data, tcpSocket->peerAddress(), m_port);
}

void QRemoteControlClient::sendKeepAlive()
{
    quint8 mode1 = 6;

    QByteArray data;
    QDataStream streamOut(&data, QIODevice::WriteOnly);
    streamOut << mode1;

    udpSocket->writeDatagram(data, tcpSocket->peerAddress(), m_port);
}

void QRemoteControlClient::sendVersion()
{
    quint8 mode1 = 7;

    QByteArray data;
    QDataStream streamOut(&data, QIODevice::WriteOnly);
    streamOut << mode1;
    streamOut << QString(VERSION);

    udpSocket->writeDatagram(data, tcpSocket->peerAddress(), m_port);
}

void QRemoteControlClient::disconnect()
{
    deleteConnection();
}

bool QRemoteControlClient::isConnected()
{
    if (tcpSocket == NULL)
    {
        return false;
    }

    return (tcpSocket->state() == QAbstractSocket::ConnectedState);
}
