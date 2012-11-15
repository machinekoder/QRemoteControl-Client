// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    property alias password: passwordEdit.text
    property alias hostname: hostNameEdit.text
    property alias port: portSpin.value

    signal helpClicked
    signal infoClicked
    signal settingsClicked
    signal connectClicked
    signal broadcastClicked

    id: main
    width: 360
    height: 640
    color: "#00000000"
    Button {
        id: helpButton
        width: parent.width * 0.15
        height: width
        text: ""
        icon: "images/help.png"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        textColor: master.textColor1
        onClicked: helpClicked()
    }
    Button {
        id: infoButton
        width: parent.width * 0.15
        height: width
        anchors.left: helpButton.right
        anchors.leftMargin: 10
        border.color: master.border.color
        textColor: master.textColor1
        defaultGradient: master.defaultGradient
        anchors.top: parent.top
        hoveredGradient: master.hoveredGradient
        pressedGradient: master.pressedGradient
        iconSource: "images/info.png"
        anchors.topMargin: 10
        onClicked: infoClicked()
    }
    Button {
        id: settingsButton
        width: parent.width * 0.15
        height: width
        text: ""
        icon: "images/settings.png"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: infoButton.right
        anchors.leftMargin: 10
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        textColor: master.textColor1
        onClicked: settingsClicked()
    }
    Button {
        id: exitButton
        width: parent.width * 0.15
        height: width
        text: ""
        icon: "images/exit.png"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        textColor: master.textColor1
        onClicked: Qt.quit()
    }

    Button {
        id: upDownButton
        width: parent.width - 20
        height: parent.height*0.08
        text: "Advanced..."
        anchors.bottom: advancedColumn.top
        anchors.bottomMargin: 5
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        defaultGradient: master.defaultGradient
        border.color: master.border.color
        hoveredGradient: master.hoveredGradient
        pressedGradient: master.pressedGradient
        onClicked: advancedColumn.enabled = !advancedColumn.enabled
        font.pixelSize: master.textSize2
        textColor: master.textColor1
        font.bold: true
    }


    Column {
        id: advancedColumn
        enabled: false
        height: enabled?parent.height * 0.5:0
        visible: height < 30?false:true
        spacing: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10

        Behavior on height {
                         NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                     }

        Label {
            id: label
            width: parent.width
            height: (parent.height-parent.spacing*5) / 6
            text: "Password:"
            gradient: master.labelGradient
            border.color: master.border.color
            textColor: master.textColor2
            font.pixelSize: master.textSize1
        }

        LineEdit {
            id:passwordEdit
            width: parent.width
            height: (parent.height-parent.spacing*5) / 6
            text: "Test"
            labelEnabled: false
            autodelete: false
            echoMode: TextInput.Password
            gradient: master.pressedGradient
            border.color: master.border.color
            textColor: master.textColor1
            font.pixelSize: master.textSize1
        }

        Label {
            id: label1
            width: parent.width
            height: (parent.height-parent.spacing*5) / 6
            text: "Hostname or IP-Address"
            border.color: master.border.color
            gradient: master.labelGradient
            textColor: master.textColor2
            font.pixelSize: master.textSize1
        }

        LineEdit {
            id: hostNameEdit
            width: parent.width
            height: (parent.height-parent.spacing*5) / 6
            text: "Test"
            border.color: master.border.color
            labelEnabled: false
            autodelete: false
            gradient: master.pressedGradient
            textColor: master.textColor1
            font.pixelSize: master.textSize1
        }

        Label {
            id: label2
            width: parent.width
            height: (parent.height-parent.spacing*5) / 6
            text: "Port"
            border.color: master.border.color
            gradient: master.labelGradient
            textColor: master.textColor2
            font.pixelSize: master.textSize1
        }

        SpinBox {
            id: portSpin
            width: parent.width
            height: (parent.height-parent.spacing*5) / 6
            border.color: master.border.color
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            textColor: master.textColor1
            font.pixelSize: master.textSize2
            font.bold: true
            value: 5487
        }
    }

    Column {
        id: column1
        width: 340
        spacing: 5
        anchors.top: exitButton.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10

        Button {
            id: broadcastButton
            height: main.height*0.1
            text: "Search Servers"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            icon: ""
            font.bold: true
            font.pixelSize: master.textSize2
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            textColor: master.textColor1
            onClicked: broadcastClicked()
        }

        Button {
            id: connectButton
            height: main.height*0.1
            text: advancedColumn.enabled?"Connect":"Use last Connection"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            defaultGradient: master.defaultGradient
            border.color: master.border.color
            icon: ""
            font.bold: true
            font.pixelSize: master.textSize2
            hoveredGradient: master.hoveredGradient
            pressedGradient: master.pressedGradient
            textColor: master.textColor1
            onClicked: connectClicked()
        }
    }

}
