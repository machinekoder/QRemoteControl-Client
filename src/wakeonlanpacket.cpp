#include "wakeonlanpacket.h"

WakeOnLanPacket::WakeOnLanPacket(QObject *parent) :
    QObject(parent)
{
    prefix.append("\xFF\xFF\xFF\xFF\xFF\xFF");
    m_port = 80;
    hostAddress = QHostAddress::Null;
}

bool WakeOnLanPacket::setHostname(QString arg)
{
    m_hostname = arg;

#ifdef QT_DEBUG
    qDebug()<<"Resolving address:"<<arg;
#endif

    QHostInfo hostInfo = QHostInfo::fromName(arg);
    if (!hostInfo.addresses().isEmpty())
    {
        hostAddress = hostInfo.addresses().first();
#ifdef QT_DEBUG
        qDebug() << "IP set to:" << hostAddress.toString();
#endif
        return true;
    }
    else
    {
#ifdef QT_DEBUG
        qDebug() << "No IP address found for" << arg;
#endif
        hostAddress = QHostAddress::Null;
    }

    return false;
}

bool WakeOnLanPacket::setPort(int arg)
{
    m_port = arg;
    return true;
}

bool WakeOnLanPacket::setMacAddress(QByteArray arg)
{
    QString tempString = arg;

    if (tempString.count(QRegExp("[\\da-fA-F]"))==12)
    {
        m_macAddress = QByteArray::fromHex(arg);
#ifdef QT_DEBUG
        qDebug() << "MAC address:" << m_macAddress.toHex();
#endif
        return true;
    }
    else
    {
        m_macAddress = QByteArray();
#ifdef QT_DEBUG
        qDebug() << "The provided MAC address is not valid";
#endif
    }

    return false;
}

bool WakeOnLanPacket::send()
{
    if (m_macAddress.isEmpty() || (hostAddress == QHostAddress::Null))
    {
        return false;
    }

    if (hostAddress.isInSubnet(QHostAddress("10.0.0.0"),8) ||
            hostAddress.isInSubnet(QHostAddress("172.16.0.0"),12) ||
            hostAddress.isInSubnet(QHostAddress("192.168.0.0"),16))
    {
#ifdef QT_DEBUG
        qDebug() << "Magic packet will be sent as udp broadcast";
#endif
        setHostname("255.255.255.255");
    }

    //build payload
    payload = prefix + m_macAddress.repeated(16);
#ifdef QT_DEBUG
    qDebug() << "Payload built:" << payload.toHex();
#endif

    if (udpSocket.writeDatagram(payload, hostAddress, m_port) == -1)
    {
#ifdef QT_DEBUG
        qDebug() << "Error on udp socket" << udpSocket.errorString();
#endif
        return false;
    }
    else
    {
#ifdef QT_DEBUG
        qDebug() << "Magic packet sent";
#endif
        return true;
    }
}
