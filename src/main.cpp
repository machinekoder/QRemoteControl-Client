//#include <QApplication>
//#include <QtDeclarative>
//#include "qmlapplicationviewer.h"
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
    qmlRegisterType<QRemoteControlClient>("RemoteControl", 2, 0, "Client");
    qmlRegisterType<QRemoteBoxClient>("RemoteBox", 1, 0, "Client");
    qmlRegisterType<PlatformDetails>("Platform", 1, 0, "Details");

#if defined(Q_OS_SAILFISH)
    return SailfishApp::main(argc, argv);
#else
    //QScopedPointer<QApplication> app(createApplication(argc, argv));
    QGuiApplication app(argc, argv);

    //QmlApplicationViewer viewer;

    QtQuick2ApplicationViewer viewer;
    viewer.setDefaultAlphaBuffer(true);
    //viewer.setSource(QUrl("qrc:/qml/init.qml"));
    //viewer.showFullScreen();


#if !defined(Q_OS_MEEGO)
//#if defined(SAILFISH_OS)
//    viewer.setSource(QUrl("qrc:/qml/initSailfishOs.qml"));
//#else
#if !(defined(Q_OS_ANDROID) || defined(Q_OS_IOS))
viewer.setMainQmlFile(QStringLiteral("qml/init.qml"));
#else
    viewer.setSource(QUrl("qrc:/qml/init.qml"));
#endif
//#endif
#if ((defined(Q_WS_X11) || defined(Q_WS_WIN) || defined(Q_OS_LINUX)) && !defined(Q_OS_ANDROID)) // On Desktop skip the Splash screen
    viewer.setGeometry(0,0, 600, 900);
#endif
    //viewer.setOrientation((int)QmlApplicationViewer::ScreenOrientationLockPortrait);
    qDebug() << "not MEEGO";
#else   //MEEGO!?
    viewer.setSource(QUrl("qrc:/qml/initMeego.qml"));
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
#endif
}
