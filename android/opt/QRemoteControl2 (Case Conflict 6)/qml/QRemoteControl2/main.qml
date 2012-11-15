// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import RemoteControl 1.0
import "gradients/grey" as GreyGradients
Rectangle {
    property Gradient defaultGradient: GreyGradients.DefaultGradient{}
    property Gradient pressedGradient: GreyGradients.PressedGradient{}
    property Gradient hoveredGradient: GreyGradients.HoveredGradient{}
    property Gradient labelGradient: GreyGradients.LabelGradient{}
    property Gradient barGradient: GreyGradients.BarGradient{}
    property string backgroundImage: "images/background_grey.png"
    border.color: "#555555"
    property color textColor1: "black"
    property color textColor2: "white"
    property int textSize1: width*0.040
    property int textSize2: width*0.05

    id:master
    width: 360
    height: 640
    color: "black"
    state: "networkState"

    Component.onCompleted: {
        remotecontrolPage.buttonPressed.connect(client.sendKeyPress)
        remotecontrolPage.buttonReleased.connect(client.sendKeyRelease)

        connectPage.password = client.password
        connectPage.port = client.port
        connectPage.hostname = client.hostname
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
    }

    Image {
        id: backgroundImage
        anchors.fill: parent
        source: master.backgroundImage
    }
    Row {
        id: centerContainer
        height: parent.height
        NetworkPage {
            id: networkPage
            width: master.width
            height: parent.height
            onRetryClicked: client.openNetworkSession()
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
                x: -master.width*0
            }
        },
        State {
            name: "settingsState"

            PropertyChanges {
                target: centerContainer
                x: -master.width*1
            }
        },
        State {
            name: "startState"

            PropertyChanges {
                target: centerContainer
                x: -master.width*3
            }
        },
        State {
            name: "helpState"

            PropertyChanges {
                target: centerContainer
                x: -master.width*2
            }
        },
        State {
            name: "loadingState"

            PropertyChanges {
                target: centerContainer
                x: -master.width*5
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
        },
        State {
            name: "broadcastState"

            PropertyChanges {
                target: centerContainer
                x: -master.width*4
            }
        },
            State {
                name: "aboutState"

                PropertyChanges {
                    target: centerContainer
                    x: -master.width*6
                }
            }
    ]
    transitions: Transition {
             PropertyAnimation { target: centerContainer; properties: "x"; easing.type: Easing.OutCubic }
         }
}
