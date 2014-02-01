// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "MyComponents/"
//import MyComponents 1.0

Item {
    signal buttonPressed(int id)
    signal buttonReleased(int id)
    signal disconnectClicked
    signal aboutClicked
    signal settingsClicked

    id: mainRect
    width: 380
    height: 640
    state: "buttonPageState"

    Component.onCompleted: {
        buttonPage.buttonPressed.connect(buttonPressed)
        buttonPage.buttonReleased.connect(buttonReleased)
        buttonPage.disconnectClicked.connect(disconnectClicked)
        buttonPage.settingsClicked.connect(settingsClicked)
    }

    Item {
        id: pageStack

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: buttonbar.top

        ButtonPage {
            id: buttonPage
            anchors.fill: parent
            onInfoButtonClicked: aboutClicked()
        }
        ActionsPage {
            id: actionsPage
            anchors.fill: parent
        }
        TouchPadPage {
            id: touchpadPage
            anchors.fill: parent
        }
        KeyboardPage {
            id: keyboardPage
            anchors.fill: parent
        }
    }

    ButtonBar {
        id: buttonbar
        height: master.buttonHeight
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Row {
            id: barRow
            anchors.centerIn: parent
            width: parent.width - master.generalMargin
            height: parent.height - master.generalMargin
            spacing: master.generalMargin

            Button {
                id:         button1
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing*0.75
                iconSource: master.imagePath + master.iconTheme + "/remote.png"
                onClicked:  mainRect.state = "buttonPageState"
                iconRotation: master.screenRotation
            }

            Button {
                id:         button2
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing*0.75
                iconSource: master.imagePath + master.iconTheme + "/apps.png"
                onClicked:  mainRect.state = "actionsPageState"
                iconRotation: master.screenRotation
            }

            Button {
                id:         button3
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing*0.75
                iconSource: master.imagePath + master.iconTheme + "/mouse.png"
                onClicked:  mainRect.state = "touchpadPageState"
                iconRotation: master.screenRotation
            }

            Button {
                id:         button4
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing*0.75
                iconSource: master.imagePath + master.iconTheme + "/keyboard.png"
                onClicked:  mainRect.state = "keyboardPageState"
                iconRotation: master.screenRotation
            }
        }
    }
    states: [
        State {
            name: "buttonPageState"
            PropertyChanges { target: buttonPage; opacity: 1.0; z: 1}
            PropertyChanges { target: actionsPage; opacity: 0.0; z: 0}
            PropertyChanges { target: touchpadPage; opacity: 0.0; z: 0}
            PropertyChanges { target: keyboardPage; opacity: 0.0; z: 0}

        },
        State {
            name: "actionsPageState"
            PropertyChanges { target: buttonPage; opacity: 0.0; z: 0 }
            PropertyChanges { target: actionsPage; opacity: 1.0; z: 1 }
            PropertyChanges { target: touchpadPage; opacity: 0.0; z: 0 }
            PropertyChanges { target: keyboardPage; opacity: 0.0; z: 0 }
        },
        State {
            name: "touchpadPageState"
            PropertyChanges { target: buttonPage; opacity: 0.0; z: 0 }
            PropertyChanges { target: actionsPage; opacity: 0.0; z: 0 }
            PropertyChanges { target: touchpadPage; opacity: 1.0; z: 1 }
            PropertyChanges { target: keyboardPage; opacity: 0.0; z: 0 }
        },
        State {
            name: "keyboardPageState"
            PropertyChanges { target: buttonPage; opacity: 0.0; z: 0 }
            PropertyChanges { target: actionsPage; opacity: 0.0; z: 0 }
            PropertyChanges { target: touchpadPage; opacity: 0.0; z: 0 }
            PropertyChanges { target: keyboardPage; opacity: 1.0; z: 1 }
        }
    ]

     transitions: Transition {
        NumberAnimation { targets: [buttonPage, actionsPage, touchpadPage, keyboardPage]; properties: "opacity"; duration: 300}
     }

    function clearActions()
    {
        actionsPage.clearActions();
    }
}
