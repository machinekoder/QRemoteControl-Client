import QtQuick 1.1
import "MyComponents/"

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
    //Rectangle {
    //    id: rect
    //    color: "white"
        //width: parent.width
        //height: 50

        TextInput {
            id: nativeTextInput
            anchors.fill: parent
            opacity: 0
            inputMethodHints: Qt.ImhNoPredictiveText
            text: " "

            onTextChanged: {
                if (text != " ")
                {
                    if ((text.charAt(text.length-1) == ' ') || (text.length == 2))
                    {
                        console.log("text")
                        client.sendText(text.substring(1, text.length));
                        text = " ";
                    }
                }
            }

            Keys.onPressed: {
                switch (event.key)
                {
                case Qt.Key_Enter:
                case Qt.Key_Return:
                //case Qt.Key_Delete:
                case Qt.Key_Backspace:
                case Qt.Key_Left:
                case Qt.Key_Right:
                case Qt.Key_Up:
                case Qt.Key_Down:
                //case Qt.Key_Space:
                    console.log("text")
                    client.sendText(text.substring(1, text.length));
                    text = " ";
                    client.sendKey(event.key, event.modifiers, true)
                    client.sendKey(event.key, event.modifiers, false)
                    event.accepted= true
                    break;
                default:
                    break;
                }
                console.log("press")
                console.log(event.key)
            }

            onActiveFocusChanged: {
                              if (!activeFocus)
                              {
                                  closeSoftwareInputPanel()
                              }
                              else
                              {
                                  openSoftwareInputPanel()
                              }
                          }
        }
    //}



    function click() {
            if (nativeTextInput.focus)
            {
                keyboardPageMain.forceActiveFocus()
            }
            else
            {
                nativeTextInput.forceActiveFocus()
            }

            console.log("input")
    }
}
