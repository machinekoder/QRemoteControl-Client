// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import MyComponents 1.0

Rectangle {
    id: rectangle1
    width: 400
    height:600
    color: "#00000000"

    Keyboard2 {
        id: keyboard
        width: parent.height-2
        height: parent.width-5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        rotation: 90
    }
}
