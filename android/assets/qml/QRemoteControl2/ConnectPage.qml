// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    property alias password: passwordEdit.text
    property alias hostname: hostNameEdit.text
    property alias port: portSpin.value
    property alias advancedSelected: advancedColumn.enabled

    signal helpClicked
    signal infoClicked
    signal settingsClicked
    signal connectClicked
    signal broadcastClicked
    signal advancedClicked
    signal wolClicked


    id: main
    width: 360
    height: 640
    color: "#00000000"

    Button {
        id: settingsButton
        width: parent.width * 0.15
        height: width
        text: ""
        icon: master.imagePath + master.iconTheme + "/settings.png"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        onClicked: settingsClicked()
    }
    Button {
        id: helpButton
        width: parent.width * 0.15
        height: width
        text: ""
        icon: master.imagePath + master.iconTheme + "/help.png"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: settingsButton.right
        anchors.leftMargin: 10
        onClicked: helpClicked()
    }
    Button {
        id: infoButton
        width: parent.width * 0.15
        height: width
        anchors.left: helpButton.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        iconSource: master.imagePath + master.iconTheme + "/info.png"
        anchors.topMargin: 10
        onClicked: infoClicked()
    }
    Button {
        id: likeButton
        width: parent.width * 0.15
        height: width
        text: ""
        icon: master.imagePath + master.iconTheme + "/like.png"
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: infoButton.right
        anchors.leftMargin: 10
        onClicked: Qt.openUrlExternally("http://www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2FQRemoteControl%3Fref%3Dstream&send=false&layout=standard&width=480&show_faces=true&action=like&colorscheme=light&font=arial&height=640")
    }


    Button {
        id: exitButton
        width: parent.width * 0.15
        height: width
        text: ""
        icon: master.imagePath + master.iconTheme + "/exit.png"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        onClicked: Qt.quit()
    }

    Button {
        id: upDownButton
        width: parent.width - 20
        height: parent.height*0.08
        text: qsTr("Advanced...")
        anchors.bottom: advancedColumn.top
        anchors.bottomMargin: 5
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        border.color: master.border.color
        onClicked: {
            advancedColumn.enabled = !advancedColumn.enabled
            advancedClicked()
        }
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
            text: qsTr("Password")
        }

        LineEdit {
            id:passwordEdit
            width: parent.width
            height: (parent.height-parent.spacing*5) / 6
            text: "Test"
            emptyText: qsTr("Server password, leave empty if none")
            labelEnabled: false
            autodelete: false
            echoMode: TextInput.Password
        }

        Label {
            id: label1
            width: parent.width
            height: (parent.height-parent.spacing*5) / 6
            text: qsTr("Hostname or IP-Address")
        }

        LineEdit {
            id: hostNameEdit
            width: parent.width
            height: (parent.height-parent.spacing*5) / 6
            text: "Test"
            emptyText: qsTr("e.g. prometeus, 10.0.0.2, ...")
            labelEnabled: false
            autodelete: false
        }

        Label {
            id: label2
            width: parent.width
            height: (parent.height-parent.spacing*5) / 6
            text: qsTr("Port")
        }

        SpinBox {
            id: portSpin
            width: parent.width
            height: (parent.height-parent.spacing*5) / 6
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
            text: advancedColumn.enabled?qsTr("Wake on Lan"):qsTr("Search Servers")
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            icon: ""
            onClicked: advancedColumn.enabled?wolClicked():broadcastClicked()
        }

        Button {
            id: connectButton
            height: main.height*0.1
            text: advancedColumn.enabled?qsTr("Connect"):qsTr("Use last Connection")
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            icon: ""
            onClicked: connectClicked()
        }
    }

}
