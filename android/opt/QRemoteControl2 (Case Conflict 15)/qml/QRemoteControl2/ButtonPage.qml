// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    signal buttonPressed(int id)
    signal buttonReleased(int id)
    signal infoButtonClicked
    signal disconnectClicked

    property int iconMargin: 10

    id: main
    width: 400
    height: 600
    color: "#00000000"

    NavigationButton {
        id: navigationbutton1
        y: 141
        width: parent.width*0.5
        height: width
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        onOkPressed: buttonPressed(15)
        onOkReleased: buttonReleased(15)
        onRightPressed: buttonPressed(14)
        onRightReleased: buttonReleased(14)
        onLeftPressed: buttonPressed(13)
        onLeftReleased: buttonReleased(13)
        onUpPressed: buttonPressed(11)
        onUpReleased: buttonReleased(11)
        onDownPressed: buttonPressed(12)
        onDownReleased: buttonReleased(12)
    }

    Button {
        id: button0
        width: 50
        height: 50
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        iconMargin: main.iconMargin-2
        iconSource: "images/disconnect.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onClicked: disconnectClicked()
    }

    Button {
        id: button1
        width: 50
        height: 50
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        iconMargin: main.iconMargin
        iconSource: "images/power.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onPressed: buttonPressed(1)
        onReleased: buttonReleased(1)
    }

    Button {
        id: button3
        width: 50
        height: 50
        anchors.top: button0.bottom
        anchors.topMargin: 10
        anchors.left: button2.right
        anchors.leftMargin: 10
        iconMargin: main.iconMargin
        iconSource: "images/zoom_in.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onPressed: buttonPressed(3)
        onReleased: buttonReleased(3)
    }

    Button {
        id: button2
        width: 50
        height: 50
        anchors.top: button0.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        iconMargin: main.iconMargin
        iconSource: "images/zoom_out.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onPressed: buttonPressed(2)
        onReleased: buttonReleased(2)
    }

    Button {
        id: button6
        x: 216
        width: 50
        height: 50
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: button0.bottom
        anchors.topMargin: 10
        iconMargin: main.iconMargin
        iconSource: "images/volume_up.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onPressed: buttonPressed(6)
        onReleased: buttonReleased(6)
    }

    Button {
        id: button5
        x: 278
        width: 50
        height: 50
        anchors.top: button0.bottom
        anchors.topMargin: 10
        anchors.right: button6.left
        anchors.rightMargin: 10
        iconMargin: main.iconMargin+2
        iconSource: "images/volume_down.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onPressed: buttonPressed(5)
        onReleased: buttonReleased(5)
    }

    Button {
        id: button4
        x: 342
        width: 50
        height: 50
        anchors.top: button1.bottom
        anchors.topMargin: 10
        anchors.right: button5.left
        anchors.rightMargin: 10
        iconMargin: main.iconMargin
        iconSource: "images/volume_mute.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onPressed: buttonPressed(4)
        onReleased: buttonReleased(4)
    }

    Button {
        id: button8
        y: 147
        width: 50
        height: 50
        anchors.bottom: navigationbutton1.top
        anchors.bottomMargin: 10
        anchors.left: navigationbutton1.right
        anchors.leftMargin: 10
        iconMargin: main.iconMargin
        iconSource: "images/backspace.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onPressed: buttonPressed(8)
        onReleased: buttonReleased(8)
    }

    Button {
        id: button7
        x: 15
        y: 147
        width: 50
        height: 50
        anchors.bottom: navigationbutton1.top
        anchors.bottomMargin: 10
        anchors.right: navigationbutton1.left
        anchors.rightMargin: 10
        iconMargin: main.iconMargin
        iconSource: "images/exit.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onPressed: buttonPressed(7)
        onReleased: buttonReleased(7)
    }

    Button {
        id: button9
        x: 32
        width: 50
        height: 50
        anchors.right: navigationbutton1.left
        anchors.rightMargin: 10
        anchors.top: navigationbutton1.bottom
        anchors.topMargin: 10
        iconMargin: main.iconMargin
        iconSource: "images/switch_window.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onPressed: buttonPressed(9)
        onReleased: buttonReleased(9)
    }

    Button {
        id: button10
        width: 50
        height: 50
        anchors.left: navigationbutton1.right
        anchors.leftMargin: 10
        anchors.top: navigationbutton1.bottom
        anchors.topMargin: 10
        iconMargin: main.iconMargin-2
        iconSource: "images/menu.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onPressed: buttonPressed(10)
        onReleased: buttonReleased(10)
    }

    Row {
        id: row1
        x: 57
        y: 497
        width: button18.width + button16.width + button19.width + button17.width + spacing * 3
        height: 83
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        spacing: 10



        Button {
            id: button16
            width: 60
            height: 50
            radius: 15
            iconMargin: main.iconMargin
            anchors.verticalCenter: parent.verticalCenter
            iconSource: "images/seek_backward.png"
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            onPressed: buttonPressed(16)
            onReleased: buttonReleased(16)
        }

        Button {
            id: button18
            width: 100
            height: 70
            radius: 20
            iconMargin: main.iconMargin+5
            anchors.verticalCenter: parent.verticalCenter
            iconSource: "images/play_pause.png"
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            onPressed: buttonPressed(18)
            onReleased: buttonReleased(18)
        }
        Button {
            id: button19
            width: 60
            height: 50
            radius: 15
            anchors.verticalCenter: parent.verticalCenter
            iconMargin: main.iconMargin
            iconSource: "images/stop.png"
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            onPressed: buttonPressed(19)
            onReleased: buttonReleased(19)
        }
        Button {
            id: button17
            width: 60
            height: 50
            radius: 15
            iconMargin: main.iconMargin
            anchors.verticalCenter: parent.verticalCenter
            iconSource: "images/seek_forward.png"
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            onPressed: buttonPressed(17)
            onReleased: buttonReleased(17)
        }
    }
}
