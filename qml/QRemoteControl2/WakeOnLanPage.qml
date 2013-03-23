import QtQuick 1.1
import "MyComponents/"

Rectangle {
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
    color: "#00000000"


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
            height:         (parent.height-parent.spacing*(n-1)) / n
            text:           qsTr("Mac Address")
        }

        LineEdit {
            id:             macEdit
            width:          parent.width
            height:         (parent.height-parent.spacing*(n-1)) / n
            text:           ""
            emptyText:      qsTr("NIC Mac e.g. 00:1d:60:e8:6d:0g ")
            labelEnabled:   false
            autodelete:     true
        }

        Label {
            id:             label1
            width:          parent.width
            height:         (parent.height-parent.spacing*(n-1)) / n
            text:           qsTr("Server Domain or IP Address")
        }

        LineEdit {
            id:             domainEdit
            width:          parent.width
            height:         (parent.height-parent.spacing*(n-1)) / n
            text:           ""
            emptyText:      qsTr("IP address or Hostname, leave empty for LAN")
            labelEnabled:   false
            autodelete:     true
        }

        Label {
            id:             label2
            width:          parent.width
            height:         (parent.height-parent.spacing*(n-1)) / n
            text:           qsTr("UDP Port")
        }

        SpinBox {
            id:             portSpin
            width:          parent.width
            height:         (parent.height-parent.spacing*(n-1)) / n
            value:          80
        }
        Label {
            id:             label3
            width:          parent.width
            height:         (parent.height-parent.spacing*(n-1)) / n
            text:           qsTr("Number of Datagrams")
        }

        SpinBox {
            id:             numberSpin
            width:          parent.width
            height:         (parent.height-parent.spacing*(n-1)) / n
            font.bold:      true
            value: 5
        }
        Button {
            id:             wakeButton
            width:          parent.width
            height:         (parent.height-parent.spacing*(n-1)) / n
            text:           qsTr("Wake up!")
            icon:           ""
            onClicked:      wolClicked()
            }
        Button {
            id:             backButton
            width:          parent.width
            height:         (parent.height-parent.spacing*(n-1)) / n
            icon:           ""
            text:           qsTr("Back")
            onClicked:      backClicked()
            }
    }
}
