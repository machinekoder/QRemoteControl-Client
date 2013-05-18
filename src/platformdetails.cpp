#include "platformdetails.h"

PlatformDetails::PlatformDetails(QObject *parent) :
    QObject(parent)
{
#ifdef Q_OS_LINUX
    m_platform = "Linux";
#endif
#ifdef Q_OS_OSX
    m_platform = "OSX";
#endif
#ifdef Q_WS_WIN
    m_platform = "Windows";
#endif
#ifdef Q_OS_SYMBIAN
    m_platform = "Symbian";
#endif
#ifdef Q_OS_MEEGO
    m_platform = "MeeGo";
#endif
#ifdef Q_WS_SIMULATOR
    m_platform = "Simulator";
#endif
#ifdef Q_OS_ANDROID
    m_platform = "Android";
#endif
#ifdef Q_OS_BLACKBERRY
    m_platform = "BlackBerry";
#endif
}
