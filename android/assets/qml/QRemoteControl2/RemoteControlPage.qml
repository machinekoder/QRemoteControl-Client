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
        width: parent.width
        height: parent.height * 0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Row {
            id: barRow
            x: 5
            y: 5
            width: parent.width - 5
            height: parent.height-10
            spacing: 5

            Button {
                id:         button1
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing
                iconSource: master.imagePath + master.iconTheme + "/remote.png"
                onClicked:  mainRect.state = "buttonPageState"
            }

            Button {
                id:         button2
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing
                iconSource: master.imagePath + master.iconTheme + "/apps.png"
                onClicked:  mainRect.state = "actionsPageState"
            }

            Button {
                id:         button3
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing
                iconSource: master.imagePath + master.iconTheme + "/mouse.png"
                onClicked:  mainRect.state = "touchpadPageState"
            }

            Button {
                id:         button4
                height:     parent.height
                width:      (barRow.width) / 4 - barRow.spacing
                iconSource: master.imagePath + master.iconTheme + "/keyboard.png"
                onClicked:  mainRect.state = "keyboardPageState"
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
