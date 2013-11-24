//#include <QApplication>
//#include <QtDeclarative>
//#include "qmlapplicationviewer.h"
#include "qremotecontrolclient.h"
#include "platformdetails.h"

#include <QtGui/QGuiApplication>
#include <QtQml>
#include "qtquick2applicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    //QScopedPointer<QApplication> app(createApplication(argc, argv));
    QApplication app(argc, argv);

    qmlRegisterType<QRemoteControlClient>("RemoteControl", 2, 0, "Client");
    qmlRegisterType<PlatformDetails>("Platform", 1, 0, "Details");
    //QmlApplicationViewer viewer;

    QtQuick2ApplicationViewer viewer;
    //viewer.setSource(QUrl("qrc:/qml/QRemoteControl2/init.qml"));
    //viewer.showFullScreen();


#if !defined(Q_OS_MEEGO)
    viewer.setSource(QUrl("qrc:/qml/QRemoteControl2/init.qml"));
#if ((defined(Q_WS_X11) || defined(Q_WS_WIN) || defined(Q_OS_LINUX)) && !defined(Q_OS_ANDROID)) // On Desktop skip the Splash screen
    viewer.setGeometry(0,0, 400, 600);
#endif
    //viewer.setOrientation((int)QmlApplicationViewer::ScreenOrientationLockPortrait);
    qDebug() << "not MEEGO";
#else   //MEEGO!?
    viewer.setSource(QUrl("qrc:/qml/QRemoteControl2/initMeego.qml"));
    viewer.setOrientation((int)QmlApplicationViewer::ScreenOrientationLockPortrait);
    qDebug() << "MEEGO";
#endif
#if !defined(Q_OS_SYMBIAN)
    viewer.showExpanded();
#else
    viewer.showFullScreen();
#endif

    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.rootContext()->setContextProperty("viewer", &viewer);

    return app.exec();
}
