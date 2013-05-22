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

    Component.onCompleted: {
        client.lastConnectionAdded.connect(addLastConnection)
        client.lastConnectionsCleared.connect(clearLastConnections)
        client.updateLastConnections()
    }

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

        Item {
            id: rotator
            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent

            Behavior on width {
                             enabled: (master.state == "networkState") || (master.state == "startState")
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                             enabled: (master.state == "networkState") || (master.state == "startState")
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }

            Flickable {
                id: flickable
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
                                     NumberAnimation { id: advancedColumnAnimation; easing.type: Easing.OutCubic; duration: 300 }
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

                Rectangle {
                    id:                 listRect
                    radius:             exitButton.radius
                    border.color:       theme.buttonBorderColor
                    border.width:       2
                    smooth:             true
                    gradient:           theme.defaultGradient
                    anchors.top:        column1.bottom
                    anchors.topMargin:  master.generalMargin
                    anchors.right:      parent.right
                    anchors.rightMargin:master.generalMargin
                    anchors.left:       parent.left
                    anchors.leftMargin: master.generalMargin
                    height:             enabled ? master.buttonHeight * 5.45 : 0
                    enabled:            false

                    Behavior on height {
                                     NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                                 }

                    ListView {
                        id: listVew
                        anchors.fill: parent
                        clip: true

                        delegate: Item {
                                height: master.buttonHeight
                                width:  listVew.width

                                Button {
                                anchors.fill:           parent
                                anchors.leftMargin:     master.generalMargin/2
                                anchors.rightMargin:    master.generalMargin/2
                                anchors.topMargin:      master.generalMargin/2
                                border.color:           theme.buttonBorderColor

                                Row {
                                    id:         row1
                                    x:          master.generalMargin
                                    spacing:    master.generalMargin*2
                                    height:     parent.height
                                    Image {
                                        width:      parent.height * 0.8
                                        height:     width
                                        source:     master.imagePath + master.iconTheme + "/computer.png"
                                        fillMode:   Image.PreserveAspectFit
                                        anchors.verticalCenter: parent.verticalCenter
                                    }

                                    Text {
                                        text:           hostName + " : " + port
                                        font.bold:      theme.buttonFontBold
                                        font.pixelSize: theme.buttonFontSize
                                        font.family:    theme.fontFamily
                                        color:          theme.primaryTextColor
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }

                                onReleased: {

                                    connectPage.password = password
                                    connectPage.hostname = hostName
                                    connectPage.port = port
                                    connectClicked()
                                }

                            }
                        }
                        model: ListModel {
                            id: listModel
                            ListElement {
                                hostName: "10.0.0.1"
                                password: ""
                                port:     5487
                            }
                        }
                    }
                }

                Column {
                    id: column1
                    spacing: master.generalMargin
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

                    Row {
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        spacing: master.generalMargin/2
                        Button {
                            id: connectButton
                            height: master.buttonHeight
                            text: advancedColumn.enabled?qsTr("Connect") + client.emptyString :qsTr("Use last Connection") + client.emptyString
                            width: advancedColumn.enabled ? parent.width : parent.width - master.buttonHeight*0.9 - master.generalMargin/2
                            icon: ""
                            onClicked: {
                                connectClicked()
                                main.forceActiveFocus() // remove the focus from all inputs
                            }

                            Behavior on width {
                                            enabled: advancedColumnAnimation.running
                                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                                         }
                        }
                        Button {
                            id: lastConnectionButton
                            height: master.buttonHeight
                            width: advancedColumn.enabled ? 0 : master.buttonHeight*0.9
                            icon:  master.imagePath + master.iconTheme + "/up.png"
                            iconRotation: listRect.enabled ? 0 : 180
                            onClicked: {
                                listRect.enabled = !listRect.enabled
                            }

                            Behavior on width {
                                            enabled: advancedColumnAnimation.running
                                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                                         }
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
                    listRect.enabled = false
                    advancedClicked()
                }
            }
        }
    }

    function addLastConnection(hostName, password, port)
    {
        listModel.append({"hostName":hostName, "password":password, "port":port})
    }

    function clearLastConnections()
    {
        listModel.clear()
    }

}
