// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "gradients/"

Rectangle {
    property alias font: label.font
    property alias text: label.text
    property alias textColor: label.color
    property alias wrapMode: label.wrapMode
    property alias verticalAlignment: label.verticalAlignment
    property alias horizontalAlignment: label.horizontalAlignment

    id: main

    width: 200
    height: 40
    smooth: true

    radius: (width < height)?width/theme.radiusScaler:height/theme.radiusScaler
    border.width: theme.borderWidth
    border.color: theme.labelBorderColor
    gradient: theme.labelGradient

    Text {
        id: label

        color:          theme.secondaryTextColor
        font.pixelSize: theme.labelFontSize
        font.bold:      theme.labelFontBold
        font.family:    theme.fontFamily

        anchors.fill: parent
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        text: "Test"
    }
}
