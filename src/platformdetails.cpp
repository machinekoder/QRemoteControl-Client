#include "platformdetails.h"

PlatformDetails::PlatformDetails(QObject *parent) :
    QObject(parent)
{
#if defined(Q_OS_OSX)
    m_platform = "OSX";
#elif (defined(Q_WS_WIN) || defined(Q_OS_WIN))
    m_platform = "Windows";
#elif defined(Q_OS_SYMBIAN)
    m_platform = "Symbian";
#elif defined(Q_OS_MEEGO)
    m_platform = "MeeGo";
#elif defined(Q_WS_SIMULATOR)
    m_platform = "Simulator";
#elif defined(Q_OS_ANDROID)
    m_platform = "Android";
#elif defined(Q_OS_BLACKBERRY)
    m_platform = "BlackBerry";
//#elif defined(Q_OS_SAILFISH)    // TODO: This is not supported
#elif defined(Q_OS_SAILFISH)
    m_platform = "SailfishOS";
#elif defined(Q_OS_IOS)
    m_platform = "iOS";
#elif defined(Q_OS_LINUX)
    m_platform = "Linux";
#else
    m_platform = "Other";
#endif
}
