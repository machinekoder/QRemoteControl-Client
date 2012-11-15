// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtQuick 1.0
import MyComponents 1.0
import "colibri/"

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
                id: button1
                height: parent.height
                width: (barRow.width) / 4 - barRow.spacing
                iconMargin: 8
                iconSource: "images/remote.png"
                onClicked: mainRect.state = "buttonPageState"
                defaultGradient: master.defaultGradient
                pressedGradient: master.pressedGradient
                hoveredGradient: master.hoveredGradient
                border.color: master.border.color
            }

            Button {
                id: button2
                height: parent.height
                width: (barRow.width) / 4 - barRow.spacing
                anchors.verticalCenterOffset: 0
                iconSource: "images/apps.png"
                iconMargin: 8
                onClicked: mainRect.state = "actionsPageState"
                defaultGradient: master.defaultGradient
                pressedGradient: master.pressedGradient
                hoveredGradient: master.hoveredGradient
                border.color: master.border.color
            }

            Button {
                id: button3
                height: parent.height
                width: (barRow.width) / 4 - barRow.spacing
                anchors.verticalCenterOffset: 0
                iconSource: "images/mouse.png"
                iconMargin: 8
                onClicked: mainRect.state = "touchpadPageState"
                defaultGradient: master.defaultGradient
                pressedGradient: master.pressedGradient
                hoveredGradient: master.hoveredGradient
                border.color: master.border.color
            }

            Button {
                id: button4
                height: parent.height
                width: (barRow.width) / 4 - barRow.spacing
                anchors.verticalCenterOffset: 0
                iconSource: "images/keyboard.png"
                iconMargin: 8
                onClicked: mainRect.state = "keyboardPageState"
                defaultGradient: master.defaultGradient
                pressedGradient: master.pressedGradient
                hoveredGradient: master.hoveredGradient
                border.color: master.border.color
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
