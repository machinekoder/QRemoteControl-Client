import QtQuick 2.0
import "MyComponents/"

Item {
    property int n: 10
    property alias macAddress: macEdit.text
    property alias hostname: domainEdit.text
    property alias udpPort: portSpin.value
    property alias datagramNumber: numberSpin.value

    signal backClicked
    signal wolClicked

    id: main
    width: 360
    height: 640

    Item {
        id: wrapper
        anchors.fill: parent

        Item {
            id: rotator
            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent

            Behavior on width {
                             enabled: master.state == "wakeOnLanState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                             enabled: master.state == "wakeOnLanState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }

            Flickable {
                id: flicker
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: wakeButton.top
                anchors.bottomMargin: master.generalMargin
                contentHeight: master.buttonHeight * 7
                contentWidth: width
                flickableDirection: Flickable.VerticalFlick
                clip: true

                Column {
                    id: mainColumn
                    spacing: master.generalMargin/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: master.generalMargin
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                    anchors.top: parent.top
                    anchors.topMargin: master.generalMargin

                    Behavior on height {
                                     NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                                 }


                    Label {
                        id:             label
                        width:          parent.width
                        height:         master.buttonHeight * 0.8
                        text:           qsTr("Mac Address") + client.emptyString
                    }

                    LineEdit {
                        id:             macEdit
                        width:          parent.width
                        height:         master.buttonHeight * 0.8
                        text:           ""
                        emptyText:      qsTr("NIC Mac e.g. 00:1d:60:e8:6d:0g ") + client.emptyString
                        labelEnabled:   false
                        autodelete:     true
                    }

                    Label {
                        id:             label1
                        width:          parent.width
                        height:         master.buttonHeight * 0.8
                        text:           qsTr("Server Domain or IP Address") + client.emptyString
                    }

                    LineEdit {
                        id:             domainEdit
                        width:          parent.width
                        height:         master.buttonHeight * 0.8
                        text:           ""
                        emptyText:      qsTr("IP address or Hostname, leave empty for LAN") + client.emptyString
                        labelEnabled:   false
                        autodelete:     true
                    }

                    Label {
                        id:             label2
                        width:          parent.width
                        height:         master.buttonHeight * 0.8
                        text:           qsTr("UDP Port") + client.emptyString
                    }

                    SpinBox {
                        id:             portSpin
                        width:          parent.width
                        height:         master.buttonHeight * 0.8
                        value:          80
                    }
                    Label {
                        id:             label3
                        width:          parent.width
                        height:         master.buttonHeight * 0.8
                        text:           qsTr("Number of Datagrams") + client.emptyString
                    }

                    SpinBox {
                        id:             numberSpin
                        width:          parent.width
                        height:         master.buttonHeight * 0.8
                        font.bold:      true
                        value: 5
                    }
                }
            }
            Button {
                id:                     wakeButton
                anchors.left:           parent.left
                anchors.leftMargin:     master.generalMargin
                anchors.right:          parent.right
                anchors.rightMargin:    master.generalMargin
                anchors.bottom:         backButton.top
                anchors.bottomMargin:   master.generalMargin
                height:                 master.buttonHeight * 0.8
                text:                   qsTr("Wake up!") + client.emptyString
                icon:                   ""
                onClicked:              wolClicked()
                }
            Button {
                id:                     backButton
                anchors.left:           parent.left
                anchors.leftMargin:     master.generalMargin
                anchors.right:          parent.right
                anchors.rightMargin:    master.generalMargin
                anchors.bottom:         parent.bottom
                anchors.bottomMargin:   master.generalMargin
                height:                 master.buttonHeight * 0.8
                icon:                   ""
                text:                   qsTr("Back") + client.emptyString
                onClicked:              backClicked()
                }
        }
    }
}
