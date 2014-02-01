#ifndef IREMOTE_H
#define IREMOTE_H

#define IR_MAX_TRANSITIONS 100

#include <QObject>
#include <QTcpSocket>
#include <QQueue>
#include <QTimer>
#include <QtGui>
#include <base64.h>

class QRemoteBoxClient : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int responseTimeout READ responseTimeout WRITE setResponseTimeout NOTIFY responseTimeoutChanged)
    Q_PROPERTY(bool queueRunning READ isQueueRunning WRITE setQueueRunning NOTIFY queueRunningChanged)
    Q_PROPERTY(int keepAliveTimeout READ keepAliveTimeout WRITE setKeepAliveTimeout)
    Q_PROPERTY(int commandDelay READ commandDelay WRITE setCommandDelay)
    Q_PROPERTY(bool autoconnectEnabled READ autoconnectEnabled WRITE setAutoconnectEnabled NOTIFY autoconnectEnabledChanged)
    Q_PROPERTY(QString networkHostname READ networkHostname WRITE setNetworkHostname NOTIFY networkHostnameChanged)
    Q_PROPERTY(int networkPort READ networkPort WRITE setNetworkPort NOTIFY networkPortChanged)
    Q_PROPERTY(bool networkConnected READ isNetworkConnected NOTIFY networkConnectedChanged)
    Q_PROPERTY(bool serialPortConnected READ isSerialPortConnected NOTIFY serialPortConnectedChanged)
    Q_PROPERTY(QStringList storedCommands READ storedCommands NOTIFY storedCommandsChanged)

    Q_FLAGS(ActiveConnection ActiveConnections)

public:

    enum WlanAuthType {
        OpenAuthType = 0,
        WEP128AuthType = 1,
        WPA1AuthType = 2,
        MixedWPA1AndWPA2PSKAuthType = 3,
        WPA2PSKAuthType = 4,
        AdhocAuthType = 6,
        WPE64AuthType = 7
    };
    Q_ENUMS(WlanAuthType)

    enum IpDhcpMethod {
        DhcpOffMethod = 0,
        DhcpOnMethod = 1,
        AutoIpMethod = 2,
        DhcpCacheMethod = 3
    };
    Q_ENUMS(IpDhcpMethod)

    enum Command {
        AliveCommand,
        RunCommandCommand,
        RunDataCommand,
        CaptureIrCommand,
        Capture433Command,
        Capture868Command,
        StopCommand,
        FlashCommand,
        SetWlanSsidCommand,
        SetWlanPhraseCommand,
        SetWlanKeyCommand,
        SetWlanHostnameCommand,
        SetWlanAuthCommand,
        SetWlanDhcpCommand,
        SetWlanIpCommand,
        SetWlanMaskCommand,
        SetWlanGatewayCommand,
        SetWlanDnsCommand,
        SetWlanBackupDnsCommand,
        SetIrReceiveTimeoutCommand,
        SetIrSendTimeoutCommand,
        SetIrCountCommand,
        Set433ReceiveTimeoutCommand,
        Set433SendTimeoutCommand,
        Set433CountCommand,
        Set868ReceiveTimeoutCommand,
        Set868SendTimeoutCommand,
        Set868CountCommand,
        SetDebugModeCommand,
        GetWlanSsidCommand,
        GetWlanPhraseCommand,
        GetWlanKeyCommand,
        GetWlanHostnameCommand,
        GetWlanAuthCommand,
        GetWlanDhcpCommand,
        GetWlanIpCommand,
        GetWlanMaskCommand,
        GetWlanGatewayCommand,
        GetWlanDnsCommand,
        GetWlanBackupDnsCommand,
        GetIrReceiveTimeoutCommand,
        GetIrSendTimeoutCommand,
        GetIrCountCommand,
        Get433ReceiveTimeoutCommand,
        Get433SendTimeoutCommand,
        Get433CountCommand,
        Get868ReceiveTimeoutCommand,
        Get868SendTimeoutCommand,
        Get868CountCommand,
        GetDebugModeCommand,
        StartWlanApCommand,
        StartWlanInfrastructureCommand,
        StartFlashCommand,
        SaveConfigCommand,
        DataAddCommand,
        DataGetNameCommand,
        DataGetDataCommand,
        DataGetCountCommand,
        DataSwapCommand,
        DataRemoveCommand,
        DataEraseAllCommand,
        FactoryResetCommand
    };
    Q_ENUMS(Command)

    enum RemoteMedium {
        RemoteMedium_Ir = 0,
        RemoteMedium_433MHz = 1,
        RemoteMedium_868MHz = 2
    };
    Q_ENUMS(RemoteMedium)

    enum QueueCommandType {
        NormalQueueCommandType = 0,
        KeepAliveQueueCommandType = 1,
        GroupQueueCommandType = 2,
        StoredCommandsRefreshQueueCommandType = 3
    };
    Q_ENUMS(QueueCommandType)

    enum ActiveConnection {
        NoConnection = 0x00,
        SerialConnection = 0x01,
        NetworkConnection = 0x02
    };
    Q_DECLARE_FLAGS(ActiveConnections, ActiveConnection)

    typedef struct
    {
        quint8 version;
        char commandName[50u];
        quint8 reserved[100u];
    } CommandHeader;

    typedef struct {
        quint8   version;
        quint16  id;
        quint8   length;
        quint8   medium;
        quint32  frequency;
        quint16  data[IR_MAX_TRANSITIONS];
    } RemoteCommand;

    typedef struct
    {
        CommandHeader commandHeader;
        RemoteCommand remoteCommand;
    } StorageItem;

    typedef struct {
        Command    commandType;
        QByteArray command;
        QByteArray response;
        int timeout;
        QueueCommandType type;//= NormalQueueCommandType;
    } QueueCommand;

    explicit QRemoteBoxClient(QObject *parent = 0);
    ~QRemoteBoxClient();

#if 0
    static RemoteCommand generateIntertechnoCommand(char houseCode, int deviceCode, bool enable);
#endif

    int responseTimeout() const
    {
        return m_responseTimeout;
    }

    bool isQueueRunning() const
    {
        return m_queueRunning;
    }

    int keepAliveTimeout() const
    {
        return m_keepAliveTimeout;
    }

    bool autoconnectEnabled() const
    {
        return m_autoconnectEnabled;
    }

    QString networkHostname() const
    {
        return m_networkHostname;
    }

    int networkPort() const
    {
        return m_networkPort;
    }

    bool isNetworkConnected() const
    {
        return m_networkConnected;
    }

    bool isSerialPortConnected() const
    {
        return m_serialPortConnected;
    }

    QStringList storedCommands() const
    {
        return m_storedCommands;
    }

    int commandDelay() const
    {
        return m_commandDelay;
    }

signals:
    void remoteCommandReceived(QRemoteBoxClient::RemoteCommand remoteCommand);
    void networkConnectedChanged(bool arg);
    void serialPortConnectedChanged(bool arg);
    void connected();
    void disconnected();

    void responseTimeoutChanged(int arg);

    void commandFinished(QRemoteBoxClient::Command command, QVariant data);
    void commandTimedOut(QRemoteBoxClient::Command command);
    void queueFinished();
    void queueStarted();

    void error(QString text);

    void queueRunningChanged(bool arg);
    void autoconnectEnabledChanged(bool arg);
    void networkHostnameChanged(QString arg);
    void networkPortChanged(int arg);
    void storedCommandsChanged(QStringList arg);

public slots:

#ifdef SERIALPORT
    bool connectSerialPort(const QString &device);
    void closeSerialPort();
#endif
    void connectNetwork(QString hostname, int port);
    void connectToHost();
    void closeNetwork();

    void setWlanSsid(const QString &ssid);
    void setWlanPhrase(const QString &phrase);
    void setWlanKey(const QString &key);
    void setWlanHostname(const QString &hostname);
    void setWlanAuth(WlanAuthType mode);
    void setWlanDhcpMethod(IpDhcpMethod method);
    void setWlanIpAddress(const QString address);
    void setWlanSubnetMask(const QString address);
    void setWlanGateway(const QString address);
    void setWlanPrimaryDnsAddress(const QString address);
    void setWlanSecondaryDnsAddress(const QString address);
    void setIrCount(int times);
    void setIrReceiveTimeout(int ms);
    void setIrSendTimeout(int ms);
    void setRadio433Count(int times);
    void setRadio433ReceiveTimeout(int ms);
    void setRadio433SendTimeout(int ms);
    void setRadio868Count(int times);
    void setRadio868ReceiveTimeout(int ms);
    void setRadio868SendTimeout(int ms);
    void setDebugMode(bool enabled);

    void getWlanSsid();
    void getWlanPhrase();
    void getWlanKey();
    void getWlanHostname();
    void getWlanAuth();
    void getWlanDhcpMethod();
    void getWlanIpAddress();
    void getWlanSubnetMask();
    void getWlanGateway();
    void getWlanPrimaryDnsAddress();
    void getWlanSecondaryDnsAddress();
    void getIrCount();
    void getIrReceiveTimeout();
    void getIrSendTimeout();
    void getRadio433Count();
    void getRadio433ReceiveTimeout();
    void getRadio433SendTimeout();
    void getRadio868Count();
    void getRadio868ReceiveTimeout();
    void getRadio868SendTimeout();
    void getDebugMode();

    void dataAdd(StorageItem storageItem);
    void dataUpdate(int pos, StorageItem storageItem);
    void dataGetName(int pos, QueueCommandType commandType = NormalQueueCommandType);
    void dataGetData(int pos);
    void dataGetCount(QueueCommandType commandType = NormalQueueCommandType);
    void dataSwap(int pos1, int pos2);
    void dataRemove(int pos);
    void dataEraseAll();

    void runCommand(RemoteCommand remoteCommand);
    void runData(int pos);
    void captureIr();
    void captureRadio433MHz();
    void captureRadio868MHz();
    void startWlanAp();
    void startWlanInfrastructure();
    void saveConfig();
    void stop();
    void factoryReset();
    void flashFirmware(QString filename);
    void sendKeepAlive();

    void refreshStoredCommands();

void setResponseTimeout(int arg)
{
    if (m_responseTimeout != arg) {
        m_responseTimeout = arg;
        emit responseTimeoutChanged(arg);
    }
}

void setQueueRunning(bool arg)
{
    if (m_queueRunning != arg) {
        m_queueRunning = arg;
        emit queueRunningChanged(arg);
    }
}

void setKeepAliveTimeout(int arg)
{
    m_keepAliveTimeout = arg;
    keepAliveTimer->setInterval(arg);
}

void setAutoconnectEnabled(bool arg)
{
    m_autoconnectEnabled = arg;
}

void setNetworkHostname(QString arg)
{
    if (m_networkHostname != arg) {
        m_networkHostname = arg;
        emit networkHostnameChanged(arg);
    }
}

void setNetworkPort(int arg)
{
    if (m_networkPort != arg) {
        m_networkPort = arg;
        emit networkPortChanged(arg);
    }
}

void setCommandDelay(int arg)
{
    m_commandDelay = arg;
}

private slots:
#ifdef SERIALPORT
    void incomingSerialData();
#endif
    void incomingNetworkData();
    void incomingByte(char byte);
    void tcpSocketConnected();
    void tcpSocketDisconnected();
    void tcpSocketError(QAbstractSocket::SocketError error);
    void responseTimerTick();
    void keepAliveTimerTick();

    void startQueue();
    void doQueue();
    void endQueue();
    void clearQueue();

private:
#ifdef SERIALPORT
    SerialPort *serialPort;
#endif

    int m_responseTimeout;
    bool m_queueRunning;
    int m_keepAliveTimeout;
    int m_commandDelay;
    bool m_autoconnectEnabled;
    QString m_networkHostname;
    int m_networkPort;
    bool m_networkConnected;
    bool m_serialPortConnected;
    QStringList m_storedCommands;

    QTcpSocket *tcpSocket;
    QByteArray dataBuffer;
    QString receivedData;
    bool waitingForRespose;

    bool wantsConnection;   // this variable indicates wheter a user wants a connection or not, necessary for autoconnect

    ActiveConnections activeConnections;

    QQueue<QueueCommand> commandQueue;
    QueueCommand currentCommand;
    QTimer *responseTimer;
    QString responseString;
    int     responseOffset;

    QTimer *keepAliveTimer;
    bool    keepAliveReceived;

    Base64 *base64;

    int storageCommandCount;

    QByteArray dataToHex(const char* data, int size);

    void receivedCommand(QByteArray command);
    void sendData(const QByteArray &data);
    void findInResponse(QString toMatch, int timeout);
    void responseReceived(QueueCommandType type, Command command, QString responseData);
    void responseTimedOut(QueueCommandType type);
    void processResponse(Command command, QString responseData);
    void processStoredCommandsRefreshResponse(Command command, QString responseData);

    void pauseKeepAlive(int msecs);
};

Q_DECLARE_METATYPE(QRemoteBoxClient::CommandHeader)
Q_DECLARE_METATYPE(QRemoteBoxClient::RemoteCommand)
Q_DECLARE_METATYPE(QRemoteBoxClient::StorageItem)
Q_DECLARE_METATYPE(QRemoteBoxClient::WlanAuthType)
Q_DECLARE_METATYPE(QRemoteBoxClient::IpDhcpMethod)
Q_DECLARE_METATYPE(QRemoteBoxClient::Command)
Q_DECLARE_METATYPE(QRemoteBoxClient::RemoteMedium)

#endif // IREMOTE_H
