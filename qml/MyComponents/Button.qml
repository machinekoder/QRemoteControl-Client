import QtQuick 2.0
import QtGraphicalEffects 1.0
import "gradients/"
import "feedback.js" as Feedback
//import "coloroverlay.js" as ColorOverlay

Rectangle {
    property alias text:                text.text
    property color textColor:           theme.primaryColor
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
    property bool animated:             true

    property bool feedbackAvailable: false

    property Style theme: master.theme
    property string platform: master.platform

    signal clicked
    signal doubleClicked
    signal pressed
    signal released

    id:             base
    width:          100
    height:         62
    radius:         round?width/2:(width < height)?width/radiusScaler:height/radiusScaler
    border.color:   theme.buttonBorderColor
    border.width:   theme.borderWidth
    gradient:       checked?pressedGradient:mouseArea.containsMouse?mouseArea.pressed?pressedGradient:hoveredGradient:defaultGradient

    onCheckableChanged: {
        if (!checkable)
            checked = false
    }

    Behavior on rotation {
                     NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                     enabled: animated
                 }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: {
            base.pressed()
            base.clicked()
            if (checkable)
                checked = !checked;
            if (sound)
                buttonSound();
            if (feedbackAvailable)
                Feedback.playHaptic();
        }
        onReleased: {
            base.released()
            if (feedbackAvailable)
                Feedback.playHaptic();
        }
    }

    Item {
        id: textWrapper
        width:                      ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
        height:                     ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
        anchors.centerIn:           parent

        Text {
            id:                         text
            elide:                      Text.ElideRight
            color:                      (checked || mouseArea.containsMouse)?theme.highlightColor:textColor
            font.pixelSize:             theme.fontSizeMedium
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
                         enabled: animated
                     }
    }

    Image {
        id:                     image

        anchors.fill:           parent
        anchors.topMargin:      iconMargin
        anchors.bottomMargin:   iconMargin
        anchors.leftMargin:     iconMargin
        anchors.rightMargin:    iconMargin
        fillMode:               Image.PreserveAspectFit
        visible:                (image.source != "") && !overlay.visible
        enabled:                visible

        Behavior on rotation {
                         NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         enabled: animated
                     }
    }

    ColorOverlay {
        id: overlay
        anchors.fill: image
        source: image
        color: theme.highlightColor
        visible: (checked || (mouseArea.containsMouse && mouseArea.pressed))
    }

    Component.onCompleted: {
        if ((platform === "MeeGo")
                || (platform === "Symbian")
                //|| (platform.platform === "Android")
                )
        {
            Feedback.createHaptic()
            //ColorOverlay.createColorOverlay()
            feedbackAvailable = true
        }
    }

    function playHaptic()
    {
        if (feedbackAvailable)
            Feedback.playHaptic()
    }

    function click()
    {
        if (checkable)
            checked = !checked;
        base.clicked()
    }
}

