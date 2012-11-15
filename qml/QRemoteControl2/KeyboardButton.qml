// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Button {
    property bool shifted: keyboardMain.shiftChecked
    property string normalText: ""
    property string shiftedText: ""
    property bool topRow: false
    property int key: 0

    id:                 keyboardButton
    width:              100
    height:             62
    border.width:       1
    text:               shifted?shiftedText:normalText
    font.pixelSize:     keyboardMain.textSize
    onPressed:  {
        client.sendKey(key,keyboardMain.modifierState(),true)
        preview.visible = true
    }
    onReleased: {
        client.sendKey(key,keyboardMain.modifierState(),false)
        preview.visible = false
    }

    Rectangle {
        id: preview
        width: parent.width*1.2
        height: parent.height*1.2
        radius: 11
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: topRow?undefined:keyboardButton.top
        anchors.top: topRow?keyboardButton.bottom:undefined
        gradient: theme.pressedGradient
        border.width: 1
        border.color: theme.buttonBorderColor
        visible: false

        Text {
            id: previewText
            text: keyboardButton.text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: keyboardButton.font.pixelSize+4
            font.bold: true
        }
    }
}
