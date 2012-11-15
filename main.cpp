#include <QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "qremotecontrolclient.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    /*QTranslator myappTranslator;
    qDebug() << myappTranslator.load(QLocale::system().name(),":/i18","",".qm");
    app->installTranslator(&myappTranslator);*/

    qmlRegisterType<QRemoteControlClient>("RemoteControl", 2, 0, "Client");
    QmlApplicationViewer viewer;

#if !defined(Q_OS_MEEGO)//defined(Q_OS_SYMBIAN) || defined(Q_WS_SIMULATOR)|| defined(Q_WS_X11) || defined(Q_WS_WIN)
    viewer.setMainQmlFile(QLatin1String("qml/QRemoteControl2/Main.qml"));
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    qDebug() << "not MEEGO";
#else   //MEEGO!?
    viewer.setMainQmlFile(QLatin1String("qml/QRemoteControl2/meegowrapper.qml"));
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    qDebug() << "MEEGO";
#endif
    viewer.showFullScreen();

    return app->exec();
}
