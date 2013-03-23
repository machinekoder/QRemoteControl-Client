// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    signal buttonPressed(int id)
    signal buttonReleased(int id)
    signal disconnectClicked
    signal aboutClicked

    id: mainRect
    width: 380
    height: 640
    color: "#00000000"
    state: "buttonPageState"

    Component.onCompleted: {
        buttonPage.buttonPressed.connect(buttonPressed)
        buttonPage.buttonReleased.connect(buttonReleased)
        buttonPage.disconnectClicked.connect(disconnectClicked)
    }

    Row {
        id: centerContainer

        ButtonPage {
            id: buttonPage
            width: mainRect.width
            height: mainRect.height - buttonbar.height
            onInfoButtonClicked: aboutClicked()
        }
        ActionsPage {
            id: actionsPage
            width: mainRect.width
            height: mainRect.height - buttonbar.height
        }
        TouchPadPage {
            id: touchpadPage
            width: mainRect.width
            height: mainRect.height - buttonbar.height
        }
        KeyboardPage {
            id: keyboardPage
            width: mainRect.width
            height: mainRect.height - buttonbar.height
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
            spacing: master.generalMargin/2

            Button {
                id:         button1
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing
                iconSource: master.imagePath + master.iconTheme + "/remote.png"
                onClicked:  mainRect.state = "buttonPageState"
                iconRotation: master.screenRotation
            }

            Button {
                id:         button2
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing
                iconSource: master.imagePath + master.iconTheme + "/apps.png"
                onClicked:  mainRect.state = "actionsPageState"
                iconRotation: master.screenRotation
            }

            Button {
                id:         button3
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing
                iconSource: master.imagePath + master.iconTheme + "/mouse.png"
                onClicked:  mainRect.state = "touchpadPageState"
                iconRotation: master.screenRotation
            }

            Button {
                id:         button4
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing
                iconSource: master.imagePath + master.iconTheme + "/keyboard.png"
                onClicked:  mainRect.state = "keyboardPageState"
                iconRotation: master.screenRotation
            }
        }
    }
    states: [
        State {
            name: "buttonPageState"

            PropertyChanges {
                target: centerContainer
                x: mainRect.width * 0
            }

        },
        State {
            name: "actionsPageState"
            PropertyChanges {
                target: centerContainer
                x: -mainRect.width * 1
            }
        },
        State {
            name: "touchpadPageState"
            PropertyChanges {
                target: centerContainer
                x: -mainRect.width * 2
            }
        },
        State {
            name: "keyboardPageState"
            PropertyChanges {
                target: centerContainer
                x: -mainRect.width * 3
            }
        }
    ]

    transitions: Transition {
             PropertyAnimation { target: centerContainer; properties: "x"; easing.type: Easing.OutCubic; duration: 400 }
         }
}
