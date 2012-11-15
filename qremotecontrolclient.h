#ifndef QREMOTECONTROLCLIENT_H
#define QREMOTECONTROLCLIENT_H

#include <QtGui/QMainWindow>
#include <QtNetwork>
#include <QApplication>
#include <QDesktopWidget>
#include "wakeonlanpacket.h"

typedef struct {
    QHostAddress hostAddress;
    bool connected;
} QRCServer;

class QRemoteControlClient : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString hostname READ hostname WRITE setHostname NOTIFY hostnameChanged)
    Q_PROPERTY(QHostAddress hostAddress READ hostAddress WRITE setHostAddress NOTIFY hostAddressChanged)
    Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY passwordChanged)
    Q_PROPERTY(int port READ port WRITE setPort NOTIFY portChanged)
    Q_PROPERTY(QString uiColor READ uiColor WRITE setUiColor NOTIFY uiColorChanged)
    Q_PROPERTY(double  uiRoundness READ uiRoundness WRITE setUiRoundness NOTIFY uiRoundnessChanged)
    Q_PROPERTY(QString version READ version NOTIFY versionChanged)
    Q_PROPERTY(QString wolMacAddress READ wolMacAddress WRITE setWolMacAddress NOTIFY macAddressChanged)
    Q_PROPERTY(QString wolHostname READ wolHostname WRITE setWolHostname NOTIFY wolHostnameChanged)
    Q_PROPERTY(int wolPort READ wolPort WRITE setWolPort NOTIFY wolPortChanged)
    Q_PROPERTY(int wolDatagramNumber READ wolDatagramNumber WRITE setWolDatagramNumber NOTIFY wolDatagramNumberChanged)
    Q_PROPERTY(int screenDpi READ screenDpi NOTIFY screenDpiChanged)

public:
    enum ScreenOrientation {
        ScreenOrientationLockPortrait,
        ScreenOrientationLockLandscape,
        ScreenOrientationAuto
    };

    explicit QRemoteControlClient(QObject *parent = 0);
    virtual ~QRemoteControlClient();

    void setOrientation(ScreenOrientation orientation);
    void showExpanded();

    Q_INVOKABLE void connectToHost();
    Q_INVOKABLE void startBroadcasting();
    Q_INVOKABLE void abortBroadcasting();
    Q_INVOKABLE void abortConnectionRequest();
    Q_INVOKABLE void saveSettings();
    Q_INVOKABLE void loadSettings();

    int screenDpi() const
    {
        return m_screenDpi;
    }

    QString hostname() const
    {
        return m_hostname;
    }

    QString password() const
    {
        return m_password;
    }

    int port() const
    {
        return m_port;
    }

    QString version() const
    {
        return m_version;
    }

    QHostAddress hostAddress() const
    {
        return m_hostAddress;
    }

    QString uiColor() const
    {
        return m_uiColor;
    }

    QString wolMacAddress() const
    {
        return m_wolMacAddress;
    }

    QString wolHostname() const
    {
        return m_wolHostname;
    }

    int wolPort() const
    {
        return m_wolPort;
    }

    int wolDatagramNumber() const
    {
        return m_wolDatagramNumber;
    }

    double uiRoundness() const
    {
        return m_uiRoundness;
    }

public slots:
    Q_INVOKABLE void sendKey (quint32 key, quint32 modifiers, bool keyPressed);
    Q_INVOKABLE void sendButton (quint8 id, bool keyPressed);
    Q_INVOKABLE void sendKeyPress (quint8 id);
    Q_INVOKABLE void sendKeyRelease (quint8 id);
    Q_INVOKABLE void sendMouseMove (int deltaX, int deltaY);
    Q_INVOKABLE void sendHorizontalScroll(int delta);
    Q_INVOKABLE void sendVerticalScroll(int delta);
    Q_INVOKABLE void sendMouseScroll(quint8 direction, qint8 delta);
    Q_INVOKABLE void sendMouseButton(quint8 button, bool buttonPressed);
    Q_INVOKABLE void sendMousePress (quint8 button);
    Q_INVOKABLE void sendMouseRelease (quint8 button);
    Q_INVOKABLE void sendControlClicked(bool down);
    Q_INVOKABLE void sendAltClicked(bool down);
    Q_INVOKABLE void sendShiftClicked(bool down);
    //void sendCharacter(quint32 character, quint32 modifiers);
    Q_INVOKABLE void sendAction (int id, bool pressed);
    Q_INVOKABLE void sendLight (int code);
    Q_INVOKABLE void disconnect();
    Q_INVOKABLE void clearServerList();
    Q_INVOKABLE void connectToServer(int id);
    Q_INVOKABLE void openNetworkSession();
    Q_INVOKABLE bool sendWakeOnLan();

    void setHostname(QString arg)
    {
        if (m_hostname != arg) {
            m_hostname = arg;
            emit hostnameChanged(arg);
        }

        QHostAddress hostAddress;
        if (!m_hostname.isEmpty())
            hostAddress.setAddress(m_hostname);
        else
            hostAddress = QHostAddress::Broadcast;

        setHostAddress(hostAddress);
    }

    void setHostAddress(QHostAddress arg)
    {
        if (m_hostAddress != arg) {
            m_hostAddress = arg;

            m_hostname = m_hostAddress.toString();
            emit hostAddressChanged(arg);
            emit hostnameChanged(m_hostname);
        }
    }

    void setPassword(QString arg)
    {
        if (m_password != arg) {
            m_password = arg;
            emit passwordChanged(arg);
        }
    }

    void setPort(int arg)
    {
        if (m_port != arg) {
            m_port = arg;
            emit portChanged(arg);
        }
    }

    void setUiColor(QString arg)
    {
        if (m_uiColor != arg) {
            m_uiColor = arg;
            emit uiColorChanged(arg);
        }
    }

    void setWolMacAddress(QString arg)
    {
        if (m_wolMacAddress != arg) {
            m_wolMacAddress = arg;
            emit macAddressChanged(arg);
        }
    }

    void setWolHostname(QString arg)
    {
        if (m_wolHostname != arg) {
            m_wolHostname = arg;
            emit wolHostnameChanged(arg);
        }
    }

    void setWolPort(int arg)
    {
        if (m_wolPort != arg) {
            m_wolPort = arg;
            emit wolPortChanged(arg);
        }
    }

    void setWolDatagramNumber(int arg)
    {
        if (m_wolDatagramNumber != arg) {
            m_wolDatagramNumber = arg;
            emit wolDatagramNumberChanged(arg);
        }
    }

    void setUiRoundness(double arg)
    {
        if (m_uiRoundness != arg) {
            m_uiRoundness = arg;
            emit uiRoundnessChanged(arg);
        }
    }

signals:
    void hostnameChanged(QString arg);
    void hostAddressChanged(QHostAddress arg);
    void passwordChanged(QString arg);
    void portChanged(int arg);
    void versionChanged(QString arg);
    void uiColorChanged(QString arg);
    void connected();
    void disconnected();
    void broadcastingStarted();
    void connectingStarted();
    void firstStart();
    void actionReceived(int id, QString text, QString imagePath);
    void serversCleared();
    void serverFound(QString address, bool connected);
    void passwordIncorrect();
    void serverConnecting();

    void networkOpened();
    void networkClosed();

    void macAddressChanged(QString arg);

    void wolHostnameChanged(QString arg);

    void wolPortChanged(int arg);

    void wolDatagramNumberChanged(int arg);

    void screenDpiChanged(int arg);

    void uiRoundnessChanged(double arg);

private:
    //Network
    QUdpSocket *udpSocket;
    QTcpServer *tcpServer;
    QTcpSocket *tcpSocket;
    QTimer     *broadcastTimer;
    QTimer     *connectionRequestTimer;
    QNetworkSession *session;
    QNetworkConfigurationManager *netConfigManager;

    //General
    QByteArray passwordHash;

    // Servers
    QList<QRCServer> serverList;

    void incomingIcon(QByteArray data);
    void incomingAmarokData(QByteArray data);

    void addServer(QHostAddress hostAddress, bool connected);

    QString m_hostname;
    QString m_password;
    int m_port;
    QString m_version;

    QHostAddress m_hostAddress;

    QString m_uiColor;

    QString m_wolMacAddress;

    QString m_wolHostname;

    int m_wolPort;

    int m_wolDatagramNumber;

    int m_screenDpi;

    double m_uiRoundness;

private slots:
    void sendConnectionRequest();
    void sendBroadcast();
    void newConnection();
    void deleteConnection();
    void incomingData();
    void incomingUdpData();

    void initialize();
};

#endif // QREMOTECONTROLCLIENT_H
