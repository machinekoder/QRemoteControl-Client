import QtQuick 1.1
import "gradients/"

Rectangle {
    property alias text: text.text
    property alias textColor: text.color
    property alias font: text.font
    property alias icon: image.source
    property bool checkable: false
    property bool checked: false
    property int iconMargin: 10
    property alias iconSource: image.source
    property bool round: false
    property bool sound: false
    property Gradient defaultGradient: DefaultGradient {}
    property Gradient pressedGradient: PressedGradient {}
    property Gradient hoveredGradient: HoveredGradient {}
    signal clicked
    signal pressed
    signal released

    id: base
    width: 100
    height: 62
    radius: round?width/2:11
    smooth: true
    border.width: 2
    border.color: "green"
    gradient: checked?hoveredGradient:mouseArea.containsMouse?mouseArea.pressed?pressedGradient:hoveredGradient:defaultGradient

    onCheckableChanged: {
        if (!checkable)
            checked = false
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
        onPressed: base.pressed()
        onReleased: base.released()
    }

    Text {
        id: text
        color: "black"
        wrapMode: Text.WordWrap
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.fill: parent
        visible: !image.visible
    }

    Image {
        id: image
        smooth: true
        anchors.top: parent.top
        anchors.topMargin: iconMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: iconMargin
        anchors.left: parent.left
        anchors.leftMargin: iconMargin
        anchors.right: parent.right
        anchors.rightMargin: iconMargin
        fillMode: Image.PreserveAspectFit
        visible: (image.source != "")
        enabled: visible
    }
}

