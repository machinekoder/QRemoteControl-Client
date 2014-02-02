TARGET = qremotecontrol2
VERSION = 2.6.0

TRANSLATIONS = i18/de.ts i18/ru.ts i18/uk.ts i18/es.ts

DEFINES += VERSION=\"\\\"$$VERSION\\\"\"
#DEFINES += TRIAL


# Additional import path used to resolve QML modules in Creator's code model
#QML_IMPORT_PATH += ../

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
    OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog
}

sailfish: {
    CONFIG += sailfishapp
    DEFINES += Q_OS_SAILFISH
    OTHER_FILES += rpm/qremotecontrol2.yaml
}
else
{
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
    RESOURCES += qml.qrc
}

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility
MOBILITY += sensors
contains(DEFINES,TRIAL): {
    MOBILITY += systeminfo
}

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
    qremotecontrol2.desktop \
    bar-descriptor.xml

RESOURCES += \
    i18.qrc
