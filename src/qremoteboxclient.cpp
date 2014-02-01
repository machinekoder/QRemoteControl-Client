#include "qremoteboxclient.h"
#include "crc.h"
#include <QtGui>

QRemoteBoxClient::QRemoteBoxClient(QObject *parent) :
    QObject(parent)
{
    crcInit();
    base64 = new Base64();

    m_responseTimeout = 3000;
    m_keepAliveTimeout = 5000;
    m_commandDelay = 10;
    m_queueRunning = false;
    m_autoconnectEnabled = true;
    m_networkConnected = false;
    m_serialPortConnected = false;

#ifdef SERIALPORT
    serialPort = NULL;
#endif
    tcpSocket = NULL;

    waitingForRespose = false;
    wantsConnection = false;

    responseTimer = new QTimer(this);
    responseTimer->setInterval(1);
    connect(responseTimer, SIGNAL(timeout()),
            this, SLOT(responseTimerTick()));

    keepAliveTimer = new QTimer(this);
    keepAliveTimer->setInterval(m_keepAliveTimeout);
    connect(keepAliveTimer, SIGNAL(timeout()),
            this, SLOT(keepAliveTimerTick()));
}

QRemoteBoxClient::~QRemoteBoxClient()
{
#ifdef SERIALPORT
    if (serialPort != NULL)
        serialPort->close();
#endif

    if (tcpSocket != NULL)
        tcpSocket->close();
}

#ifdef SERIALPORT
bool IRemote::connectSerialPort(const QString &device)
{
    if (serialPort != NULL)
        closeSerialPort();

    serialPort = new SerialPort(this);
    serialPort->setPort(device);
    serialPort->setDataBits(SerialPort::Data8);
    serialPort->setParity(SerialPort::NoParity);
    serialPort->setStopBits(SerialPort::OneStop);
    serialPort->setRate(115200);
    if (serialPort->open(QIODevice::ReadWrite))
    {
        connect(serialPort, SIGNAL(readyRead()),
                this, SLOT(incomingSerialData()));
        activeConnections |= SerialConnection;

        refreshStoredCommands();

        m_serialPortConnected = true;
        emit serialPortConnectedChanged(true);
        serialPort->write("\r");

        qDebug() << "IRemote: connected to serial device";
        return true;
    }
    else
    {
        qDebug() << "IRemote: not connected to serial device";
        return false;
    }

}


void IRemote::closeSerialPort()
{
    serialPort->close();
    serialPort->deleteLater();
    serialPort = NULL;
    activeConnections &= ~SerialConnection;
    m_serialPortConnected = false;
    emit serialPortConnectedChanged(false);
    endQueue();
}
#endif

void QRemoteBoxClient::connectNetwork(QString hostname, int port)
{
    if (tcpSocket != NULL)
        closeNetwork();

    tcpSocket = new QTcpSocket(this);
    tcpSocket->connectToHost(hostname, port);

    setNetworkHostname(hostname);
    setNetworkPort(port);
    wantsConnection = true;

    connect(tcpSocket, SIGNAL(connected()),
            this, SLOT(tcpSocketConnected()));
    connect(tcpSocket, SIGNAL(disconnected()),
            this, SLOT(tcpSocketDisconnected()));
    connect(tcpSocket, SIGNAL(readyRead()),
            this, SLOT(incomingNetworkData()));
    connect(tcpSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(tcpSocketError(QAbstractSocket::SocketError)));
}

void QRemoteBoxClient::connectToHost()
{
    connectNetwork(m_networkHostname, m_networkPort);
}

void QRemoteBoxClient::closeNetwork()
{
    if ((tcpSocket != NULL) && (tcpSocket->state() == QAbstractSocket::ConnectedState))
        tcpSocket->disconnectFromHost();
    tcpSocket = NULL;
    activeConnections &= ~NetworkConnection;
    wantsConnection = false;
    endQueue();
    clearQueue();
    keepAliveTimer->stop();

    m_networkConnected = false;
    emit networkConnectedChanged(false);
    emit disconnected();
}

void QRemoteBoxClient::setWlanSsid(const QString &ssid)
{
    QueueCommand command;
    command.commandType = SetWlanSsidCommand;
    command.command = QString("set w s %1\r").arg(ssid).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setWlanPhrase(const QString &phrase)
{
    QueueCommand command;
    command.commandType = SetWlanPhraseCommand;
    command.command = QString("set w p %1\r").arg(phrase).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setWlanKey(const QString &key)
{
    QueueCommand command;
    command.commandType = SetWlanKeyCommand;
    command.command = QString("set w k %1\r").arg(key).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setWlanHostname(const QString &hostname)
{
    QueueCommand command;
    command.commandType = SetWlanHostnameCommand;
    command.command = QString("set w h %1\r").arg(hostname).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setWlanAuth(QRemoteBoxClient::WlanAuthType mode)
{
    QueueCommand command;
    command.commandType = SetWlanAuthCommand;
    command.command = QString("set w a %1\r").arg((int)mode).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setWlanDhcpMethod(QRemoteBoxClient::IpDhcpMethod method)
{
    QueueCommand command;
    command.commandType = SetWlanDhcpCommand;
    command.command = QString("set w d %1\r").arg((int)method).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setWlanIpAddress(const QString address)
{
    QueueCommand command;
    command.commandType = SetWlanIpCommand;
    command.command = QString("set w i %1\r").arg(address).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setWlanSubnetMask(const QString address)
{
    QueueCommand command;
    command.commandType = SetWlanMaskCommand;
    command.command = QString("set w m %1\r").arg(address).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setWlanGateway(const QString address)
{
    QueueCommand command;
    command.commandType = SetWlanGatewayCommand;
    command.command = QString("set w g %1\r").arg(address).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setWlanPrimaryDnsAddress(const QString address)
{
    QueueCommand command;
    command.commandType = SetWlanDnsCommand;
    command.command = QString("set w d %1\r").arg(address).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setWlanSecondaryDnsAddress(const QString address)
{
    QueueCommand command;
    command.commandType = SetWlanBackupDnsCommand;
    command.command = QString("set w b %1\r").arg(address).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setIrCount(int times)
{
    QueueCommand command;
    command.commandType = SetIrCountCommand;
    command.command = QString("set i c %1\r").arg(times).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setIrReceiveTimeout(int ms)
{
    QueueCommand command;
    command.commandType = SetIrReceiveTimeoutCommand;
    command.command = QString("set i r %1\r").arg(ms).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setIrSendTimeout(int ms)
{
    QueueCommand command;
    command.commandType = SetIrSendTimeoutCommand;
    command.command = QString("set i s %1\r").arg(ms).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setRadio433Count(int times)
{
    QueueCommand command;
    command.commandType = Set433CountCommand;
    command.command = QString("set 4 c %1\r").arg(times).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setRadio433ReceiveTimeout(int ms)
{
    QueueCommand command;
    command.commandType = Set433ReceiveTimeoutCommand;
    command.command = QString("set 4 r %1\r").arg(ms).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setRadio433SendTimeout(int ms)
{
    QueueCommand command;
    command.commandType = Set433SendTimeoutCommand;
    command.command = QString("set 4 s %1\r").arg(ms).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setRadio868Count(int times)
{
    QueueCommand command;
    command.commandType = Set868CountCommand;
    command.command = QString("set 8 c %1\r").arg(times).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setRadio868ReceiveTimeout(int ms)
{
    QueueCommand command;
    command.commandType = Set868ReceiveTimeoutCommand;
    command.command = QString("set 8 r %1\r").arg(ms).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setRadio868SendTimeout(int ms)
{
    QueueCommand command;
    command.commandType = Set868SendTimeoutCommand;
    command.command = QString("set 8 s %1\r").arg(ms).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::setDebugMode(bool enabled)
{
    QueueCommand command;
    command.commandType = SetDebugModeCommand;
    command.command = QString("set d %1\r").arg((int)(enabled)).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getWlanSsid()
{
    QueueCommand command;
    command.commandType = GetWlanSsidCommand;
    command.command = QString("get w s\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getWlanPhrase()
{
    QueueCommand command;
    command.commandType = GetWlanPhraseCommand;
    command.command = QString("get w p\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getWlanKey()
{
    QueueCommand command;
    command.commandType = GetWlanKeyCommand;
    command.command = QString("get w k\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getWlanHostname()
{
    QueueCommand command;
    command.commandType = GetWlanHostnameCommand;
    command.command = QString("get w h\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getWlanAuth()
{
    QueueCommand command;
    command.commandType = GetWlanAuthCommand;
    command.command = QString("get w a\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getWlanDhcpMethod()
{
    QueueCommand command;
    command.commandType = GetWlanDhcpCommand;
    command.command = QString("get w d\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getWlanIpAddress()
{
    QueueCommand command;
    command.commandType = GetWlanIpCommand;
    command.command = QString("get w i\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getWlanSubnetMask()
{
    QueueCommand command;
    command.commandType = GetWlanMaskCommand;
    command.command = QString("get w m\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getWlanGateway()
{
    QueueCommand command;
    command.commandType = GetWlanGatewayCommand;
    command.command = QString("get w g\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getWlanPrimaryDnsAddress()
{
    QueueCommand command;
    command.commandType = GetWlanDnsCommand;
    command.command = QString("get w d\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getWlanSecondaryDnsAddress()
{
    QueueCommand command;
    command.commandType = GetWlanBackupDnsCommand;
    command.command = QString("get w b\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getIrCount()
{
    QueueCommand command;
    command.commandType = GetIrCountCommand;
    command.command = QString("get i c\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getIrReceiveTimeout()
{
    QueueCommand command;
    command.commandType = GetIrReceiveTimeoutCommand;
    command.command = QString("get i r\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getIrSendTimeout()
{
    QueueCommand command;
    command.commandType = GetIrSendTimeoutCommand;
    command.command = QString("get i s\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getRadio433Count()
{
    QueueCommand command;
    command.commandType = Get433CountCommand;
    command.command = QString("get 4 c\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getRadio433ReceiveTimeout()
{
    QueueCommand command;
    command.commandType = Get433ReceiveTimeoutCommand;
    command.command = QString("get 4 r\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getRadio433SendTimeout()
{
    QueueCommand command;
    command.commandType = Get433SendTimeoutCommand;
    command.command = QString("get 4 s\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getRadio868Count()
{
    QueueCommand command;
    command.commandType = Get868CountCommand;
    command.command = QString("get 8 c\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getRadio868ReceiveTimeout()
{
    QueueCommand command;
    command.commandType = Get868ReceiveTimeoutCommand;
    command.command = QString("get 8 r\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getRadio868SendTimeout()
{
    QueueCommand command;
    command.commandType = Get868SendTimeoutCommand;
    command.command = QString("get 8 s\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::getDebugMode()
{
    QueueCommand command;
    command.commandType = GetDebugModeCommand;
    command.command = QString("get d\r").toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::runCommand(RemoteCommand remoteCommand)
{
    QByteArray data;

    data.append("run c ");
    data.append(base64->encode((quint8*)&remoteCommand,sizeof(RemoteCommand)));
    data.append("\r");

    QueueCommand command;
    command.commandType = RunCommandCommand;
    command.command = data;
    command.response = "Idle";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::runData(int pos)
{
    QueueCommand command;
    command.commandType = RunDataCommand;
    command.command = QString("run d %1\r").arg(pos).toLocal8Bit();
    command.response = "Idle";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::captureIr()
{
    QueueCommand command;
    command.commandType = CaptureIrCommand;
    command.command = "capture ir\r";
    command.response = "Capturing IR data";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();

    pauseKeepAlive(m_responseTimeout*20);   // let there be enough time to capture signals
}

void QRemoteBoxClient::captureRadio433MHz()
{
    QueueCommand command;
    command.commandType = Capture433Command;
    command.command = "capture 433\r";
    command.response = "Capturing 433MHz data";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();

    pauseKeepAlive(m_responseTimeout*20);   // let there be enough time to capture signals
}

void QRemoteBoxClient::captureRadio868MHz()
{
    QueueCommand command;
    command.commandType = Capture868Command;
    command.command = "capture 868\r";
    command.response = "Capturing 868MHz data";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();

    pauseKeepAlive(m_responseTimeout*20);   // let there be enough time to capture signals
}

void QRemoteBoxClient::startWlanAp()
{
    QueueCommand command;
    command.commandType = StartWlanApCommand;
    command.command = "start w a\r";
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::startWlanInfrastructure()
{
    QueueCommand command;
    command.commandType = StartWlanInfrastructureCommand;
    command.command = "start w i\r";
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::saveConfig()
{
    QueueCommand command;
    command.commandType = SaveConfigCommand;
    command.command = "save c\r";
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::stop()
{
    QueueCommand command;
    command.commandType = StopCommand;
    command.command = "stop\r";
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::dataAdd(QRemoteBoxClient::StorageItem storageItem)
{
    QByteArray data;

    data.append("data a ");
    data.append(base64->encode((quint8*)&storageItem,sizeof(StorageItem)));
    data.append("\r");

    QueueCommand command;
    command.commandType = DataAddCommand;
    command.command = data;
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::dataUpdate(int pos, QRemoteBoxClient::StorageItem storageItem)
{
    QByteArray data;

    data.append(QString("data u  %1 ").arg(pos).toLocal8Bit());
    data.append(base64->encode((quint8*)&storageItem,sizeof(StorageItem)));
    data.append("\r");

    QueueCommand command;
    command.commandType = DataAddCommand;
    command.command = data;
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::dataGetName(int pos, QueueCommandType commandType)
{
    QueueCommand command;
    command.commandType = DataGetNameCommand;
    command.command = QString("data g n %1\r").arg(pos).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = commandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::dataGetData(int pos)
{
    QueueCommand command;
    command.commandType = DataGetDataCommand;
    command.command = QString("data g d %1\r").arg(pos).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::dataGetCount(QueueCommandType commandType)
{
    QueueCommand command;
    command.commandType = DataGetCountCommand;
    command.command = "data g c\r";
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = commandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::dataSwap(int pos1, int pos2)
{
    QueueCommand command;
    command.commandType = DataSwapCommand;
    command.command = QString("data s %1 %2\r").arg(pos1).arg(pos2).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::dataRemove(int pos)
{
    QueueCommand command;
    command.commandType = DataRemoveCommand;
    command.command = QString("data r %1\r").arg(pos).toLocal8Bit();
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::dataEraseAll()
{
    QueueCommand command;
    command.commandType = DataEraseAllCommand;
    command.command = "data e\r";
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::factoryReset()
{
    QueueCommand command;
    command.commandType = FactoryResetCommand;
    command.command = "factory RESET\r";
    command.response = "ACK";
    command.timeout = m_responseTimeout;
    command.type = NormalQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::sendKeepAlive()
{
    QueueCommand command;
    command.commandType = AliveCommand;
    command.command = "alive\r";
    command.response = "yes";
    command.timeout = m_keepAliveTimeout;
    command.type = KeepAliveQueueCommandType;

    commandQueue.enqueue(command);
    startQueue();
}

void QRemoteBoxClient::flashFirmware(QString filename)
{
    // here the flashing is happening
    QFile file(filename);
    QByteArray data;

    if (file.open(QIODevice::ReadOnly))
    {
        int size;
        quint16 checksum;
        QByteArray commandData;

        data = file.readAll();

        // split the file in 100 bytes parts
        for (int i = 0; i < data.size(); i+=100)
        {
            if (i+100 < data.size())
                size = 100;
            else
                size = data.size() - i;

            checksum = crcFast(&(data.data()[i]), size);//qChecksum(&(data.data()[i]), size);

            commandData.clear();
            commandData.append("flash ");
            commandData.append(dataToHex(&(data.data()[i]),size));
            commandData.append(" ");
            commandData.append(QString("%1").arg(checksum,4,16,QLatin1Char('0')));
            commandData.append("\r");

            qDebug() << checksum;

            QueueCommand command;
            command.commandType = FlashCommand;
            command.command = commandData;
            command.response = "ACK";
            command.timeout = m_responseTimeout;
            command.type = NormalQueueCommandType;

            commandQueue.enqueue(command);
            startQueue();
        }

    }
}

#if 0
QRemoteBoxClient::RemoteCommand QRemoteBoxClient::generateIntertechnoCommand(char houseCode, int deviceCode, bool enable)
{
    static const int smallClock = 300;
    static const int bigClock = 1000;

    RemoteCommand command;

    command.medium = RemoteMedium_433MHz;
    command.id = 1;
    command.length = 48;
    command.frequency = 43392;
    command.version = 1;
}
#endif

void QRemoteBoxClient::refreshStoredCommands()
{
    m_storedCommands.clear();
    emit storedCommandsChanged(m_storedCommands);

    if (activeConnections == 0)  // refresh only if connected
    {
        return;
    }

    dataGetCount(StoredCommandsRefreshQueueCommandType);
}

#ifdef SERIALPORT
void IRemote::incomingSerialData()
{
    QByteArray data;
    while (serialPort->bytesAvailable() != 0)
    {
       data = serialPort->read(1);
       incomingByte(data.at(0));
    }
}
#endif

void QRemoteBoxClient::incomingNetworkData()
{
    QByteArray data;

    if ((tcpSocket == NULL))
        return;

    while ((tcpSocket != NULL) && (tcpSocket->bytesAvailable() != 0))
    {
       data = tcpSocket->read(1);
       incomingByte(data.at(0));
    }
}

void QRemoteBoxClient::incomingByte(char byte)
{
    qDebug() << "IRemote received:" << byte;

    if (waitingForRespose)
    {
        responseTimer->stop();
        responseTimer->start();

        dataBuffer.append(byte);    // save the received data

        if (byte != responseString.at(responseOffset))
        {
            responseOffset = 0;

            if (byte != responseString.at(0))
            {
                responseOffset = -1;
            }
        }

        if (responseOffset < (responseString.length()-1))
            responseOffset++;
        else    // matched
        {
            // clear the data buffer
            dataBuffer.chop(responseString.length()); // remove the response message from the data
            dataBuffer.append('\0');
            receivedData = QString(dataBuffer);
            dataBuffer.clear();

            responseTimer->stop();
            waitingForRespose = false;
            responseReceived(currentCommand.type, currentCommand.commandType, receivedData);
            return;
        }

        return;
    }

    if (byte != '\r')
    {
        dataBuffer.append(byte);
    }
    else
    {
        receivedCommand(dataBuffer);
        dataBuffer.clear();
    }
}

void QRemoteBoxClient::tcpSocketConnected()
{
    activeConnections |= NetworkConnection;

    QTimer::singleShot(50, this, SLOT(sendKeepAlive()));
    QTimer::singleShot(100, this, SLOT(refreshStoredCommands()));

    keepAliveTimer->start();

    m_networkConnected = true;
    emit networkConnectedChanged(true);
    emit connected();

    qDebug() << "IRemote: connected to network device";
}

void QRemoteBoxClient::tcpSocketDisconnected()
{
    qDebug() << "IRemote: disconnected network device";
    closeNetwork();
}

void QRemoteBoxClient::tcpSocketError(QAbstractSocket::SocketError error)
{
    if (error == QAbstractSocket::NetworkError)
        qDebug() << "IRemote: network error";

    qDebug() << error;
}

void QRemoteBoxClient::responseTimerTick()
{
    responseTimer->stop();
    waitingForRespose = false;
    responseTimedOut(currentCommand.type);
}

void QRemoteBoxClient::keepAliveTimerTick()
{
    if (!keepAliveTimer->isActive())
        keepAliveTimer->start();

    if ((activeConnections == NoConnection) || isQueueRunning())    // if no connection or queue running no timeout is needed
    {
        if ((activeConnections == NoConnection) && autoconnectEnabled() && wantsConnection)
        {
            connectNetwork(networkHostname(), networkPort());
        }
    }
    else
    {
        sendKeepAlive();
    }
}

QByteArray QRemoteBoxClient::dataToHex(const char *data, int size)
{
    QByteArray bytes;
    for (int i = 0; i < size; i++)
    {
        bytes.append(QString("%1").arg((quint8)(data[i]),
                                      2,
                                      16,
                                      QLatin1Char('0')));
    }

    return bytes;
}

void QRemoteBoxClient::receivedCommand(QByteArray command)
{
    const QByteArray dataCode("*DATA");

    if (command.size() == 0)
        return;

    if (command.at(0) == '*')   // this command sends us something necessary
    {
        if (command.indexOf(dataCode) == 0)
        {
            QByteArray resultingCommand;

            command.remove(0,dataCode.length());
            resultingCommand = base64->decode(command.data(),command.length());

            RemoteCommand remoteCommand;
            memcpy(&remoteCommand,resultingCommand.data(), sizeof(RemoteCommand));

            responseTimer->stop();                  // stop the response timer, as we alredy have received what we need
            waitingForRespose = false;
            emit remoteCommandReceived(remoteCommand);  // and this is blocking
            //processResponse(currentCommand.commandType, QString(command));
        }
    }

        qDebug() << "IRemote received:" << command;
}

void QRemoteBoxClient::sendData(const QByteArray &data)
{
    if (activeConnections & NetworkConnection)
    {
        tcpSocket->write(data);
    }
#ifdef SERIALPORT
    else if (activeConnections & SerialConnection)
    {
        serialPort->flush();
        serialPort->write(data);
    }
#endif
}

void QRemoteBoxClient::findInResponse(QString toMatch, int timeout)
{
    responseString = toMatch;
    responseOffset = 0;

    waitingForRespose = true;

    responseTimer->setInterval(timeout);
    responseTimer->start();
}

void QRemoteBoxClient::responseReceived(QueueCommandType type, Command command, QString responseData)
{
    if (type == NormalQueueCommandType)
    {
        processResponse(command, responseData);
        QTimer::singleShot(m_commandDelay, this, SLOT(doQueue()));
    }
    else if (type == KeepAliveQueueCommandType)
    {
        qDebug() << "keep alive response received";
        QTimer::singleShot(m_commandDelay, this, SLOT(doQueue()));
    }
    else if (type == StoredCommandsRefreshQueueCommandType)
    {
        processStoredCommandsRefreshResponse(command, responseData);
        QTimer::singleShot(m_commandDelay, this, SLOT(doQueue()));
    }
}

void QRemoteBoxClient::responseTimedOut(QueueCommandType type)
{
    if (type == NormalQueueCommandType)
    {
        emit commandTimedOut(currentCommand.commandType);
        error("Response timeout");
        QTimer::singleShot(m_commandDelay, this, SLOT(doQueue()));
    }
    else if (type == KeepAliveQueueCommandType)
    {
        error("Keep alive timeout");
        endQueue();

        if (activeConnections & NetworkConnection)
        {
            activeConnections &= ~NetworkConnection;
            closeNetwork();
            wantsConnection = true; // we lost the connection but we want it
        }
#ifdef SERIALPORT
        if (activeConnections & SerialConnection)
        {
            activeConnections &= ~SerialConnection;
            closeSerialPort();
        }
#endif
    }
    else if (type == StoredCommandsRefreshQueueCommandType)
    {
        qDebug() << "Stored commands refresh timed out";
        QTimer::singleShot(m_commandDelay, this, SLOT(doQueue()));
    }
}

void QRemoteBoxClient::processResponse(QRemoteBoxClient::Command command, QString responseData)
{
    QVariant data;
    QByteArray resultingData;
    StorageItem storageItem;

    switch (command)
    {
    case GetWlanSsidCommand:
    case GetWlanPhraseCommand:
    case GetWlanKeyCommand:
    case GetWlanHostnameCommand:
    case GetWlanIpCommand:
    case GetWlanMaskCommand:
    case GetWlanGatewayCommand:
    case GetWlanDnsCommand:
    case GetWlanBackupDnsCommand:
    case DataGetNameCommand:
        data = QVariant::fromValue(responseData); break;
    case GetIrCountCommand:
    case GetIrReceiveTimeoutCommand:
    case GetIrSendTimeoutCommand:
    case Get433CountCommand:
    case Get433ReceiveTimeoutCommand:
    case Get433SendTimeoutCommand:
    case Get868CountCommand:
    case Get868ReceiveTimeoutCommand:
    case Get868SendTimeoutCommand:
    case DataGetCountCommand:
        data = QVariant::fromValue(responseData.toInt()); break;
    case GetDebugModeCommand:
        data = QVariant::fromValue((bool)responseData.toInt()); break;
    case GetWlanAuthCommand:
        data = QVariant::fromValue(static_cast<WlanAuthType>(receivedData.toInt())); break;
    case GetWlanDhcpCommand:
        data = QVariant::fromValue(static_cast<IpDhcpMethod>(receivedData.toInt())); break;
    case DataGetDataCommand:
        resultingData = base64->decode(responseData.toLocal8Bit(), (quint16)responseData.length());
        memcpy((void*)&storageItem,(void*)resultingData.data(), sizeof(StorageItem));
        data = QVariant::fromValue(storageItem);
        break;
    case DataAddCommand:
    case DataEraseAllCommand:
    case DataRemoveCommand:
    case DataSwapCommand:
        refreshStoredCommands();
        break;
    default: data = QVariant();break;
    }

    emit commandFinished(command, data);
}

void QRemoteBoxClient::processStoredCommandsRefreshResponse(QRemoteBoxClient::Command command, QString responseData)
{
    switch (command)
    {
    case DataGetCountCommand:
        storageCommandCount = responseData.toInt();
        if (storageCommandCount > 0)
        {
            dataGetName(0, StoredCommandsRefreshQueueCommandType);
        }
        break;
    case DataGetNameCommand:
        m_storedCommands.append(responseData.trimmed());
        if (m_storedCommands.size() < storageCommandCount)
        {
            dataGetName(m_storedCommands.size(), StoredCommandsRefreshQueueCommandType);
        }
        else
        {
            emit storedCommandsChanged(m_storedCommands);
        }
        break;
    default: /* do nothing */;
    }
}

void QRemoteBoxClient::startQueue()
{
    if (isQueueRunning())
        return;

    dataBuffer.clear();     // if there is something in the buffer, just clear it

    doQueue();

    queueStarted();
    setQueueRunning(true);
}

void QRemoteBoxClient::doQueue()
{

    if (commandQueue.isEmpty())
    {
        emit queueFinished();
        setQueueRunning(false);
        keepAliveTimer->start();

        return;
    }

    keepAliveTimer->stop();
    currentCommand = commandQueue.dequeue();

    sendData(currentCommand.command);
    findInResponse(currentCommand.response, currentCommand.timeout);
}

void QRemoteBoxClient::endQueue()
{
    setQueueRunning(false);
}

void QRemoteBoxClient::clearQueue()
{
    commandQueue.clear();
}

void QRemoteBoxClient::pauseKeepAlive(int msecs)
{
    keepAliveTimer->stop();
    QTimer::singleShot(msecs, this, SLOT(keepAliveTimerTick()));
}
