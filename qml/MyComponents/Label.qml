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
    property Style theme: master.theme

    id: main

    width: 200
    height: 40

    radius: (width < height)?width/theme.radiusScaler:height/theme.radiusScaler
    border.width: theme.borderWidth
    border.color: theme.labelBorderColor
    gradient: theme.labelGradient

    Text {
        id: label

        anchors.fill: parent
        anchors.margins: theme.paddingMedium
        color:          theme.secondaryColor
        font.pixelSize: theme.fontSizeSmall
        font.bold:      theme.labelFontBold
        font.family:    theme.fontFamily
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        text: "Test"
    }
}
