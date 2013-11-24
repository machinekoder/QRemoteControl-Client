import QtQuick 2.0
import "MyComponents/"

Rectangle {
    signal buttonPressed(int id)
    signal buttonReleased(int id)
    signal infoButtonClicked
    signal disconnectClicked
    signal settingsClicked

    property int buttonMargin: master.generalMargin
    property int buttonwidth: master.buttonHeight
    property int buttonheight: master.buttonHeight
    property bool buttonAnimated: (mainRect.state == "buttonPageState")
    property bool buttonRotation: master.screenRotation

    id:     main
    width:  480
    height: 854
    color:  "#00000000"

    NavigationButton {
        id:             navigationbutton1
        width:          getButtonWidth(3)
        height:         getButtonHeight(3)
        x:              getButtonX(17)
        y:              getButtonY(17)
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
        rotation:       buttonRotation
        animated:       buttonAnimated
    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("settings")
        x:                  getButtonX(1)
        y:                  getButtonY(1)
        onClicked:          {
            settingsClicked()
            keyboardPage.closeNativeKeyboard()
        }
        rotation:           buttonRotation
        animated:           buttonAnimated
    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("disconnect")
        x:                  getButtonX(2)
        y:                  getButtonY(2)
        onClicked:          disconnectClicked()
        rotation:           buttonRotation
        animated:           buttonAnimated
    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("keyboard")
        x:                  getButtonX(4)
        y:                  getButtonY(4)
        onClicked:          keyboardPage.toggleNativeKeyboard()
        rotation:           buttonRotation
        animated:           buttonAnimated
    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("power")
        x:                  getButtonX(5)
        y:                  getButtonY(5)
        onPressed:          buttonPressed(1)
        onReleased:         buttonReleased(1)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("zoom_in")
        x:                  getButtonX(6)
        y:                  getButtonY(6)
        onPressed:          buttonPressed(3)
        onReleased:         buttonReleased(3)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("zoom_out")
        x:                  getButtonX(7)
        y:                  getButtonY(7)
        onPressed:          buttonPressed(2)
        onReleased:         buttonReleased(2)
        rotation:           buttonRotation
        animated:           buttonAnimated

    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("volume_up")
        x:                  getButtonX(8)
        y:                  getButtonY(8)
        onPressed:          buttonPressed(6)
        onReleased:         buttonReleased(6)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("volume_down")
        x:                  getButtonX(9)
        y:                  getButtonY(9)
        onPressed:          buttonPressed(5)
        onReleased:         buttonReleased(5)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("volume_mute")
        x:                  getButtonX(10)
        y:                  getButtonY(10)
        onPressed:          buttonPressed(4)
        onReleased:         buttonReleased(4)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("backspace")
        x:                  getButtonX(14)
        y:                  getButtonY(14)
        onPressed:          buttonPressed(8)
        onReleased:         buttonReleased(8)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }
    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("exit")
        x:                  getButtonX(12)
        y:                  getButtonY(12)
        onPressed:          buttonPressed(7)
        onReleased:         buttonReleased(7)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }
    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("switch_window")
        x:                  getButtonX(32)
        y:                  getButtonY(32)
        onPressed:          buttonPressed(9)
        onReleased:         buttonReleased(9)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }
    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("menu")
        x:                  getButtonX(34)
        y:                  getButtonY(34)
        onPressed:          buttonPressed(10)
        onReleased:         buttonReleased(10)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("menu")
        x:                  getButtonX(16)
        y:                  getButtonY(16)
        onPressed:          buttonPressed(10)
        onReleased:         buttonReleased(10)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }

    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("menu")
        x:                  getButtonX(21)
        y:                  getButtonY(21)
        onPressed:          buttonPressed(10)
        onReleased:         buttonReleased(10)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }
    Button {
        width:              getButtonWidth(1)
        height:             getButtonHeight(1)
        iconSource:         resolveImageUrl("menu")
        x:                  getButtonX(26)
        y:                  getButtonY(26)
        onPressed:          buttonPressed(10)
        onReleased:         buttonReleased(10)
        rotation:           buttonRotation
        animated:           buttonAnimated
    }

    MusicControl
    {
        width:              getButtonWidth(5)
        height:             getButtonHeight(1)
        x:                  getButtonX(36)
        y:                  getButtonY(36)
    }

    function resolveImageUrl(name)
    {
        return master.imagePath + master.iconTheme + "/" + name + ".png"
    }

    function getButtonX(buttonNumber)
    {
        var addition = 0
        buttonNumber = ((buttonNumber-1) % 5)+1

        if (buttonNumber >= 3)
        {
            addition = master.buttonMinimumAspectDifference
        }

        return master.generalMargin*buttonNumber + master.buttonHeight*(buttonNumber-1) + addition
    }

    function getButtonY(buttonNumber)
    {
        buttonNumber = Math.floor((buttonNumber-1) / 5) + 1

        return buttonNumber * master.generalMargin + master.buttonHeight * (buttonNumber-1)
    }

    function getButtonWidth(count)
    {
        var addition = 0
        if (count >= 3)
        {
            addition = master.buttonMinimumAspectDifference
        }

        return master.buttonHeight * count + master.generalMargin * (count-1) + addition
    }

    function getButtonHeight(count)
    {
        return master.buttonHeight * count + master.generalMargin * (count-1)
    }
}
