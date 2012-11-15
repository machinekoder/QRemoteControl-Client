// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    id: rectangle1
    signal mouseButtonPressed(int id)
    signal mouseButtonReleased(int id)
    //signal mouseMove(int deltaX, int deltaY)
    //signal horizontalScroll(int delta)
    //signal verticalScroll(int delta)
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

    Item {
        id:                     wrapper
        anchors.top:            buttonRow.bottom
        anchors.right:          parent.right
        anchors.bottom:         parent.bottom
        anchors.left:           parent.left
        anchors.rightMargin:    5
        anchors.leftMargin:     5
        anchors.bottomMargin:   5
        anchors.topMargin:      5
        TouchPad {
            id: touchpad

            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent

            onLeftButtonPressed: mouseButtonPressed(1)
            onLeftButtonReleased: mouseButtonReleased(1)
            onMiddleButtonPressed: mouseButtonPressed(2)
            onMiddleButtonReleased: mouseButtonReleased(2)
            onRightButtonPressed: mouseButtonPressed(3)
            onRightButtonReleased: mouseButtonReleased(3)
            //leftButtonCheckable: controlButton.checked || altButton.checked || shiftButton.checked
            //middleButtonCheckable: controlButton.checked || altButton.checked || shiftButton.checked
            //rightButtonCheckable: controlButton.checked || altButton.checked || shiftButton.checked

            Behavior on rotation {
                            NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on width {
                            NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                            NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                            }
        }
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
            text: qsTr("Ctrl")
            onClicked:controlClicked(!checked)
            checkable: true
            textRotation: master.screenRotation
        }

        Button {
            id: altButton
            width:  (parent.width - parent.spacing*2) / 3
            height: parent.height
            text: qsTr("Alt")
            onClicked: altClicked(!checked)
            checkable: true
            textRotation: master.screenRotation
        }

        Button {
            id: shiftButton
            width:  (parent.width - parent.spacing*2) / 3
            height: parent.height
            text: qsTr("Shift")
            onClicked: shiftClicked(!checked)
            checkable: true
            textRotation: master.screenRotation
        }
    }
}
