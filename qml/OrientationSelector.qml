import QtQuick 2.0
import "MyComponents"

Item {
    id: orientationLockButtons
    width:                       master.buttonHeight * 0.9 * 5 + 4 * master.generalMargin
    height:                      master.buttonHeight*0.9

    function setScreenOrientation(screenOrientation)
    {
        noLockButton.checked = false
        portraitLockButton.checked = false
        reversePortraitLockButton.checked = false
        landscapeLockButton.checked = false
        reverseLandcapeLockButton.checked = false

        switch (screenOrientation)
        {
            case 0: noLockButton.checked = true
                break
            case 1: portraitLockButton.checked = true
                master.screenRotation = 0
                break
            case 2: reversePortraitLockButton.checked = true
                master.screenRotation = 180
                break
            case 3: landscapeLockButton.checked = true
                master.screenRotation = 90
                break
            case 4: reverseLandcapeLockButton.checked = true
                master.screenRotation = -90
                break
        }

        if (!device.landscapeMode)
             master.screenRotation += 90
    }

    Button {
        id:              noLockButton
        checkable:       true
        width:           master.buttonHeight * 0.9
        height:          width
        text:            ""
        icon:            master.imagePath + master.iconTheme + "/exit.png"
        anchors.top:     parent.top
        anchors.left:    parent.left
        onClicked: {
            if (!checked)
            {
                portraitLockButton.checked = false
                reversePortraitLockButton.checked = false
                landscapeLockButton.checked = false
                reverseLandcapeLockButton.checked = false

                client.screenOrientation = 0
            }
            else
                checked = false
        }
     }

     Button {
        id:                  portraitLockButton
        checkable:           true
        width:               master.buttonHeight * 0.9
        height:              width
        text:                ""
        icon:                master.imagePath + master.iconTheme + "/up.png"
        anchors.top:         parent.top
        anchors.left:        noLockButton.right
        anchors.leftMargin:  master.generalMargin
        onClicked: {
            if (!checked)
            {
                noLockButton.checked = false
                reversePortraitLockButton.checked = false
                landscapeLockButton.checked = false
                reverseLandcapeLockButton.checked = false

                client.screenOrientation = 1
                master.screenRotation = 0
                if (!device.landscapeMode)
                     master.screenRotation += 90
            }
            else
                checked = false
        }
     }

     Button {
        id:                  reversePortraitLockButton
        checkable:           true
        width:               master.buttonHeight * 0.9
        height:              width
        text:                ""
        icon:                master.imagePath + master.iconTheme + "/down.png"
        anchors.top:         parent.top
        anchors.left:        portraitLockButton.right
        anchors.leftMargin:  master.generalMargin
        onClicked: {
            if (!checked)
            {
                portraitLockButton.checked = false
                noLockButton.checked = false
                landscapeLockButton.checked = false
                reverseLandcapeLockButton.checked = false

                client.screenOrientation = 2
                master.screenRotation = 180
                if (!device.landscapeMode)
                     master.screenRotation += 90
            }
            else
                checked = false
        }
     }

     Button {
        id:                  landscapeLockButton
        checkable:           true
        width:               master.buttonHeight * 0.9
        height:              width
        text:                ""
        icon:                master.imagePath + master.iconTheme + "/right.png"
        anchors.top:         parent.top
        anchors.left:        reversePortraitLockButton.right
        anchors.leftMargin:  master.generalMargin
        onClicked: {
            if (!checked)
            {
                portraitLockButton.checked = false
                reversePortraitLockButton.checked = false
                noLockButton.checked = false
                reverseLandcapeLockButton.checked = false

                client.screenOrientation = 3
                master.screenRotation = 90
                if (!device.landscapeMode)
                     master.screenRotation += 90
            }
            else
                checked = false
        }
     }

     Button {
        id:                  reverseLandcapeLockButton
        checkable:           true
        width:               master.buttonHeight * 0.9
        height:              width
        text:                ""
        icon:                master.imagePath + master.iconTheme + "/left.png"
        anchors.top:         parent.top
        anchors.left:        landscapeLockButton.right
        anchors.leftMargin:  master.generalMargin
        onClicked: {
            if (!checked)
            {
                portraitLockButton.checked = false
                reversePortraitLockButton.checked = false
                landscapeLockButton.checked = false
                noLockButton.checked = false

                client.screenOrientation = 4
                master.screenRotation = -90
                if (!device.landscapeMode)
                     master.screenRotation += 90
            }
            else
                checked = false
        }
     }
}

