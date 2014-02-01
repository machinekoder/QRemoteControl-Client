import QtQuick 2.0

Item {
    property int buttonWidth: 1
    property int buttonHeight: 1
    property int num: 0
    property int buttonId: 0
    property string iconName: ""
    property string iconSource: resolveImageUrl(iconName)

    width:              getButtonWidth(buttonWidth)
    height:             getButtonHeight(buttonHeight)
    x:                  getButtonX(num)
    y:                  getButtonY(num)

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
