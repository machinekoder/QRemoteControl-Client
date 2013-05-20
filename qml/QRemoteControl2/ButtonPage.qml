// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    signal buttonPressed(int id)
    signal buttonReleased(int id)
    signal infoButtonClicked
    signal disconnectClicked
    signal settingsClicked

    property int buttonMargin: master.generalMargin
    property int buttonwidth: master.buttonHeight
    property int buttonheight: master.buttonHeight

    id:     main
    width:  480
    height: 854
    color:  "#00000000"

    NavigationButton {
        id:             navigationbutton1
        width:          master.buttonHeight*3
        height:         width
        y:              (row1.y + button2.y+button2.height)/2 - height/2//parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
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
        rotation:       master.screenRotation
        animated:       (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button0
        width:              buttonwidth
        height:             buttonheight
        anchors.left:       parent.left
        anchors.leftMargin: master.generalMargin
        anchors.top:        parent.top
        anchors.topMargin:  master.generalMargin
        iconSource:         master.imagePath + master.iconTheme + "/settings.png"
        onClicked:          settingsClicked()
        rotation:            master.screenRotation
        animated:           (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button21
        width:              buttonwidth
        height:             buttonheight
        anchors.left:       button0.right
        anchors.leftMargin: master.generalMargin
        anchors.top:        parent.top
        anchors.topMargin:  master.generalMargin
        iconSource:         master.imagePath + master.iconTheme + "/disconnect.png"
        onClicked:          disconnectClicked()
        rotation:            master.screenRotation
        animated:           (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button20
        width:              buttonwidth
        height:             buttonheight
        anchors.top:        parent.top
        anchors.topMargin:  master.generalMargin
        anchors.right:      button1.left
        anchors.rightMargin:master.generalMargin
        iconSource:         master.imagePath + master.iconTheme + "/keyboard.png"
        onClicked:          keyboardPage.toggleNativeKeyboard()
        rotation:           master.screenRotation
        animated:           (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button1
        width:              buttonwidth
        height:             buttonheight
        anchors.top:        parent.top
        anchors.topMargin:  master.generalMargin
        anchors.right:      parent.right
        anchors.rightMargin:master.generalMargin
        iconSource:         master.imagePath + master.iconTheme + "/power.png"
        onPressed:          buttonPressed(1)
        onReleased:         buttonReleased(1)
        rotation:           master.screenRotation
        animated:           (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button3
        width:              buttonwidth
        height:             buttonheight
        anchors.top:        button0.bottom
        anchors.topMargin:  master.generalMargin
        anchors.left:       button2.right
        anchors.leftMargin: master.generalMargin
        iconSource:         master.imagePath + master.iconTheme + "/zoom_in.png"
        onPressed:          buttonPressed(3)
        onReleased:         buttonReleased(3)
        rotation:           master.screenRotation
        animated:           (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button2
        width:              buttonwidth
        height:             buttonheight
        anchors.top:        button0.bottom
        anchors.topMargin:  master.generalMargin
        anchors.left:       parent.left
        anchors.leftMargin: master.generalMargin
        iconSource:         master.imagePath + master.iconTheme + "/zoom_out.png"
        onPressed:          buttonPressed(2)
        onReleased:         buttonReleased(2)
        rotation:           master.screenRotation
        animated:           (mainRect.state == "buttonPageState")

    }

    Button {
        id:                 button6
        width:              buttonwidth
        height:             buttonheight
        anchors.right:      parent.right
        anchors.rightMargin:master.generalMargin
        anchors.top:        button0.bottom
        anchors.topMargin:  master.generalMargin
        iconSource:         master.imagePath + master.iconTheme + "/volume_up.png"
        onPressed:          buttonPressed(6)
        onReleased:         buttonReleased(6)
        rotation:           master.screenRotation
        animated:           (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button5
        width:              buttonwidth
        height:             buttonheight
        anchors.top:        button0.bottom
        anchors.topMargin:  master.generalMargin
        anchors.right:      button6.left
        anchors.rightMargin:master.generalMargin
        iconSource:         master.imagePath + master.iconTheme + "/volume_down.png"
        onPressed:          buttonPressed(5)
        onReleased:         buttonReleased(5)
        rotation:           master.screenRotation
        animated:           (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button4
        width:              buttonwidth
        height:             buttonheight
        anchors.top:        button1.bottom
        anchors.topMargin:  master.generalMargin
        anchors.right:      button5.left
        anchors.rightMargin:master.generalMargin
        iconSource:         master.imagePath + master.iconTheme + "/volume_mute.png"
        onPressed:          buttonPressed(4)
        onReleased:         buttonReleased(4)
        rotation:           master.screenRotation
        animated:          (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button8
        width:              buttonwidth
        height:             buttonheight
        anchors.bottom:     navigationbutton1.top
        anchors.bottomMargin: anchors.leftMargin
        anchors.left:       navigationbutton1.right
        anchors.leftMargin: -Math.round(master.width * 0.04)
        iconSource:         master.imagePath + master.iconTheme + "/backspace.png"
        onPressed:          buttonPressed(8)
        onReleased:         buttonReleased(8)
        rotation:           master.screenRotation
        animated:           (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button7
        width:              buttonwidth
        height:             buttonheight
        anchors.bottom:     navigationbutton1.top
        anchors.bottomMargin: anchors.rightMargin
        anchors.right:      navigationbutton1.left
        anchors.rightMargin: -Math.round(master.width * 0.04)
        iconSource:         master.imagePath + master.iconTheme + "/exit.png"
        onPressed:          buttonPressed(7)
        onReleased:         buttonReleased(7)
        rotation:           master.screenRotation
        animated:           (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button9
        width:              buttonwidth
        height:             buttonheight
        anchors.right:      navigationbutton1.left
        anchors.rightMargin: anchors.topMargin
        anchors.top:        navigationbutton1.bottom
        anchors.topMargin: -Math.round(master.width * 0.04)
        iconSource:         master.imagePath + master.iconTheme + "/switch_window.png"
        onPressed:          buttonPressed(9)
        onReleased:         buttonReleased(9)
        rotation:           master.screenRotation
        animated:           (mainRect.state == "buttonPageState")
    }

    Button {
        id:                 button10
        width:              buttonwidth
        height:             buttonheight
        anchors.left:       navigationbutton1.right
        anchors.leftMargin: anchors.topMargin
        anchors.top:        navigationbutton1.bottom
        anchors.topMargin: -Math.round(master.width * 0.04)
        iconSource:         master.imagePath + master.iconTheme + "/menu.png"
        onPressed:          buttonPressed(10)
        onReleased:         buttonReleased(10)
        rotation:           master.screenRotation
        animated:           (mainRect.state == "buttonPageState")
    }

    Row {
        id: row1
        width: button18.width + button16.width + button19.width + button17.width + spacing * 3
        height: button18.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: master.generalMargin
        spacing: master.generalMargin



        Button {
            id:                     button16
            width:                  buttonwidth*1.2
            height:                 buttonheight
            anchors.verticalCenter: parent.verticalCenter
            iconSource:             master.imagePath + master.iconTheme + "/seek_backward.png"
            onPressed:              buttonPressed(16)
            onReleased:             buttonReleased(16)
            rotation:               master.screenRotation
            animated:               (mainRect.state == "buttonPageState")
        }

        Button {
            id:                     button18
            width:                  buttonwidth*1.4
            height:                 buttonheight*1.3
            anchors.verticalCenter: parent.verticalCenter
            iconSource:             master.imagePath + master.iconTheme + "/play_pause.png"
            onPressed:              buttonPressed(18)
            onReleased:             buttonReleased(18)
            rotation: master.screenRotation
        }
        Button {
            id:                     button19
            width:                  buttonwidth*1.2
            height:                 buttonheight
            anchors.verticalCenter: parent.verticalCenter
            iconSource:             master.imagePath + master.iconTheme + "/stop.png"
            onPressed:              buttonPressed(19)
            onReleased:             buttonReleased(19)
            rotation:               master.screenRotation
            animated:               (mainRect.state == "buttonPageState")
        }
        Button {
            id:                     button17
            width:                  buttonwidth*1.2
            height:                 buttonheight
            anchors.verticalCenter: parent.verticalCenter
            iconSource:             master.imagePath + master.iconTheme + "/seek_forward.png"
            onPressed:              buttonPressed(17)
            onReleased:             buttonReleased(17)
            rotation:               master.screenRotation
            animated:               (mainRect.state == "buttonPageState")
        }
    }
}
