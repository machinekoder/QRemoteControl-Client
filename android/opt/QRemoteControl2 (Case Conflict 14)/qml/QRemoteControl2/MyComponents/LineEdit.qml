// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "gradients/"
Rectangle {
    property alias labelText: label.text
    property alias font: input.font
    property alias text: input.text
    property alias textColor: input.color
    property bool labelEnabled: true
    property bool unedited: true
    property bool autodelete: true
    property alias echoMode: input.echoMode

    signal clicked

    id: main
    width: 200
    height: 40
    color: "#00000000"
    smooth: true
    radius: 11
    border.width: 2
    gradient: defaultGradient

    Text {
        id: label
        text: "Test:"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        font: input.font
        color: input.color
        visible: labelEnabled
        width: labelEnabled?parent.width*0.3:0
    }

    Rectangle {
        id: rect1
        height: parent.height
        color: "#00000000"
        width: parent.width - label.width - 20
        anchors.left: label.right
        anchors.leftMargin: 0

        PressedGradient {
                id: defaultGradient
            }

            TextInput {
                id: input
                width: parent.width -20
                text: "Default"
                color: "black"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
    }


    MouseArea {
        id: mouse_area1
        anchors.fill: parent
        onClicked: {
            main.clicked()
            input.focus = true
            if (unedited && autodelete)
            {
                input.text = ""
                unedited = false
            }
        }
    }
}
