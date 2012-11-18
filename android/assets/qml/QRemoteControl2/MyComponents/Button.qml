import QtQuick 1.1
import "gradients/"

Rectangle {
    property alias text:                text.text
    property alias textColor:           text.color
    property alias textRotation:        textWrapper.rotation
    property alias font:                text.font
    property alias icon:                image.source
    property bool checkable:            false
    property bool checked:              false
    property int iconMargin:            (width < height)?width/7:height/7
    property alias iconSource:          image.source
    property alias iconRotation:        image.rotation
    property bool round:                false
    property bool sound:                false
    property real radiusScaler:         theme.radiusScaler
    property Gradient defaultGradient:  theme.defaultGradient
    property Gradient pressedGradient:  theme.pressedGradient
    property Gradient hoveredGradient:  theme.hoveredGradient

    signal clicked
    signal doubleClicked
    signal pressed
    signal released

    id:             base
    width:          100
    height:         62
    radius:         round?width/2:(width < height)?width/radiusScaler:height/radiusScaler
    smooth:         true
    border.color:   theme.buttonBorderColor
    border.width:   theme.borderWidth
    gradient:       checked?pressedGradient:mouseArea.containsMouse?mouseArea.pressed?pressedGradient:hoveredGradient:defaultGradient

    onCheckableChanged: {
        if (!checkable)
            checked = false
    }

    Behavior on rotation {
                     NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                 }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        //hoverEnabled: true
        onClicked: {
            base.clicked()
            if (checkable)
                checked = !checked;
            if (sound)
                buttonSound()
        }
        onDoubleClicked: base.doubleClicked()
        onPressed: base.pressed()
        onReleased: base.released()
    }

    Item {
        id: textWrapper
        width:                      ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
        height:                     ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
        anchors.centerIn:           parent

        Text {
            id:                         text
            color:                      theme.primaryTextColor
            font.pixelSize:             theme.buttonFontSize
            font.bold:                  theme.buttonFontBold
            font.family:                theme.fontFamily
            wrapMode:                   Text.WordWrap
            verticalAlignment:          Text.AlignVCenter
            horizontalAlignment:        Text.AlignHCenter
            anchors.fill:               parent
            visible:                    !image.visible
        }

        Behavior on rotation {
                         NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                     }
    }

    Image {
        id:                     image
        smooth:                 true
        anchors.top:            parent.top
        anchors.topMargin:      iconMargin
        anchors.bottom:         parent.bottom
        anchors.bottomMargin:   iconMargin
        anchors.left:           parent.left
        anchors.leftMargin:     iconMargin
        anchors.right:          parent.right
        anchors.rightMargin:    iconMargin
        fillMode:               Image.PreserveAspectFit
        visible:                (image.source != "")
        enabled:                visible

        Behavior on rotation {
                         NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                     }
    }
}

