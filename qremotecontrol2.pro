TARGET = qremotecontrol2
VERSION = 2.3.0

TRANSLATIONS = i18/de.ts i18/ru.ts

DEFINES += VERSION=\"\\\"$$VERSION\\\"\"

# Add more folders to ship with the application, here
folder_01.source += qml/QRemoteControl2
folder_01.target = qml/
#folder_02.source = ../MyComponents
#folder_02.target = /opt/$(TARGET)/bin/
DEPLOYMENTFOLDERS = folder_01
#folder_02

# Additional import path used to resolve QML modules in Creator's code model
#QML_IMPORT_PATH += ../
QML_IMPORT_PATH =

symbian: {
TARGET.UID3 = 0x200629ab
DEPLOYMENT.installer_header = 0x2002CCCF
DEPLOYMENT.display_name += QRemoteControl2
my_deployment.pkg_prerules += \
        "; Dependency to Symbian Qt Quick components" \
        "(0x200346DE), 1, 1, 0, {\"Qt Quick components\"}"
DEPLOYMENT += my_deployment
ICON = qremotecontrol2.svg

# Allow network access on Symbian
TARGET.CAPABILITY += NetworkServices
#TARGET.CAPABILITY += ReadUserData
TARGET.CAPABILITY += WriteDeviceData
TARGET.CAPABILITY += ReadDeviceData
}

contains(MEEGO_EDITION,harmattan): {
           CONFIG += harmattan
           DEFINES += Q_OS_MEEGO
        }

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
 CONFIG += mobility
 MOBILITY += sensors

QT += network
#QT += webkit

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
            qremotecontrolclient.cpp \
            wakeonlanpacket.cpp
HEADERS += qremotecontrolclient.h \
           wakeonlanpacket.h

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable-mdpi/icon.png \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable/icon.png \
    android/res/drawable/logo.png \
    android/res/values/libs.xml \
    android/res/values/strings.xml \
    android/res/layout/splash.xml \
    android/res/values-et/strings.xml \
    android/res/values-zh-rCN/strings.xml \
    android/res/values-zh-rTW/strings.xml \
    android/res/values-es/strings.xml \
    android/res/values-nb/strings.xml \
    android/res/values-ms/strings.xml \
    android/res/values-it/strings.xml \
    android/res/values-pl/strings.xml \
    android/res/values-id/strings.xml \
    android/res/values-pt-rBR/strings.xml \
    android/res/values-rs/strings.xml \
    android/res/values-fr/strings.xml \
    android/res/values-ro/strings.xml \
    android/res/values-nl/strings.xml \
    android/res/values-de/strings.xml \
    android/res/values-ja/strings.xml \
    android/res/values-ru/strings.xml \
    android/res/values-fa/strings.xml \
    android/res/values-el/strings.xml \
    android/src/org/kde/necessitas/origo/QtActivity.java \
    android/src/org/kde/necessitas/origo/QtApplication.java \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/AndroidManifest.xml \
    android/version.xml \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    Test.qml

RESOURCES += \
    i18.qrc

