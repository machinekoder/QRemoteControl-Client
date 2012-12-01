#include "platformdetails.h"

PlatformDetails::PlatformDetails(QObject *parent) :
    QObject(parent)
{
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
}
