#include <QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "qremotecontrolclient.h"
#include "platformdetails.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    /*QTranslator myappTranslator;
    qDebug() << myappTranslator.load(QLocale::system().name(),":/i18","",".qm");
    app->installTranslator(&myappTranslator);*/

    qmlRegisterType<QRemoteControlClient>("RemoteControl", 2, 0, "Client");
    qmlRegisterType<PlatformDetails>("Platform", 1, 0, "Details");
    QmlApplicationViewer viewer;

#if !defined(Q_OS_MEEGO)//defined(Q_OS_SYMBIAN) || defined(Q_WS_SIMULATOR)|| defined(Q_WS_X11) || defined(Q_WS_WIN)
    viewer.setMainQmlFile(QLatin1String("qml/QRemoteControl2/init.qml"));
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    qDebug() << "not MEEGO";
#else   //MEEGO!?
    viewer.setMainQmlFile(QLatin1String("qml/QRemoteControl2/initMeego.qml"));
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    qDebug() << "MEEGO";
#endif
    viewer.showExpanded();

    return app->exec();
}
