// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import RemoteControl 2.0
import QtMobility.sensors 1.1
import Platform 1.0
import "MyComponents"

Rectangle {
    property string backgroundImage: "images/background_grey.png"
    property string imagePath: "images/"
    property string iconTheme: "black"
    property int    screenRotation: 0

    id:master
    width: 360
    height: 640
    anchors.fill: parent
    color: "black"
    state: "networkState"

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
        }
        onFirstStart: master.state = "helpState"
        onConnectingStarted: master.state = "loadingState"
        onBroadcastingStarted: master.state = "broadcastState"
        onNetworkOpened: master.state = "startState"
        onNetworkClosed: master.state = "networkState"

        Component.onDestruction: {
            client.saveSettings()
        }
    }

  OrientationSensor {
        id: orientation
        active: true

        onReadingChanged: {

            if (reading.orientation === OrientationReading.TopUp)
                screenRotation = 0
            else if (reading.orientation === OrientationReading.TopDown)
                screenRotation = 180
            else if (reading.orientation === OrientationReading.RightUp)
                screenRotation = 90
            else if (reading.orientation === OrientationReading.LeftUp)
                screenRotation = -90

            // ... more tests for different orientations ...
        }
    }

    Image {
        id: backgroundImage
        anchors.fill: parent
        source: master.backgroundImage
    }

    Text {
        id: label
        text: qsTr("Warning!<br>No Wireless network connection found, local service discovery unavailable. Check your network connection or use advanced options.")
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        color: theme.primaryTextColor
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
            onContinueClicked: master.state = "startState"
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
            id: broadcastPage
            width: master.width
            height: master.height
            onAbortClicked: {
                master.state = "startState"
                client.abortBroadcasting()
            }
        }
        LoadingPage {
            id: loadingPage
            width: master.width
            height: parent.height
            onAbortClicked: {
                master.state = "startState"
                client.abortConnectionRequest()
            }
        }
        AboutPage {
            id: aboutPage
            width: master.width
            height: parent.height
            onContinueClicked: master.state = "startState"
        }
        RemoteControlPage {
            id: remotecontrolPage
            width: master.width
            height: parent.height
            onDisconnectClicked: client.disconnect()
            onAboutClicked: master.state = "aboutState"
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
                visible: true
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
            }
    ]
    transitions: Transition {
             PropertyAnimation { target: centerContainer; properties: "x"; easing.type: Easing.OutCubic }
         }
}
