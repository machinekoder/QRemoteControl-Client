import QtQuick 2.0
import "MyComponents"

Item {
    signal disconnectClicked
    signal settingsClicked

    id: main

    width: 100
    height: 62

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
        }
    }

    Button {
        id: disconnectButton
        width: master.buttonHeight
        height: width
        text: ""
        icon: master.imagePath + master.iconTheme + "/disconnect.png"
        anchors.top: parent.top
        anchors.topMargin: master.generalMargin
        anchors.right: parent.right
        anchors.rightMargin: master.generalMargin
        rotation:           master.screenRotation
        onClicked: {
            disconnectClicked()
        }
    }

    Item {
        id: wrapper
        anchors.top:        settingsButton.bottom
        anchors.right:      parent.right
        anchors.left:       parent.left
        anchors.bottom:         parent.bottom
        anchors.margins:     master.generalMargin/2

        Text {
            id: label
            text: qsTr("To see some items here add some commands on the client.") + client.emptyString
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            anchors.right: parent.right
            anchors.rightMargin: master.buttonHeight*0.5
            anchors.left: parent.left
            anchors.leftMargin: master.buttonHeight*0.5
            anchors.verticalCenter: parent.verticalCenter
            visible: gridView.model.count === 0
            color: theme.primaryColor
            font.pixelSize: theme.fontSizeSmall
            rotation: master.screenRotation
        }

        GridView {
            id:             gridView

            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent
            clip:           true

            cellWidth:      parent.width / 2 - 1   //3 items in a row
            cellHeight:     master.buttonHeight

            delegate: Item {
                width:  gridView.cellWidth
                height: gridView.cellHeight
                Button {
                    anchors.fill:           parent
                    anchors.leftMargin:     master.generalMargin/2
                    anchors.rightMargin:    master.generalMargin/2
                    anchors.topMargin:      master.generalMargin/2
                    anchors.bottomMargin:   master.generalMargin/2
                    text:                   modelData
                    //icon:                   (image.charAt(image.length-1) !== "/")? "file:///"+image:""
                    onClicked:              remoteBoxClient.runData(index)
                }
            }
            model: remoteBoxClient.storedCommands /*ListModel {
                id: listModel

            }*/
            Behavior on width {
                            enabled: (main.opacity == 1)
                            NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                            enabled: (main.opacity == 1)
                            NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                            }
        }
    }
}
