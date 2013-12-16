TARGET = qremotecontrol2
VERSION = 2.6.0

TRANSLATIONS = i18/de.ts i18/ru.ts i18/uk.ts i18/es.ts

DEFINES += VERSION=\"\\\"$$VERSION\\\"\"
#DEFINES += TRIAL

# Add more folders to ship with the application, here
#folder_01.source += qml/QRemoteControl2
#folder_01.target = qml/
#DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
#QML_IMPORT_PATH += ../
QML_IMPORT_PATH = qml/QRemoteControl2

symbian: {
TARGET.UID3 = 0x200629ab
#TARGET.UID3 = 0xE0000001
DEPLOYMENT.installer_header = 0x2002CCCF
DEPLOYMENT.display_name += QRemoteControl2
my_deployment.pkg_prerules += \
        "; Dependency to Symbian Qt Quick components" \
        "(0x200346DE), 1, 1, 0, {\"Qt Quick components\"}"
DEPLOYMENT += my_deployment
ICON = qremotecontrol2.svg

# Allow network access on Symbian
TARGET.CAPABILITY += NetworkServices
TARGET.CAPABILITY += WriteDeviceData
TARGET.CAPABILITY += ReadDeviceData
TARGET.CAPABILITY += ReadUserData
}

contains(MEEGO_EDITION,harmattan): {
           CONFIG += harmattan
           DEFINES += Q_OS_MEEGO
        }

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility
MOBILITY += sensors
contains(DEFINES,TRIAL): {
MOBILITY += systeminfo
}

QT += network
QT += widgets
QT += sensors
QT -= svg

SOURCES += src/main.cpp \
            src/qremotecontrolclient.cpp \
            src/wakeonlanpacket.cpp \
            src/platformdetails.cpp
HEADERS += src/qremotecontrolclient.h \
           src/wakeonlanpacket.h \
           src/platformdetails.h

INCLUDEPATH += src/

# Please do not modify the following two lines. Required for deployment.
# include(qmlapplicationviewer/qmlapplicationviewer.pri)
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    bar-descriptor.xml \
    android/AndroidManifest.xml \
    qml/QRemoteControl2/orientationSensor.js \
    qml/QRemoteControl2/AboutPage.qml \
    qml/QRemoteControl2/ActionsPage.qml \
    qml/QRemoteControl2/Keyboard.qml \
    qml/QRemoteControl2/KeyboardButton.qml \
    qml/QRemoteControl2/SettingsPage.qml \
    qml/QRemoteControl2/SplashScreen.qml \
    qml/QRemoteControl2/BroadcastPage.qml \
    qml/QRemoteControl2/ButtonBar.qml \
    qml/QRemoteControl2/KeyboardButton2.qml \
    qml/QRemoteControl2/KeyboardPage.qml \
    qml/QRemoteControl2/ButtonPage.qml \
    qml/QRemoteControl2/ConnectPage.qml \
    qml/QRemoteControl2/LoadingPage.qml \
    qml/QRemoteControl2/Main.qml \
    qml/QRemoteControl2/StyleTest.qml \
    qml/QRemoteControl2/TouchPad.qml \
    qml/QRemoteControl2/TouchPadPage.qml \
    qml/QRemoteControl2/TrialPage.qml \
    qml/QRemoteControl2/HelpPage.qml \
    qml/QRemoteControl2/init.qml \
    qml/QRemoteControl2/initMeego.qml \
    qml/QRemoteControl2/NavigationButton.qml \
    qml/QRemoteControl2/RemoteControlPage.qml \
    qml/QRemoteControl2/WakeOnLanPage.qml \
    qml/QRemoteControl2/styles/Black.qml \
    qml/QRemoteControl2/styles/Blue.qml \
    qml/QRemoteControl2/styles/Gold.qml \
    qml/QRemoteControl2/styles/Green.qml \
    qml/QRemoteControl2/styles/Grey.qml \
    qml/QRemoteControl2/styles/Nerdy.qml \
    qml/QRemoteControl2/styles/Pink.qml \
    qml/QRemoteControl2/styles/Red.qml \
    qml/QRemoteControl2/styles/Silver.qml \
    qml/QRemoteControl2/styles/Tech.qml \
    qml/QRemoteControl2/styles/White.qml \
    qml/QRemoteControl2/MyComponents/feedback.js \
    qml/QRemoteControl2/MyComponents/Button.qml \
    qml/QRemoteControl2/MyComponents/Label.qml \
    qml/QRemoteControl2/MyComponents/LineEdit.qml \
    qml/QRemoteControl2/MyComponents/Slider.qml \
    qml/QRemoteControl2/MyComponents/SpinBox.qml \
    qml/QRemoteControl2/MyComponents/StatBar.qml \
    qml/QRemoteControl2/MyComponents/Style.qml \
    qml/QRemoteControl2/MyComponents/qmldir \
    qml/QRemoteControl2/MyComponents/gradients/DefaultGradient.qml \
    qml/QRemoteControl2/MyComponents/gradients/HoveredGradient.qml \
    qml/QRemoteControl2/MyComponents/gradients/PressedGradient.qml \
    qml/QRemoteControl2/images/background_pink.png \
    qml/QRemoteControl2/images/background_red.png \
    qml/QRemoteControl2/images/background_silver.png \
    qml/QRemoteControl2/images/background_white.png \
    qml/QRemoteControl2/images/body_background_dark.png \
    qml/QRemoteControl2/images/qrc.png \
    qml/QRemoteControl2/images/qrc_trial.png \
    qml/QRemoteControl2/images/tile.png \
    qml/QRemoteControl2/images/background_black.png \
    qml/QRemoteControl2/images/background_blue.png \
    qml/QRemoteControl2/images/background_gold.png \
    qml/QRemoteControl2/images/background_green.png \
    qml/QRemoteControl2/images/background_grey.png \
    qml/QRemoteControl2/images/black/apps.png \
    qml/QRemoteControl2/images/black/backspace.png \
    qml/QRemoteControl2/images/black/computer.png \
    qml/QRemoteControl2/images/black/disconnect.png \
    qml/QRemoteControl2/images/black/down.png \
    qml/QRemoteControl2/images/black/exit.png \
    qml/QRemoteControl2/images/black/help.png \
    qml/QRemoteControl2/images/black/hscroll.png \
    qml/QRemoteControl2/images/black/info.png \
    qml/QRemoteControl2/images/black/keyboard.png \
    qml/QRemoteControl2/images/black/left.png \
    qml/QRemoteControl2/images/black/like.png \
    qml/QRemoteControl2/images/black/menu.png \
    qml/QRemoteControl2/images/black/mouse.png \
    qml/QRemoteControl2/images/black/ok.png \
    qml/QRemoteControl2/images/black/play_pause.png \
    qml/QRemoteControl2/images/black/power.png \
    qml/QRemoteControl2/images/black/remote.png \
    qml/QRemoteControl2/images/black/return.png \
    qml/QRemoteControl2/images/black/right.png \
    qml/QRemoteControl2/images/black/seek_backward.png \
    qml/QRemoteControl2/images/black/seek_forward.png \
    qml/QRemoteControl2/images/black/settings.png \
    qml/QRemoteControl2/images/black/shift.png \
    qml/QRemoteControl2/images/black/stop.png \
    qml/QRemoteControl2/images/black/switch_window.png \
    qml/QRemoteControl2/images/black/up.png \
    qml/QRemoteControl2/images/black/volume_down.png \
    qml/QRemoteControl2/images/black/volume_mute.png \
    qml/QRemoteControl2/images/black/volume_up.png \
    qml/QRemoteControl2/images/black/vscroll.png \
    qml/QRemoteControl2/images/black/zoom_in.png \
    qml/QRemoteControl2/images/black/zoom_out.png \
    qml/QRemoteControl2/images/lang/english.png \
    qml/QRemoteControl2/images/lang/german.png \
    qml/QRemoteControl2/images/lang/russian.png \
    qml/QRemoteControl2/images/lang/spanish.png \
    qml/QRemoteControl2/images/lang/ukrainian.png \
    qml/QRemoteControl2/images/nerdy/apps.png \
    qml/QRemoteControl2/images/nerdy/backspace.png \
    qml/QRemoteControl2/images/nerdy/computer.png \
    qml/QRemoteControl2/images/nerdy/disconnect.png \
    qml/QRemoteControl2/images/nerdy/down.png \
    qml/QRemoteControl2/images/nerdy/exit.png \
    qml/QRemoteControl2/images/nerdy/help.png \
    qml/QRemoteControl2/images/nerdy/hscroll.png \
    qml/QRemoteControl2/images/nerdy/info.png \
    qml/QRemoteControl2/images/nerdy/keyboard.png \
    qml/QRemoteControl2/images/nerdy/left.png \
    qml/QRemoteControl2/images/nerdy/like.png \
    qml/QRemoteControl2/images/nerdy/menu.png \
    qml/QRemoteControl2/images/nerdy/mouse.png \
    qml/QRemoteControl2/images/nerdy/ok.png \
    qml/QRemoteControl2/images/nerdy/play_pause.png \
    qml/QRemoteControl2/images/nerdy/power.png \
    qml/QRemoteControl2/images/nerdy/remote.png \
    qml/QRemoteControl2/images/nerdy/return.png \
    qml/QRemoteControl2/images/nerdy/right.png \
    qml/QRemoteControl2/images/nerdy/seek_backward.png \
    qml/QRemoteControl2/images/nerdy/seek_forward.png \
    qml/QRemoteControl2/images/nerdy/settings.png \
    qml/QRemoteControl2/images/nerdy/shift.png \
    qml/QRemoteControl2/images/nerdy/stop.png \
    qml/QRemoteControl2/images/nerdy/switch_window.png \
    qml/QRemoteControl2/images/nerdy/up.png \
    qml/QRemoteControl2/images/nerdy/volume_down.png \
    qml/QRemoteControl2/images/nerdy/volume_mute.png \
    qml/QRemoteControl2/images/nerdy/volume_up.png \
    qml/QRemoteControl2/images/nerdy/vscroll.png \
    qml/QRemoteControl2/images/nerdy/zoom_in.png \
    qml/QRemoteControl2/images/nerdy/zoom_out.png \
    qml/QRemoteControl2/images/white/apps.png \
    qml/QRemoteControl2/images/white/backspace.png \
    qml/QRemoteControl2/images/white/computer.png \
    qml/QRemoteControl2/images/white/disconnect.png \
    qml/QRemoteControl2/images/white/down.png \
    qml/QRemoteControl2/images/white/exit.png \
    qml/QRemoteControl2/images/white/help.png \
    qml/QRemoteControl2/images/white/hscroll.png \
    qml/QRemoteControl2/images/white/info.png \
    qml/QRemoteControl2/images/white/keyboard.png \
    qml/QRemoteControl2/images/white/left.png \
    qml/QRemoteControl2/images/white/like.png \
    qml/QRemoteControl2/images/white/menu.png \
    qml/QRemoteControl2/images/white/mouse.png \
    qml/QRemoteControl2/images/white/ok.png \
    qml/QRemoteControl2/images/white/play_pause.png \
    qml/QRemoteControl2/images/white/power.png \
    qml/QRemoteControl2/images/white/remote.png \
    qml/QRemoteControl2/images/white/return.png \
    qml/QRemoteControl2/images/white/right.png \
    qml/QRemoteControl2/images/white/seek_backward.png \
    qml/QRemoteControl2/images/white/seek_forward.png \
    qml/QRemoteControl2/images/white/settings.png \
    qml/QRemoteControl2/images/white/shift.png \
    qml/QRemoteControl2/images/white/stop.png \
    qml/QRemoteControl2/images/white/switch_window.png \
    qml/QRemoteControl2/images/white/up.png \
    qml/QRemoteControl2/images/white/volume_down.png \
    qml/QRemoteControl2/images/white/volume_mute.png \
    qml/QRemoteControl2/images/white/volume_up.png \
    qml/QRemoteControl2/images/white/vscroll.png \
    qml/QRemoteControl2/images/white/zoom_in.png \
    qml/QRemoteControl2/images/white/zoom_out.png \
    qml/QRemoteControl2/NavigationPanel.qml \
    qml/QRemoteControl2/MusicControl.qml

RESOURCES += \
    i18.qrc \
    qml.qrc

