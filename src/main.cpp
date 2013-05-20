#include <QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "qremotecontrolclient.h"
#include "platformdetails.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    qmlRegisterType<QRemoteControlClient>("RemoteControl", 2, 0, "Client");
    qmlRegisterType<PlatformDetails>("Platform", 1, 0, "Details");
    QmlApplicationViewer viewer;
    viewer.addImportPath(QLatin1String("modules"));

#if !defined(Q_OS_MEEGO)
    viewer.setMainQmlFile(QLatin1String("qml/QRemoteControl2/init.qml"));
#if defined(Q_WS_X11) || defined(Q_WS_WIN) // On Desktop skip the Splash screen
    viewer.setGeometry(0,0, 400, 600);
#endif
    viewer.setOrientation((int)QmlApplicationViewer::ScreenOrientationLockPortrait);
    qDebug() << "not MEEGO";
#else   //MEEGO!?
    viewer.setMainQmlFile(QLatin1String("qml/QRemoteControl2/initMeego.qml"));
    viewer.setOrientation((int)QmlApplicationViewer::ScreenOrientationLockPortrait);
    qDebug() << "MEEGO";
#endif
#if !defined(Q_OS_SYMBIAN)
    viewer.showExpanded();
#else
    viewer.showFullScreen();
#endif

    viewer.rootContext()->setContextProperty("viewer", &viewer);

    return app->exec();
}
