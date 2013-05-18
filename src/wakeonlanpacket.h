#ifndef WAKEONLANPACKET_H
#define WAKEONLANPACKET_H

#include <QObject>
#include <QByteArray>
#include <QHostAddress>
#include <QUdpSocket>
#include <QRegExp>
#include <QHostInfo>
#include <QHostAddress>
#include <QNetworkInterface>
#ifdef QT_DEBUG
#include <QDebug>
#endif

/**
 * @brief Represents a magic packet for Wake on Lan
 * @see https://en.wikipedia.org/wiki/Wake-on-LAN#Magic_packet
 */
class WakeOnLanPacket : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QByteArray macAddress WRITE setMacAddress READ macAddress)
    Q_PROPERTY(QString hostname WRITE setHostname READ hostname)
    Q_PROPERTY(int port WRITE setPort READ port)

public:
    explicit WakeOnLanPacket(QObject *parent = 0);

    QString hostname() const
    {
        return m_hostname;
    }

    int port() const
    {
        return m_port;
    }

    QByteArray macAddress() const
    {
        return m_macAddress;
    }

public slots:
    bool send();

    bool setHostname(QString arg);
    bool setPort(int arg);
    bool setMacAddress(QByteArray arg);

private:
    //! preamble of every magic packet
    QByteArray prefix;
    //! magic frame content
    QByteArray payload;

    //! system to wake
    //! used to determine if LAN broadcast is used or not
    QHostAddress hostAddress;
    QUdpSocket   udpSocket;

    QString m_hostname;
    int m_port;

    QByteArray m_macAddress;
    
};

#endif // WAKEONLANPACKET_H
