// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    id: rectangle1
    signal mouseButtonPressed(int id)
    signal mouseButtonReleased(int id)
    signal mouseMove(int deltaX, int deltaY)
    signal horizontalScroll(int delta)
    signal verticalScroll(int delta)
    signal shiftClicked(bool down)
    signal altClicked(bool down)
    signal controlClicked(bool down)


    width: 400
    height: 600
    color: "#00000000"

    Component.onCompleted: {
        touchpad.mouseMove.connect(client.sendMouseMove)
        touchpad.horizontalScroll.connect(client.sendHorizontalScroll)
        touchpad.verticalScroll.connect(client.sendVerticalScroll)
        controlClicked.connect(client.sendControlClicked)
        altClicked.connect(client.sendAltClicked)
        shiftClicked.connect(client.sendShiftClicked)
        mouseButtonPressed.connect(client.sendMousePress)
        mouseButtonReleased.connect(client.sendMouseRelease)
    }

    TouchPad {
        id: touchpad
        anchors.top: buttonRow.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        onLeftButtonPressed: mouseButtonPressed(1)
        onLeftButtonReleased: mouseButtonReleased(1)
        onMiddleButtonPressed: mouseButtonPressed(2)
        onMiddleButtonReleased: mouseButtonReleased(2)
        onRightButtonPressed: mouseButtonPressed(3)
        onRightButtonReleased: mouseButtonReleased(3)
        leftButtonCheckable: controlButton.checked || altButton.checked || shiftButton.checked
        middleButtonCheckable: controlButton.checked || altButton.checked || shiftButton.checked
        rightButtonCheckable: controlButton.checked || altButton.checked || shiftButton.checked
    }

    Row {
        id: buttonRow
        width: parent.width-10
        height: parent.height*0.1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 5
        spacing: 7

        Button {
            id: controlButton
            width:  (parent.width - parent.spacing*2) / 3
            height: parent.height
            text: "Ctrl"
            onClicked:controlClicked(!checked)
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            checkable: true
            font.bold: true
            font.pixelSize: master.textSize2
            textColor: master.textColor1
        }

        Button {
            id: altButton
            width:  (parent.width - parent.spacing*2) / 3
            height: parent.height
            text: "Alt"
            onClicked: altClicked(!checked)
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            checkable: true
            font.bold: true
            font.pixelSize: master.textSize2
            textColor: master.textColor1
        }

        Button {
            id: shiftButton
            width:  (parent.width - parent.spacing*2) / 3
            height: parent.height
            text: "Shift"
            onClicked: shiftClicked(!checked)
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            checkable: true
            font.bold: true
            font.pixelSize: master.textSize2
            textColor: master.textColor1
        }
    }
}
