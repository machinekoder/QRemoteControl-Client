import QtQuick 2.0
import harbour.qremotecontrol.RemoteControl 2.0 as RemoteControl
import harbour.qremotecontrol.RemoteBox 1.0 as RemoteBox
import harbour.qremotecontrol.Platform 1.0 as Platform
import "MyComponents"
import "orientationSensor.js" as OrientationSensor
import "styles" as Styles

Item {
    property bool   landscapeMode: (device.width < device.height)
    property bool   active: Qt.application.active

    onWidthChanged: console.log(width +"x"+ height)
    onHeightChanged: console.log(width +"x"+ height)

    id: device
    anchors.fill: parent

    TextEdit {
        id: dummyEdit
    }

    onActiveChanged: {
        if (active)
        {
            Qt.inputMethod.hide();
        }
    }

    onLandscapeModeChanged: {
        if (device.landscapeMode)
            master.screenRotation = 0
        else
            master.screenRotation = 90
    }

    // Capture the Android Back key and backspace key
    // on the desktop tp go back in the application
    // focus needs to be true to capture key events
    focus: true
    Keys.onReleased: {
        if ((event.key === Qt.Key_Back) ||
                (event.key === Qt.Key_Backspace)) {
            goBack()
            event.accepted = true
        }
    }

    function goBack()
    {
        if (master.state == "remoteControlState")
            client.disconnect()
        else if ((master.state == "startState") || (master.state == "networkState"))
            Qt.quit()
        else
            master.state = master.lastState
    }

    function lockScreenOrientation()
    {
        master.oldScreenOrientation = client.screenOrientation
        master.oldScreenRotation = master.screenRotation

        client.screenOrientation = 1
        master.screenRotation = 0
        if (!device.landscapeMode)
             master.screenRotation += 90
    }

    function releaseScreenOrientation()
    {
        client.screenOrientation = master.oldScreenOrientation
        master.screenRotation = master.oldScreenRotation
    }

    function loadBackgroundImage(imageUrl, effect, fillMode)
    {
        backgroundImage.source = imageUrl
        backgroundImage.fillMode = fillMode
        backgroundImage.effectEnabled = effect
    }

    Rectangle {
        property string backgroundImage: "images/background_grey.png"
        property string imagePath: "images/"
        property string iconTheme: "black"
        property int    screenRotation: 0
        property int    oldScreenOrientation: 0
        property int    oldScreenRotation: 0

        property double generalMarginFactor: 0.012
        property double buttonWidthFactor: 0.18
        property double buttonHeightFactor: 0.098
        property int generalMargin: Math.round(height*generalMarginFactor) // configured for a maximum screen aspect ration of 16:9
        property int buttonWidth: Math.round(width*buttonWidthFactor)
        property int buttonHeight: Math.round(height*buttonHeightFactor)
        property int buttonMinimumAspectDifference: master.width-generalMargin*6-buttonHeight*5

        property string platform: platform.platform
        property Style theme: theme

        property string lastState: ""

        id: master
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
                    //|| (platform.platform === "Android")
                    || (platform.platform === "BlackBerry")
                    || (platform.platform === "Simulator")
                    || (platform.platform === "SailfishOS"))
            {
                OrientationSensor.createOrientationSensor()
            }

            if (client.runCount == 0)
            {
                firstStartTimer.running = true
            }

            if ((client.runCount !== 0) && ((client.runCount % 10) == 0) )  // start social page at every 10th start
            {
                socialTimer.running = true
            }
        }

        /** Timer to trigger the social page after startup */
        Timer {
            id: socialTimer
            running: false
            repeat: false
            interval: 1000
            onTriggered: connectPage.socialClicked()
        }

        /** Timer to trigger the tutorial or help on first start */
        Timer {
            id: firstStartTimer
            running: false
            repeat: false
            interval: 1000
            onTriggered: {
                master.lastState = master.state
                //master.state = "tutorialState"
                master.state = "helpState"
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

        Platform.Details {
            id: platform
        }

        Style {
            id: theme
        }

        RemoteControl.Client {
            id: client
            onConnected: master.state = "remoteControlState"
            onDisconnected: {
                master.state = "startState"
                connectPage.password = client.password
                connectPage.hostname = client.hostname
                connectPage.port = client.port
                connectPage.forceActiveFocus()  // close eventuall open keyboard
            }
            onConnectingStarted: master.state = "loadingState"
            onBroadcastingStarted: master.state = "broadcastState"
            onNetworkOpened: master.state = "startState"
            onNetworkClosed: master.state = "networkState"
            onClearActions: remotecontrolPage.clearActions();

            Component.onDestruction: {
                client.saveSettings()
            }
        }

        RemoteBox.Client {
            id: remoteBoxClient
            onConnected: master.state = "remoteBoxState"
            onDisconnected: {
                    master.state = "startState"
                    connectPage.password = ""
                    connectPage.hostname = remoteBoxClient.networkHostname
                    connectPage.port = remoteBoxClient.networkPort
                    connectPage.forceActiveFocus() // close eventuall open keyboard
                }
        }

        JollaImage {
            id: backgroundImage
            anchors.fill: parent
            source: master.backgroundImage
            patternSize: master.buttonWidth * 0.35
            blurRadius: master.buttonWidth * 0.45
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
            color: theme.primaryColor
            font.pixelSize: theme.fontSizeMedium
            rotation: master.screenRotation
        }

        Item {
            id: centerContainer
            anchors.fill: parent

            WakeOnLanPage {
                id: wakeOnLanPage
                anchors.fill: parent
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
                anchors.fill: parent
                onContinueClicked: {
                    if (client.isConnected())
                    {
                        master.state = "remoteControlState";
                    }
                    else if (remoteBoxClient.networkConnected)
                    {
                        master.state = "remoteBoxState"
                    }
                    else
                    {
                        master.state = master.lastState;
                    }
                }
            }
            HelpPage {
                id: helpPage
                anchors.fill: parent
                onContinueClicked: master.state = master.lastState
            }
            SocialPage {
                id: socialPage
                anchors.fill: parent
                onContinueClicked: master.state = master.lastState
            }
            ConnectPage {
                id: connectPage
                anchors.fill: parent
                onHelpClicked: {
                    master.lastState = master.state
                    master.state = "helpState"
                }
                onSocialClicked: {
                    master.lastState = master.state
                    master.state = "socialState"
                }
                onSettingsClicked: {
                    master.lastState = master.state
                    master.state = "settingsState"
                }
                onInfoClicked: {
                    master.lastState = master.state
                    master.state = "aboutState"
                }
                onBroadcastClicked: {
                    master.lastState = master.state
                    client.password = connectPage.password
                    //client.hostname = connectPage.hostname
                    client.port = connectPage.port
                    client.clearServerList()
                    client.startBroadcasting()
                }
                onConnectClicked: {
                    master.lastState = master.state
                    client.password = connectPage.password
                    client.hostname = connectPage.hostname
                    client.port = connectPage.port
                    loadingPage.showNormalText()
                    client.connectToHost()
                }
                onAdvancedClicked: {
                    label.visible = !connectPage.advancedSelected && (master.state == "networkState")
                }
                onListClicked: {
                    label.visible = !connectPage.listSelected && (master.state == "networkState")
                }
                onWolClicked: {
                    master.lastState = master.state
                    master.state = "wakeOnLanState"
                }
            }
            BroadcastPage {
                id:                 broadcastPage
                anchors.fill:       parent
                onAbortClicked: {
                    master.state = master.lastState
                    client.abortBroadcasting()
                }
            }
            LoadingPage {
                id:                 loadingPage
                anchors.fill:       parent
                onAbortClicked: {
                    master.state = master.lastState
                    client.abortConnectionRequest()
                }
            }
            AboutPage {
                id:                 aboutPage
                anchors.fill: parent
                onContinueClicked:  master.state = master.lastState
            }
            RemoteControlPage {
                id:                 remotecontrolPage
                anchors.fill:       parent
                onDisconnectClicked:client.disconnect()
                onAboutClicked:     master.state = "aboutState"
                onSettingsClicked:  master.state = "settingsState"
            }
            RemoteBoxPage {
                id:                 remoteBoxPage
                anchors.fill:       parent
                onDisconnectClicked:remoteBoxClient.closeNetwork()
                onSettingsClicked:  master.state = "settingsState"
            }
            TutorialPage {
                id:                 tutorialPage
                anchors.fill:       parent
                onTutorialFinished: master.state = master.lastState
                onTutorialAborted:  master.state = master.lastState
            }
        }

        states: [
            State {
                name: "networkState"
                PropertyChanges { target: wakeOnLanPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: settingsPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: helpPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: connectPage; opacity: 1.0; z: 1 }
                PropertyChanges { target: broadcastPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: loadingPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: aboutPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remotecontrolPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: label; visible: true}
                PropertyChanges { target: socialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remoteBoxPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 0.0; z: 0 }
                StateChangeScript {
                    name: "closeAllSettings"
                    script:connectPage.closeAllSettings()
                }
            },
            State {
                name: "settingsState"
                PropertyChanges { target: wakeOnLanPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: settingsPage; opacity: 1.0; z: 1 }
                PropertyChanges { target: helpPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: connectPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: broadcastPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: loadingPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: aboutPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remotecontrolPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: socialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remoteBoxPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: label; visible: false}
            },
            State {
                name: "wakeOnLanState"
                PropertyChanges { target: wakeOnLanPage; opacity: 1.0; z: 1 }
                PropertyChanges { target: settingsPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: helpPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: connectPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: broadcastPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: loadingPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: aboutPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remotecontrolPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: socialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remoteBoxPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: label; visible: false}
            },
            State {
                name: "startState"
                PropertyChanges { target: wakeOnLanPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: settingsPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: helpPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: connectPage; opacity: 1.0; z: 1 }
                PropertyChanges { target: broadcastPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: loadingPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: aboutPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remotecontrolPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: socialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remoteBoxPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: label; visible: false}
            },
            State {
                name: "helpState"
                PropertyChanges { target: wakeOnLanPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: settingsPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: helpPage; opacity: 1.0; z: 1 }
                PropertyChanges { target: connectPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: broadcastPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: loadingPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: aboutPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remotecontrolPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: socialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remoteBoxPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: label; visible: false}
            },
            State {
                name: "socialState"
                PropertyChanges { target: wakeOnLanPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: settingsPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: helpPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: connectPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: broadcastPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: loadingPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: aboutPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remotecontrolPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: socialPage; opacity: 1.0; z: 1 }
                PropertyChanges { target: remoteBoxPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: label; visible: false}
            },
            State {
                name: "loadingState"
                PropertyChanges { target: wakeOnLanPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: settingsPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: helpPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: connectPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: broadcastPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: loadingPage; opacity: 1.0; z: 1 }
                PropertyChanges { target: aboutPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remotecontrolPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: socialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remoteBoxPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: label; visible: false}
            },
            State {
                name: "remoteControlState"
                PropertyChanges { target: wakeOnLanPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: settingsPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: helpPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: connectPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: broadcastPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: loadingPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: aboutPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remotecontrolPage; opacity: 1.0; z: 1 }
                PropertyChanges { target: socialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remoteBoxPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: label; visible: false}
                PropertyChanges { target: remotecontrolPage; state: "buttonPageState" }
            },
            State {
                name: "broadcastState"
                PropertyChanges { target: wakeOnLanPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: settingsPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: helpPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: connectPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: broadcastPage; opacity: 1.0; z: 1 }
                PropertyChanges { target: loadingPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: aboutPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remotecontrolPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: socialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remoteBoxPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: label; visible: false}
            },
            State {
                name: "aboutState"
                PropertyChanges { target: wakeOnLanPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: settingsPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: helpPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: connectPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: broadcastPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: loadingPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: aboutPage; opacity: 1.0; z: 1 }
                PropertyChanges { target: remotecontrolPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: socialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remoteBoxPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: label; visible: false}
            },
            State {
                name: "remoteBoxState"
                PropertyChanges { target: wakeOnLanPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: settingsPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: helpPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: connectPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: broadcastPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: loadingPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: aboutPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remotecontrolPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: socialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remoteBoxPage; opacity: 1.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: label; visible: false}
            },
            State {
                name: "tutorialState"
                PropertyChanges { target: wakeOnLanPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: settingsPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: helpPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: connectPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: broadcastPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: loadingPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: aboutPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remotecontrolPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: socialPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: remoteBoxPage; opacity: 0.0; z: 0 }
                PropertyChanges { target: tutorialPage; opacity: 1.0; z: 0 }
                PropertyChanges { target: label; visible: false}
            }
        ]
        transitions: Transition {
           NumberAnimation { targets: [wakeOnLanPage, settingsPage, helpPage, connectPage, broadcastPage, loadingPage, aboutPage, remotecontrolPage, tutorialPage]; properties: "opacity"; duration: 300}
        }
    }
}
