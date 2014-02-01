// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "gradients/"
Rectangle {
    property alias labelText: label.text
    property alias font: input.font
    property alias text: input.text
    property alias textColor: input.color
    property alias emptyText: emptyLabel.text
    property alias emptyTextColor: emptyLabel.color
    property alias inputActiveFocus: input.activeFocus
    property bool labelEnabled: true
    property bool unedited: true
    property bool autodelete: true
    property alias echoMode: input.echoMode
    property alias inputMethodHints: input.inputMethodHints
    property alias validator: input.validator
    property Style theme: master.theme

    signal clicked

    id: main
    width: 200
    height: 40

    radius: (width < height)?width/theme.radiusScaler:height/theme.radiusScaler
    border.width: theme.borderWidth
    border.color: theme.editBorderColor
    gradient: theme.editGradient

    Text {
        id: label
        text: "Test:"
        anchors.left: parent.left
        anchors.leftMargin: theme.paddingMedium
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: theme.fontSizeMedium
        font.bold:      theme.editFontBold
        font.family:    theme.fontFamily
        color: input.color
        visible: labelEnabled
        width: labelEnabled?parent.width*0.3:0
    }

    Item {
        id: rect1
        height: parent.height
        width: parent.width - label.width - parent.height * 0.3
        anchors.left: label.right

        TextInput {
            id:             input
            width:          parent.width - parent.height * 0.3
            text:           "Test"
            color:          activeFocus?theme.highlightColor:theme.primaryColor
            font.pixelSize: theme.fontSizeMedium
            font.bold:      theme.editFontBold
            font.family:    theme.fontFamily
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id:             emptyLabel
                elide:          Text.ElideRight
                font.pixelSize: theme.fontSizeSmall
                font.bold:      theme.hintFontBold
                font.family:    theme.fontFamily
                color:          theme.secondaryHighlightColor
                anchors.fill:   parent
                visible:        input.text == "" && !input.focus ? true : false
            }
            onActiveFocusChanged: {
                              if (!input.activeFocus)
                              {
                                  Qt.inputMethod.hide();
                                  master.releaseScreenOrientation()
                              }
                              else
                              {
                                  Qt.inputMethod.show()
                                  master.lockScreenOrientation()
                              }
                          }
            onAccepted: {
                Qt.inputMethod.hide()
                label.forceActiveFocus()                            // prevents keyboard from reopening
            }
        }
    }


    MouseArea {
        id: mouse_area1
        anchors.fill: parent
        onClicked: {
            main.clicked()
            input.focus = true
            if (input.text !== "")
            {
                unedited = false
            }

            if (unedited && autodelete)
            {
                input.text = ""
                unedited = false
            }
        }
    }

    function forceFocus()
    {
        input.focus = true
    }

    function toggleFocus()
    {
        if (input.focus)
        {
            label.forceActiveFocus()
        }
        else
        {
            input.focus = true
        }
    }
    function removeFocus()
    {
        label.forceActiveFocus()
    }
}
