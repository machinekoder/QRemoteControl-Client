// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "gradients/"
Rectangle {
    property alias labelText: label.text
    property alias font: input.font
    property alias text: input.text
    property alias textColor: input.color
    property alias emptyText: emptyLabel.text
    property alias emptyTextColor: emptyLabel.color
    property bool labelEnabled: true
    property bool unedited: true
    property bool autodelete: true
    property alias echoMode: input.echoMode

    signal clicked

    id: main
    width: 200
    height: 40
    smooth: true

    radius: (width < height)?width/theme.radiusScaler:height/theme.radiusScaler
    border.width: theme.borderWidth
    border.color: theme.editBorderColor
    gradient: theme.editGradient

    Text {
        id: label
        text: "Test:"
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: theme.editFontSize
        font.bold:      theme.editFontBold
        font.family:    theme.fontFamily
        color: input.color
        visible: labelEnabled
        width: labelEnabled?parent.width*0.3:0
    }

    Rectangle {
        id: rect1
        height: parent.height
        color: "#00000000"
        width: parent.width - label.width - 20
        anchors.left: label.right
        anchors.leftMargin: 0


        TextInput {
            id:             input
            width:          parent.width -20
            text:           "Test"
            color:          theme.editTextColor
            font.pixelSize: theme.editFontSize
            font.bold:      theme.editFontBold
            font.family:    theme.fontFamily
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id:             emptyLabel
                elide:          Text.ElideRight
                font.pixelSize: theme.hintFontSize
                font.bold:      theme.hintFontBold
                font.family:    theme.fontFamily
                color:          theme.hintTextColor
                anchors.fill:   parent
                visible:        input.text == "" && !input.focus ? true : false
            }
            onActiveFocusChanged: {
                              if (!input.activeFocus)
                              {
                                  input.closeSoftwareInputPanel()
                                  master.releaseScreenOrientation()
                              }
                              else
                              {
                                  input.openSoftwareInputPanel()
                                  master.lockScreenOrientation()
                              }
                          }
            onAccepted: {
                input.closeSoftwareInputPanel()
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
