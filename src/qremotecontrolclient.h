#ifndef QREMOTECONTROLCLIENT_H
#define QREMOTECONTROLCLIENT_H

#include <QObject>
#include <QtNetwork>
#include <QApplication>
#include <QDesktopWidget>
#include "wakeonlanpacket.h"

#ifdef TRIAL
#include <QSystemDeviceInfo>
QTM_USE_NAMESPACE
#endif

typedef struct {
    QHostAddress hostAddress;
    QString      hostName;
    bool connected;
} QRCServer;

class QRemoteControlClient : public QObject
{
    Q_OBJECT
    Q_ENUMS(ScreenOrientation)
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
    Q_PROPERTY(int networkTimeout READ networkTimeout WRITE setNetworkTimeout NOTIFY networkTimeoutChanged)
    Q_PROPERTY(ScreenOrientation screenOrientation READ screenOrientation WRITE screenOrientation NOTIFY screenOrientationChanged)
    Q_PROPERTY(QString emptyString READ getEmptyString NOTIFY emptyStringChanged)
    Q_PROPERTY(QString language READ language WRITE setLanguage NOTIFY languageChanged)
    Q_PROPERTY(bool trialVersion READ isTrialVersion NOTIFY trialVersionChanged)
#ifdef TRIAL
    Q_PROPERTY(QDateTime trialExpirationTime READ trialExpirationTime NOTIFY trialExpirationTimeChanged)
#endif

public:
    enum ScreenOrientation {
        ScreenOrientationAuto = 0,
        ScreenOrientationLockPortrait = 1,
        ScreenOrientationLockReversePortrait = 2,
        ScreenOrientationLockLandscape = 3,
        ScreenOrientationLockReverseLandscape = 4
    };

    explicit QRemoteControlClient(QObject *parent = 0);
    virtual ~QRemoteControlClient();

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

    int networkTimeout() const
    {
        return m_networkTimeout;
    }

    ScreenOrientation screenOrientation() const
    {
        return m_screenOrientation;
    }

    QString getEmptyString() const
    {
        return m_emptyString;
    }

    QString language() const
    {
        return m_language;
    }

    bool isTrialVersion() const
    {
        return m_trialVersion;
    }

#ifdef TRIAL
    QDateTime trialExpirationTime() const
    {
        return m_trialExpirationTime;
    }
#endif

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
    Q_INVOKABLE void sendText (QString text);
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

    void setNetworkTimeout(int arg)
    {
        if (m_networkTimeout != arg) {
            m_networkTimeout = arg;
            emit networkTimeoutChanged(arg);
        }
    }

    void screenOrientation(ScreenOrientation arg)
    {
        if (m_screenOrientation != arg) {
            m_screenOrientation = arg;
            emit screenOrientationChanged(arg);
        }
    }

    void setLanguage(QString arg)
    {
        if (m_language != arg) {
            m_language = arg;

            if(m_language.contains(QString("de"))) {
                m_language = "de";
                translator1->load("de", ":/i18");
                qApp->installTranslator(translator1);
               }
            else if(m_language.contains(QString("ru"))) {
                m_language = "ru";
                translator2->load("ru", ":/i18");
                qApp->installTranslator(translator2);
               }
            else if(m_language.contains(QString("uk"))) {
                m_language = "uk";
                translator3->load("uk", ":/i18");
                qApp->installTranslator(translator3);
               }
            else {                                          // english fall through
                m_language = "en";
                qApp->removeTranslator(translator1);
                qApp->removeTranslator(translator2);
                qApp->removeTranslator(translator3);
               }
            emit emptyStringChanged("");
            emit languageChanged(m_language);
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
    void serverFound(QString address, QString hostName, bool connected);
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
    void networkTimeoutChanged(int arg);
    void screenOrientationChanged(ScreenOrientation arg);

    void emptyStringChanged(QString arg);

    void languageChanged(QString arg);

    // Trial
    void trialExpired();
#ifdef TRIAL
    void trialExpirationTimeChanged(QDateTime arg);
#endif

    void trialVersionChanged(bool arg);

private:
    // Network
    QUdpSocket *udpSocket;
    QTcpServer *tcpServer;
    QTcpSocket *tcpSocket;
    QTimer     *broadcastTimer;
    QTimer     *connectionRequestTimer;
    QNetworkSession *session;
    QNetworkConfigurationManager *netConfigManager;
    QTimer     *networkTimeoutTimer;

    // Trial
#ifdef TRIAL
    QNetworkAccessManager *networkAccesManager;
    QTimer                *trialTimer;
#endif

    // General
    QByteArray passwordHash;

    // Servers
    QList<QRCServer> serverList;

    // Translators
    QTranslator *translator1;
    QTranslator *translator2;
    QTranslator *translator3;

    void incomingIcon(QByteArray data);
    void incomingAmarokData(QByteArray data);

    void addServer(QHostAddress hostAddress, bool connected);

    QString         m_hostname;
    QString         m_password;
    int             m_port;
    QString         m_version;
    QHostAddress    m_hostAddress;
    QString         m_uiColor;
    QString         m_wolMacAddress;
    QString         m_wolHostname;
    int             m_wolPort;
    int             m_wolDatagramNumber;
    int             m_screenDpi;
    double          m_uiRoundness;
    int             m_networkTimeout;
    ScreenOrientation m_screenOrientation;
    QString m_emptyString;
    QString m_language;
    bool m_trialVersion;
#ifdef TRIAL
    QDateTime m_trialExpirationTime;
#endif

    void initializeNetworkTimeoutTimer();
    void sendVersion();

private slots:
    void sendConnectionRequest();
    void sendBroadcast();
    void sendKeepAlive();
    void newConnection();
    void deleteConnection();
    void incomingData();
    void incomingUdpData();
    void saveResolvedHostName(QHostInfo hostInfo);

#ifdef TRIAL
    void checkTrialExpiration();
    void replyFinished(QNetworkReply* reply);
    void trialTimerTimeout();
#endif

    void initialize();
};

#endif // QREMOTECONTROLCLIENT_H
