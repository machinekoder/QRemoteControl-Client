// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "gradients/"

Rectangle {
    property alias font: label.font
    property alias text: label.text
    property alias textColor: label.color
    property alias wrapMode: label.wrapMode
    property alias verticalAlignment: label.verticalAlignment
    property alias horizontalAlignment: label.horizontalAlignment

    id: main
    width: 200
    height: 40
    smooth: true
    radius: 11
    border.width: 2
    gradient: defaultGradient

    Text {
        id: label
        text: "Test"
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
    }
    PressedGradient {
            id: defaultGradient
        }
}
