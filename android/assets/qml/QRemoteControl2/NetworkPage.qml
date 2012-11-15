import QtQuick 1.1
import "MyComponents/"

Rectangle {
    id: main
    width: 360
    height: 640
    color: "#00000000"

    signal retryClicked

    Text {
        id: label
        text: qsTr("No wireless network connection found, connect to your wireless network and press \"Retry\".")
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        color: master.textColor1
        font.pixelSize: master.textSize2
    }

    Button {
            id: retryButton
            height: parent.height * 0.08
            text: qsTr("Retry")
            font.bold: true
            font.pixelSize: master.textSize2
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            icon: ""
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            textColor: master.textColor1
            onClicked: retryClicked()
        }
}
