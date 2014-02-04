TARGET = qremotecontrol-client
VERSION = 2.6.0

TRANSLATIONS = i18/de.ts i18/ru.ts i18/uk.ts i18/es.ts

DEFINES += VERSION=\"\\\"$$VERSION\\\"\"

sailfish: {
    CONFIG += sailfishapp
    DEFINES += Q_OS_SAILFISH
    TARGET = harbour-qremotecontrol
    OTHER_FILES += \
    rpm/harbour-qremotecontrol.yaml \
    harbour-qremotecontrol.desktop \
    qml/orientationSensor.js \
    qml/HelpPage.qml \
    qml/NavigationButton.qml \
    qml/MusicControl.qml \
    qml/TouchPadPage.qml \
    qml/WakeOnLanPage.qml \
    qml/NavigationPanel.qml \
    qml/TouchPad.qml \
    qml/StyleTest.qml \
    qml/SplashScreen.qml \
    qml/SocialPage.qml \
    qml/SettingsPage.qml \
    qml/RemoteControlPage.qml \
    qml/RemoteBoxPage.qml \
    qml/Main.qml \
    qml/LoadingPage.qml \
    qml/ConnectPage.qml \
    qml/ButtonPageItem.qml \
    qml/KeyboardPage.qml \
    qml/KeyboardButton2.qml \
    qml/KeyboardButton.qml \
    qml/ButtonPage.qml \
    qml/ButtonBar.qml \
    qml/BroadcastPage.qml \
    qml/Keyboard.qml \
    qml/JollaImage.qml \
    qml/ActionsPage.qml \
    qml/AboutPage.qml \
    qml/styles/DefaultWhite.qml \
    qml/styles/DefaultSilver.qml \
    qml/styles/DefaultRed.qml \
    qml/styles/DefaultPink.qml \
    qml/styles/DefaultGrey.qml \
    qml/styles/DefaultGreen.qml \
    qml/styles/DefaultGold.qml \
    qml/styles/DefaultBlue.qml \
    qml/styles/DefaultBlack.qml \
    qml/styles/SailfishAmbience.qml \
    qml/sailfish/CoverPage.qml \
    qml/MyComponents/qmldir \
    qml/MyComponents/feedback.js \
    qml/MyComponents/Style.qml \
    qml/MyComponents/StatBar.qml \
    qml/MyComponents/SpinBox.qml \
    qml/MyComponents/Slider.qml \
    qml/MyComponents/LineEdit.qml \
    qml/MyComponents/Label.qml \
    qml/MyComponents/Button.qml \
    qml/images/qrc.png \
    qml/images/jolla_pyramid.png \
    qml/images/tile.png \
    qml/images/body_background_dark.png \
    qml/images/background_white.png \
    qml/images/background_silver.png \
    qml/images/background_red.png \
    qml/images/background_pink.png \
    qml/images/background_grey.png \
    qml/images/background_green.png \
    qml/images/background_gold.png \
    qml/images/background_blue.png \
    qml/images/background_black.png \
    qml/images/black/zoom_out.png \
    qml/images/black/zoom_in.png \
    qml/images/black/vscroll.png \
    qml/images/black/volume_up.png \
    qml/images/black/volume_mute.png \
    qml/images/black/volume_down.png \
    qml/images/black/up.png \
    qml/images/black/switch_window.png \
    qml/images/black/stop.png \
    qml/images/black/shift.png \
    qml/images/black/settings.png \
    qml/images/black/seek_forward.png \
    qml/images/black/seek_backward.png \
    qml/images/black/right.png \
    qml/images/black/return.png \
    qml/images/black/remote.png \
    qml/images/black/power.png \
    qml/images/black/play_pause.png \
    qml/images/black/ok.png \
    qml/images/black/mouse.png \
    qml/images/black/menu.png \
    qml/images/black/like.png \
    qml/images/black/left.png \
    qml/images/black/keyboard.png \
    qml/images/black/info.png \
    qml/images/black/hscroll.png \
    qml/images/black/help.png \
    qml/images/black/exit.png \
    qml/images/black/down.png \
    qml/images/black/disconnect.png \
    qml/images/black/computer.png \
    qml/images/black/backspace.png \
    qml/images/black/apps.png \
    qml/images/lang/ukrainian.png \
    qml/images/lang/spanish.png \
    qml/images/lang/russian.png \
    qml/images/lang/german.png \
    qml/images/lang/english.png \
    qml/images/social/twitter.png \
    qml/images/social/sourceforge.png \
    qml/images/social/paypal.png \
    qml/images/social/google+.png \
    qml/images/social/flattr.png \
    qml/images/social/facebook.png \
    qml/images/social/bitcoin.png \
    qml/images/white/zoom_out.png \
    qml/images/white/zoom_in.png \
    qml/images/white/vscroll.png \
    qml/images/white/volume_up.png \
    qml/images/white/volume_mute.png \
    qml/images/white/volume_down.png \
    qml/images/white/up.png \
    qml/images/white/switch_window.png \
    qml/images/white/stop.png \
    qml/images/white/shift.png \
    qml/images/white/settings.png \
    qml/images/white/seek_forward.png \
    qml/images/white/seek_backward.png \
    qml/images/white/right.png \
    qml/images/white/return.png \
    qml/images/white/remote.png \
    qml/images/white/power.png \
    qml/images/white/play_pause.png \
    qml/images/white/ok.png \
    qml/images/white/mouse.png \
    qml/images/white/menu.png \
    qml/images/white/like.png \
    qml/images/white/left.png \
    qml/images/white/keyboard.png \
    qml/images/white/info.png \
    qml/images/white/hscroll.png \
    qml/images/white/help.png \
    qml/images/white/exit.png \
    qml/images/white/down.png \
    qml/images/white/disconnect.png \
    qml/images/white/computer.png \
    qml/images/white/backspace.png \
    qml/images/white/apps.png \
    qml/images/white2/zoom_out.png \
    qml/images/white2/zoom_in.png \
    qml/images/white2/vscroll.png \
    qml/images/white2/volume_up.png \
    qml/images/white2/volume_mute.png \
    qml/images/white2/volume_down.png \
    qml/images/white2/up.png \
    qml/images/white2/switch_window.png \
    qml/images/white2/stop.png \
    qml/images/white2/shift.png \
    qml/images/white2/settings.png \
    qml/images/white2/seek_forward.png \
    qml/images/white2/seek_backward.png \
    qml/images/white2/right.png \
    qml/images/white2/return.png \
    qml/images/white2/remote.png \
    qml/images/white2/power.png \
    qml/images/white2/play_pause.png \
    qml/images/white2/ok.png \
    qml/images/white2/mouse.png \
    qml/images/white2/menu.png \
    qml/images/white2/like.png \
    qml/images/white2/left.png \
    qml/images/white2/keyboard.png \
    qml/images/white2/info.png \
    qml/images/white2/hscroll.png \
    qml/images/white2/help.png \
    qml/images/white2/exit.png \
    qml/images/white2/down.png \
    qml/images/white2/disconnect.png \
    qml/images/white2/computer.png \
    qml/images/white2/backspace.png \
    qml/images/white2/apps.png \
    qml/harbour-qremotecontrol.qml
}
!sailfish: {
!android: !ios: {
    QML_IMPORT_PATH = qml/
    # Add more folders to ship with the application, here
    folder_01.source = qml
    folder_01.target =
    DEPLOYMENTFOLDERS = folder_01
}

    # Please do not modify the following two lines. Required for deployment.
    # include(qmlapplicationviewer/qmlapplicationviewer.pri)
    include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
    qtcAddDeployment()
}

android: {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml
    RESOURCES += qml.qrc 
}

ios: {
    OTHER_FILES += qremotecontrol2.plist \
                   icons/qremotecontrol.icns
    QMAKE_INFO_PLIST = Info.plist
    #QMAKE_INFO_PLIST_OUT = $${TARGET}.app/Contents/Info.plist
    #RE_TARGETDEPS += $${TARGET}.app/Contents/Info.plist
    #HC_ICONNAME = qremotecontrol.icns
    #QMAKE_POST_LINK += mkdir -p $${OUT_PWD}/Release-iphonesimulator/$${TARGET}.app/Contents/Resources/ $$escape_expand(\n\t)
    #QMAKE_POST_LINK += cp -n $$PWD/icons/$${HC_ICONNAME} $${OUT_PWD}/Release-iphonesimulator/$${TARGET}.app/. $$escape_expand(\n\t)
    #QMAKE_POST_LINK += rm $${OUT_PWD}/Release-iphonesimulator/$${TARGET}.app/Default* $$escape_expand(\n\t)
    #QMAKE_POST_LINK += rm $${OUT_PWD}/Release-iphonesimulator/$${TARGET}.app/Info.plist $$escape_expand(\n\t)
    QMAKE_POST_LINK += cp -n $$PWD/icons/qremotecontrol.iconset/* $${OUT_PWD}/Release-iphonesimulator/$${TARGET}.app/.
    RESOURCES += qml.qrc
    ICON = $$PWD/icons/qremotecontrol.icns
}

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility
MOBILITY += sensors

QT += network
QT += sensors
QT -= svg

SOURCES += src/main.cpp \
            src/qremotecontrolclient.cpp \
            src/wakeonlanpacket.cpp \
            src/platformdetails.cpp \
            src/crc.cpp \
            src/base64.cpp \
            src/qremoteboxclient.cpp

HEADERS += src/qremotecontrolclient.h \
           src/wakeonlanpacket.h \
           src/platformdetails.h \
            src/crc.h \
            src/base64.h \
            src/qremoteboxclient.h

INCLUDEPATH += src/

OTHER_FILES += \
    bar-descriptor.xml \
    qml/MyComponents/coloroverlay.js

RESOURCES += \
    i18.qrc
