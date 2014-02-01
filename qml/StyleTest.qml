import QtQuick 2.0
import "styles" as Styles

Item {
    id: rectangle6
    width: 480
    height: 800
    z: 2147483646

    Styles.Tech {
        id: techStyle
        fontFamily: "Arial"
        hintTextColor: "#81D4FF"
        secondaryTextColor: "#81d4ff"
        primaryTextColor: "#81d4ff"
        editTextColor: "#596b7f"
        editBorderColor: "#596b7f"
        buttonBorderColor: "#596b7f"
    }

    Rectangle {
        id: rectangle1
        x: 45
        y: 73
        width: 168
        height: 97
        z: 1
        gradient: techStyle.defaultGradient
        border.color: techStyle.buttonBorderColor

        Text {
            id: text1
            x: 72
            y: 42
            text: qsTr("Primary Text") + client.emptyString
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: techStyle.buttonFontSize
            font.bold: techStyle.buttonFontBold
            color: techStyle.primaryTextColor
        }
    }

    Rectangle {
        id: rectangle2
        x: 261
        y: 73
        width: 168
        height: 97
        z: 1
        border.color: techStyle.buttonBorderColor
        gradient: techStyle.hoveredGradient

        Text {
            id: text2
            x: 72
            y: 42
            text: qsTr("Secondary Text") + client.emptyString
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: techStyle.labelFontSize
            color: techStyle.secondaryTextColor
            font.bold: techStyle.labelFontBold
        }
    }

    Rectangle {
        id: rectangle3
        x: 45
        y: 192
        width: 168
        height: 97
        z: 1
        border.color: techStyle.editBorderColor
        gradient: techStyle.pressedGradient

        Text {
            id: text3
            x: 72
            y: 42
            text: qsTr("Edit Text") + client.emptyString
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: techStyle.editFontSize
            color: techStyle.editTextColor
            font.bold: techStyle.editFontBold
        }
    }

    Rectangle {
        id: rectangle4
        x: 261
        y: 192
        width: 168
        height: 97
        z: 1
        border.color: techStyle.labelBorderColor
        gradient: techStyle.editGradient
        Text {
            id: text4
            x: 72
            y: 42
            text: qsTr("Hint Text") + client.emptyString
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: techStyle.hintFontSize
            color: techStyle.hintTextColor
            font.bold: techStyle.hintFontBold
        }
    }

    Rectangle {
        id: rectangle5
        y: 322
        height: 70
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        z: 1
        border.color: techStyle.buttonBorderColor
        gradient: techStyle.extraGradient
    }

    Image {
        id: image1
        sourceSize.height: 40
        sourceSize.width: 40
        fillMode: Image.Tile
        z: 0
        anchors.fill: parent
        source: ""
    }


}
