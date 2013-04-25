import QtQuick 1.1
import "MyComponents/"

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
        width: master.buttonHeight
        height: width
        text: ""
        icon: master.imagePath + master.iconTheme + "/settings.png"
        anchors.top: parent.top
        anchors.topMargin: master.generalMargin
        anchors.left: parent.left
        anchors.leftMargin: master.generalMargin
        rotation:           master.screenRotation
        onClicked: {
            settingsClicked()
            main.forceActiveFocus() // remove the focus from all inputs
        }
    }
    Button {
        id: helpButton
        width: master.buttonHeight
        height: width
        text: ""
        icon: master.imagePath + master.iconTheme + "/help.png"
        anchors.top: parent.top
        anchors.topMargin: master.generalMargin
        anchors.left: settingsButton.right
        anchors.leftMargin: master.generalMargin
        rotation:           master.screenRotation
        onClicked: {
            helpClicked()
            main.forceActiveFocus() // remove the focus from all inputs
        }
    }
    Button {
        id: infoButton
        width: master.buttonHeight
        height: width
        anchors.left: helpButton.right
        anchors.topMargin: master.generalMargin
        anchors.top: parent.top
        iconSource: master.imagePath + master.iconTheme + "/info.png"
        anchors.leftMargin: master.generalMargin
        rotation:           master.screenRotation
        onClicked: {
            infoClicked()
            main.forceActiveFocus() // remove the focus from all inputs
        }
    }
    Button {
        id: likeButton
        width: master.buttonHeight
        height: width
        text: ""
        icon: master.imagePath + master.iconTheme + "/like.png"
        anchors.top: parent.top
        anchors.topMargin: master.generalMargin
        anchors.left: infoButton.right
        anchors.leftMargin: master.generalMargin
        rotation:           master.screenRotation
        onClicked: {
            Qt.openUrlExternally("http://www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2FQRemoteControl%3Fref%3Dstream&send=false&layout=standard&width=480&show_faces=true&action=like&colorscheme=light&font=arial&height=640")
            main.forceActiveFocus() // remove the focus from all inputs
        }
    }

    Button {
        id: exitButton
        width: master.buttonHeight
        height: width
        text: ""
        icon: master.imagePath + master.iconTheme + "/exit.png"
        anchors.right: parent.right
        anchors.rightMargin: master.generalMargin
        anchors.top: parent.top
        anchors.topMargin: master.generalMargin
        rotation:           master.screenRotation
        onClicked: Qt.quit()
    }

    Item {
        id: wrapper
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: exitButton.bottom
        anchors.topMargin: master.generalMargin

        Item {
            id: rotator
            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent

            Flickable {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: upDownButton.top
                anchors.bottomMargin: master.generalMargin
                flickableDirection: Flickable.VerticalFlick
                clip: true
                contentHeight: master.buttonHeight * 8
                contentWidth: width

                Column {
                    id: advancedColumn
                    enabled: false
                    height: enabled?master.height * 0.5:0
                    visible: height < 30?false:true
                    spacing: master.generalMargin/2
                    anchors.top: column1.bottom
                    anchors.topMargin: master.generalMargin
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin

                    Behavior on height {
                                     NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                                 }

                    Label {
                        id: label
                        width: parent.width
                        height: (parent.height-parent.spacing*5) / 6
                        text: qsTr("Password") + client.emptyString
                    }

                    LineEdit {
                        id:passwordEdit
                        width: parent.width
                        height: (parent.height-parent.spacing*5) / 6
                        text: "Test"
                        emptyText: qsTr("Server password, leave empty if none") + client.emptyString
                        labelEnabled: false
                        autodelete: false
                        echoMode: TextInput.Password
                    }

                    Label {
                        id: label1
                        width: parent.width
                        height: (parent.height-parent.spacing*5) / 6
                        text: qsTr("Hostname or IP-Address") + client.emptyString
                    }

                    LineEdit {
                        id: hostNameEdit
                        width: parent.width
                        height: (parent.height-parent.spacing*5) / 6
                        text: "Test"
                        emptyText: qsTr("e.g. prometeus, 10.0.0.2, ...") + client.emptyString
                        labelEnabled: false
                        autodelete: false
                    }

                    Label {
                        id: label2
                        width: parent.width
                        height: (parent.height-parent.spacing*5) / 6
                        text: qsTr("Port") + client.emptyString
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
                    spacing: master.generalMargin/2
                    anchors.top: parent.top
                    anchors.topMargin: master.generalMargin
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin

                    Button {
                        id: broadcastButton
                        height: master.buttonHeight
                        text: advancedColumn.enabled?qsTr("Wake on Lan") + client.emptyString:qsTr("Search Servers") + client.emptyString
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        icon: ""
                        onClicked: {
                            if (advancedColumn.enabled)
                                wolClicked()
                            else
                                broadcastClicked()
                            main.forceActiveFocus() // remove the focus from all inputs
                        }
                    }

                    Button {
                        id: connectButton
                        height: master.buttonHeight
                        text: advancedColumn.enabled?qsTr("Connect") + client.emptyString :qsTr("Use last Connection") + client.emptyString
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        icon: ""
                        onClicked: {
                            connectClicked()
                            main.forceActiveFocus() // remove the focus from all inputs
                        }
                    }
                }
            }
            Button {
                id: upDownButton
                height: master.buttonHeight * 0.8
                text: qsTr("Advanced...") + client.emptyString
                checkable: true
                anchors.left: parent.left
                anchors.leftMargin: master.generalMargin
                anchors.right: parent.right
                anchors.rightMargin: master.generalMargin
                anchors.bottom: parent.bottom
                anchors.bottomMargin: master.generalMargin
                border.color: master.border.color
                onClicked: {
                    advancedColumn.enabled = !advancedColumn.enabled
                    advancedClicked()
                }
            }
        }
    }

}
