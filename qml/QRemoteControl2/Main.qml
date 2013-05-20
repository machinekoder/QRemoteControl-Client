import QtQuick 1.1
import RemoteControl 2.0
import Platform 1.0
import "MyComponents"
import "orientationSensor.js" as OrientationSensor

Rectangle {
    property bool   landscapeMode: (device.width < device.height)
    property bool   active: Qt.application.active

    TextEdit {
        id: dummyEdit
    }

    onActiveChanged: {
        if (active)
        {
            dummyEdit.closeSoftwareInputPanel()
        }
    }

    onLandscapeModeChanged: {
        if (device.landscapeMode)
            master.screenRotation = 0
        else
            master.screenRotation = 90
    }

    id: device
    anchors.fill: parent

    Rectangle {
        property string backgroundImage: "images/background_grey.png"
        property alias  backgroundImageFillMode: backgroundImage.fillMode
        property string imagePath: "images/"
        property string iconTheme: "black"
        property int    screenRotation: 0

        property int generalMargin: Math.round(width*0.02)
        property int buttonWidth: Math.round(width*0.18)
        property int buttonHeight: Math.round(height*0.10)

        property string platform: platform.platform

        id: master
        color: "black"
        state: "networkState"
        width: device.landscapeMode ? device.width : device.height
        height: device.landscapeMode ? device.height : device.width
        rotation: device.landscapeMode ? 0 : -90
        anchors.centerIn: parent

        Component.onCompleted: {
            remotecontrolPage.buttonPressed.connect(client.sendKeyPress)
            remotecontrolPage.buttonReleased.connect(client.sendKeyRelease)

            connectPage.password = client.password
            connectPage.port = client.port
            connectPage.hostname = client.hostname

            wakeOnLanPage.macAddress = client.wolMacAddress
            wakeOnLanPage.hostname = client.wolHostname
            wakeOnLanPage.udpPort = client.wolPort
            wakeOnLanPage.datagramNumber = client.wolDatagramNumber

            settingsPage.setScreenOrientation(client.screenOrientation)
            settingsPage.setLanguage(client.language)
            if ((platform.platform === "MeeGo")
                    || (platform.platform === "Symbian")
                    || (platform.platform === "Android")
                    || (platform.platform === "BlackBerry")
                    || (platform.platform === "Simulator"))
            {
                OrientationSensor.createOrientationSensor()
            }
        }

        Keys.onVolumeUpPressed: {
            client.sendKeyPress(6)
            client.sendKeyRelease(6)
            event.accepted = true
        }

        Keys.onVolumeDownPressed: {
            client.sendKeyPress(5)
            client.sendKeyRelease(5)
            event.accepted = true
        }

        Details {
            id: platform
        }

        Style {
            id: theme
        }

        Client {
            id: client
            onConnected: master.state = "remoteControlState"
            onDisconnected: {
                master.state = "startState"
                connectPage.password = client.password
                connectPage.hostname = client.hostname
                connectPage.port = client.port
                connectPage.forceActiveFocus()  // close eventuall open keyboard
            }
            onFirstStart: master.state = "helpState"
            onConnectingStarted: master.state = "loadingState"
            onBroadcastingStarted: master.state = "broadcastState"
            onNetworkOpened: master.state = "startState"
            onNetworkClosed: master.state = "networkState"
            onTrialExpired:  master.state = "trialState"
            onClearActions: remotecontrolPage.clearActions();

            Component.onDestruction: {
                client.saveSettings()
            }
        }

        Image {
            id: backgroundImage
            anchors.fill: parent
            source: master.backgroundImage
        }

        Text {
            id: label
            text: qsTr("Warning!<br>No Wireless network connection found, local service discovery unavailable. Check your network connection or use advanced options.") + client.emptyString
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.05
            anchors.left: parent.left
            anchors.leftMargin: anchors.rightMargin
            anchors.verticalCenter: parent.verticalCenter
            color: theme.primaryTextColor
            font.pixelSize: theme.hintFontSize
            rotation: master.screenRotation
        }

        Row {
            id: centerContainer
            height: parent.height
            WakeOnLanPage {
                id: wakeOnLanPage
                width: master.width
                height: parent.height
                onBackClicked: {
                    master.state = "startState"
                }
                onWolClicked: {
                    client.wolMacAddress = wakeOnLanPage.macAddress
                    client.wolHostname = wakeOnLanPage.hostname
                    client.wolPort = wakeOnLanPage.udpPort
                    client.wolDatagramNumber = wakeOnLanPage.datagramNumber
                    if (client.sendWakeOnLan())
                    {
                        master.state = "startState";
                    }
                }
            }
            SettingsPage {
                id: settingsPage
                width: master.width
                height: parent.height
                onContinueClicked: {
                    if (client.isConnected())
                    {
                        master.state = "remoteControlState";
                    }
                    else
                    {
                        master.state = "startState";
                    }
            }
            }
            HelpPage {
                id: helpPage
                width: master.width
                height: parent.height
                onContinueClicked: master.state = "startState"
            }
            ConnectPage {
                id: connectPage
                width: master.width
                height: parent.height
                onHelpClicked: master.state = "helpState"
                onSettingsClicked: master.state = "settingsState"
                onInfoClicked: master.state = "aboutState"
                onBroadcastClicked: {
                    client.password = connectPage.password
                    //client.hostname = connectPage.hostname
                    client.port = connectPage.port
                    client.clearServerList()
                    client.startBroadcasting()
                }
                onConnectClicked: {
                    client.password = connectPage.password
                    client.hostname = connectPage.hostname
                    client.port = connectPage.port
                    loadingPage.showNormalText()
                    client.connectToHost()
                }
                onAdvancedClicked: {
                    label.visible = !connectPage.advancedSelected && master.state == "networkState"
                }
                onWolClicked: {
                    master.state = "wakeOnLanState"
                }
            }
            BroadcastPage {
                id:                 broadcastPage
                width:              master.width
                height:             master.height
                onAbortClicked: {
                    master.state = "startState"
                    client.abortBroadcasting()
                }
            }
            LoadingPage {
                id:                 loadingPage
                width:              master.width
                height:             parent.height
                onAbortClicked: {
                    master.state = "startState"
                    client.abortConnectionRequest()
                }
            }
            AboutPage {
                id:                 aboutPage
                width:              master.width
                height:             parent.height
                onContinueClicked:  master.state = "startState"
            }
            RemoteControlPage {
                id:                 remotecontrolPage
                width:              master.width
                height:             parent.height
                onDisconnectClicked:client.disconnect()
                onAboutClicked:     master.state = "aboutState"
                onSettingsClicked:  master.state = "settingsState"
                opacity:            (master.state == "remoteControlState") * 1

                Behavior on opacity {
                                 NumberAnimation { easing.type: Easing.OutCubic; duration: 500 }
                             }
            }
            TrialPage {
                id:                 trailPage
                width:              master.width
                height:             parent.height
                onExitClicked:      Qt.quit()
                visible:            (master.state == "trialState") * 1

                Behavior on opacity {
                                 NumberAnimation { easing.type: Easing.OutCubic; duration: 500 }
                             }
            }
        }

        states: [
            State {
                name: "networkState"

                PropertyChanges {
                    target: centerContainer
                    x: -master.width*3
                }

                PropertyChanges {
                    target: label
                    visible: !(platform.platform === "Android") // Deactivate the warning on Android as it seems not work properly
                }
            },
            State {
                name: "settingsState"

                PropertyChanges {
                    target: centerContainer
                    x: -master.width*1
                }

                PropertyChanges {
                    target: label
                    visible: false
                }
            },
            State {
                name: "wakeOnLanState"

                PropertyChanges {
                    target: centerContainer
                    x: -master.width*0
                }

                PropertyChanges {
                    target: label
                    visible: false
                }
            },
            State {
                name: "startState"

                PropertyChanges {
                    target: centerContainer
                    x: -master.width*3
                }

                PropertyChanges {
                    target: label
                    visible: false
                }
            },
            State {
                name: "helpState"

                PropertyChanges {
                    target: centerContainer
                    x: -master.width*2
                }

                PropertyChanges {
                    target: label
                    visible: false
                }
            },
            State {
                name: "loadingState"

                PropertyChanges {
                    target: centerContainer
                    x: -master.width*5
                }

                PropertyChanges {
                    target: label
                    visible: false
                }
            },
            State {
                name: "remoteControlState"

                PropertyChanges {
                    target: centerContainer
                    x: -master.width*7
                }
                PropertyChanges {
                    target: remotecontrolPage
                    state: "buttonPageState"
                }

                PropertyChanges {
                    target: label
                    visible: false
                }
            },
            State {
                name: "broadcastState"

                PropertyChanges {
                    target: centerContainer
                    x: -master.width*4
                }

                PropertyChanges {
                    target: label
                    visible: false
                }
            },
                State {
                    name: "aboutState"

                    PropertyChanges {
                        target: centerContainer
                        x: -master.width*6
                    }

                    PropertyChanges {
                        target: label
                        visible: false
                    }
            },
                State {
                    name: "trialState"

                    PropertyChanges {
                        target: centerContainer
                        x: -master.width*7
                    }

                    PropertyChanges {
                        target: label
                        visible: false
                    }
            }
        ]
        transitions: Transition {
                 PropertyAnimation { target: centerContainer; properties: "x"; easing.type: Easing.OutCubic }
                 PropertyAnimation { target: centerContainer; properties: "opacity"; easing.type: Easing.OutCubic }
             }
    }
}
