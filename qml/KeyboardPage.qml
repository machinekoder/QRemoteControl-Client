import QtQuick 2.0
import "MyComponents/"

Item {
    property bool nativeKeyboardActivated: nativeTextInput.focus
    property bool autoOrientation: (remotecontrolPage.state == "keyboardPageState") && nativeKeyboardActivated
    property int orientationLock: 0

    id: keyboardPageMain
    width: 400
    height:600

    onAutoOrientationChanged: {
        if (autoOrientation)
        {
            appWindow.orientationLock = orientationLock
        }
        else
        {
            appWindow.orientationLock = 0
        }
    }

    onOrientationLockChanged: {
        if (autoOrientation)
        {
            appWindow.orientationLock = orientationLock
        }
    }

    Keyboard {
        id: keyboard
        width: parent.height - master.generalMargin
        height: parent.width - master.generalMargin
        anchors.centerIn: parent
        rotation: 90
        visible: !nativeKeyboardActivated
    }

    Item {
        id:                     wrapper
        anchors.top:            parent.top
        anchors.right:          parent.right
        anchors.bottom:         parent.bottom
        anchors.left:           parent.left
        anchors.rightMargin:    master.generalMargin
        anchors.leftMargin:     master.generalMargin
        anchors.bottomMargin:   master.generalMargin
        anchors.topMargin:      master.generalMargin
        visible: nativeKeyboardActivated

        Button {
            id:                 keyboardButton
            width:              master.buttonHeight
            height:             master.buttonHeight
            anchors.right:      parent.right
            anchors.leftMargin: master.generalMargin
            anchors.bottom:     portraitButton.top
            anchors.bottomMargin:  master.generalMargin
            iconSource:         master.imagePath + master.iconTheme + "/keyboard.png"
            onClicked:          toggleNativeKeyboard()
            rotation:           appWindow.orientationLock === 1 ? master.screenRotation - 90 : master.screenRotation
            animated:           (remotecontrolPage.state == "keyboardPageState")
        }

        Button {
            id:                 portraitButton
            width:              master.buttonHeight
            height:             master.buttonHeight
            anchors.right:      parent.right
            anchors.leftMargin: master.generalMargin
            anchors.verticalCenter: parent.verticalCenter
            iconSource:         master.imagePath + master.iconTheme + "/up.png"
            onClicked:          {
                landscapeButton.checked = false;
                orientationLock = 0
            }
            rotation:           appWindow.orientationLock === 1 ? master.screenRotation - 90 : master.screenRotation
            animated:           (remotecontrolPage.state == "keyboardPageState")
            checkable:          true
            checked:            true
        }

        Button {
            id:                 landscapeButton
            width:              master.buttonHeight
            height:             master.buttonHeight
            anchors.right:      parent.right
            anchors.leftMargin: master.generalMargin
            anchors.top:        portraitButton.bottom
            anchors.topMargin:  master.generalMargin
            iconSource:         master.imagePath + master.iconTheme + "/right.png"
            onClicked:          {
                portraitButton.checked = false;
                orientationLock = 1
            }
            rotation:           appWindow.orientationLock === 1 ? master.screenRotation - 90 : master.screenRotation
            animated:           (remotecontrolPage.state == "keyboardPageState")
            checkable:          true
        }
    }

    TextInput {
        id: nativeTextInput
        opacity: 0
        inputMethodHints: Qt.ImhNoPredictiveText | Qt.ImhNoAutoUppercase
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
                              //closeSoftwareInputPanel()
                              Qt.inputMethod.hide()
                          }
                          else
                          {
                              //openSoftwareInputPanel()
                              Qt.inputMethod.show()
                          }
                      }
    }

    function toggleNativeKeyboard() {
        if (nativeTextInput.focus)
        {
            keyboardPageMain.forceActiveFocus()
            master.releaseScreenOrientation()
            console.log("deactivate keyboard")
        }
        else
        {
            nativeTextInput.forceActiveFocus()
            master.lockScreenOrientation()
             console.log("activate keyboard")
        }
    }

    function closeNativeKeyboard() {
        if (nativeTextInput.focus)
        {
            toggleNativeKeyboard()
        }
    }
}
