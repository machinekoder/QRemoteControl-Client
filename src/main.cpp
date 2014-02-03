#include "qremotecontrolclient.h"
#include "platformdetails.h"
#include "qremoteboxclient.h"
#include <QtQml>

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#if defined(Q_OS_SAILFISH)
#include <sailfishapp.h>
#else
#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#endif

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    qmlRegisterType<QRemoteControlClient>("harbour.qremotecontrol.RemoteControl", 2, 0, "Client");  // naming tue to Jolla harbour rules
    qmlRegisterType<QRemoteBoxClient>("harbour.qremotecontrol.RemoteBox", 1, 0, "Client");
    qmlRegisterType<PlatformDetails>("harbour.qremotecontrol.Platform", 1, 0, "Details");

#if defined(Q_OS_SAILFISH)
    return SailfishApp::main(argc, argv);
#else
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setDefaultAlphaBuffer(true);

#if !defined(Q_OS_ANDROID)
viewer.setMainQmlFile(QStringLiteral("qml/init.qml"));
#else
    viewer.setSource(QUrl("qrc:/qml/init.qml"));
#endif
#if ((defined(Q_WS_X11) || defined(Q_WS_WIN) || defined(Q_OS_LINUX)) && !defined(Q_OS_ANDROID)) // On Desktop skip the Splash screen
    viewer.setGeometry(0,0, 600, 900);
#endif

    viewer.showExpanded();

    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.rootContext()->setContextProperty("viewer", &viewer);

    return app.exec();
#endif
}
