import QtQuick 2.0
import "MyComponents/"

Item {
    signal buttonPressed(int id)
    signal buttonReleased(int id)
    signal infoButtonClicked
    signal disconnectClicked
    signal settingsClicked

    property int buttonMargin: master.generalMargin
    property int buttonwidth: master.buttonHeight
    property int buttonheight: master.buttonHeight
    property bool buttonAnimated: (mainRect.state == "buttonPageState")
    property int buttonRotation: master.screenRotation

    id:     main
    width:  480
    height: 854

    ButtonPageItem {
       num: 17
       buttonWidth: 3
       buttonHeight: 3

       NavigationButton {
            id:             navigationbutton1
            anchors.fill:   parent
            onOkPressed:    buttonPressed(15)
            onOkReleased:   buttonReleased(15)
            onRightPressed: buttonPressed(14)
            onRightReleased:buttonReleased(14)
            onLeftPressed:  buttonPressed(13)
            onLeftReleased: buttonReleased(13)
            onUpPressed:    buttonPressed(11)
            onUpReleased:   buttonReleased(11)
            onDownPressed:  buttonPressed(12)
            onDownReleased: buttonReleased(12)
            rotation: buttonRotation
            animated:       buttonAnimated
        }
    }
    ButtonPageItem {
        num: 1
        iconName: "settings" 

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onClicked:          {
                settingsClicked()
                keyboardPage.closeNativeKeyboard()
            }
        }
    }
    ButtonPageItem {
        num: 2
        iconName: "disconnect"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onClicked:          disconnectClicked()
        }
    }
    ButtonPageItem {
        num: 4
        iconName: "keyboard"


        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onClicked:          keyboardPage.toggleNativeKeyboard()
        }
    }
    ButtonPageItem {
        num: 5
        buttonId: 1
        iconName: "power"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId)
        }
    }
    ButtonPageItem {
        num: 6
        buttonId: 3
        iconName: "zoom_in"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId)
        }
    }
    ButtonPageItem {
        num: 7
        buttonId: 2
        iconName: "zoom_out"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId)  
        }
    }
    ButtonPageItem {
        num: 8
        buttonId: 6
        iconName: "volume_up"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId) 
        }
    }
    ButtonPageItem {
        num: 9
        buttonId: 5
        iconName: "volume_down"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId)
        }
    }
    ButtonPageItem {
        num: 10
        buttonId: 4
        iconName: "volume_mute"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId)
        }
    }
    ButtonPageItem {
        num: 14
        buttonId: 8
        iconName: "backspace"


        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId)
        }
    }
    ButtonPageItem {
        num: 12
        buttonId: 7
        iconName: "exit"


        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId)
        }
    }
    ButtonPageItem {
        num: 32
        buttonId: 9
        iconName: "switch_window"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId)
        }
    }
    ButtonPageItem {
        num: 34
        buttonId: 10
        iconName: "menu"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId)
        }
    }
/*    ButtonPageItem {
        num: 16
        buttonId: 10
        iconName: "menu"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId)
        }
    }
    ButtonPageItem {
        num: 21
        buttonId: 10
        iconName: "menu"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId)
        }
    }
    ButtonPageItem {
        num: 26
        buttonId: 10
        iconName: "menu"

        Button {
            anchors.fill:       parent
            animated:           buttonAnimated
            rotation:           buttonRotation
            iconSource:         parent.iconSource
            onPressed:          buttonPressed(parent.buttonId)
            onReleased:         buttonReleased(parent.buttonId) 
        }
    }*/

    ButtonPageItem {
        num: 36
        buttonWidth: 5
        buttonHeight: 1

        MusicControl
        {
            anchors.fill: parent
            //rotation: buttonRotation
        }
    }
}
