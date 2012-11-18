// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    id: keyboardPageMain
    width: 400
    height:600
    color: "#00000000"

    Keyboard {
        id: keyboard
        width: parent.height-2
        height: parent.width-5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        rotation: 90
    }
    /*TextInput {
        id: textInput
        opacity: 1
        Keys.onPressed: {
             client.sendKey(event.key,event.modifiers,true)
            event.accepted= true
            console.log(event.key)
        }
        Keys.onReleased: {
             client.sendKey(event.key,event.modifiers,false)
            event.accepted= true
        }
        inputMethodHints: Qt.ImhNoPredictiveText
    }

    function click() {
            textInput.focus = true;
            textInput.openSoftwareInputPanel()
            console.log("input")
    }*/
}
