TARGET = qremotecontrol2
VERSION = 2.5.1

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
 MOBILITY += systeminfo

QT += network
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
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    bar-descriptor.xml \
    android/src/org/qtproject/qt5/android/bindings/QtActivity.java \
    android/src/org/qtproject/qt5/android/bindings/QtApplication.java \
    android/src/org/qtproject/qt5/android/bindings/QtActivity.java \
    android/src/org/qtproject/qt5/android/bindings/QtApplication.java \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
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
    android/version.xml \
    android/AndroidManifest.xml \
    android/res/values/libs.xml

RESOURCES += \
    i18.qrc \
    qml.qrc

