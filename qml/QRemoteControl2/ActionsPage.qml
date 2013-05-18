import QtQuick 1.1
import "MyComponents/"

Rectangle {
    width: 400
    height: 600
    color: "#00000000"

    Component.onCompleted: {
        client.actionReceived.connect(actionReceived)
    }

    Item {
        id: wrapper
        anchors.fill: parent

        Text {
            id: label
            text: qsTr("To see some items here add some commands in the User Commands Tab on the server.") + client.emptyString
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            visible: listModel.count == 0
            color: theme.primaryTextColor
            font.pixelSize: theme.hintFontSize
            rotation: master.screenRotation
        }

        GridView {
            id:             gridView

            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent

            cellWidth:      parent.width / 4 - 1   //4 items in a row
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
                    text:                   name
                    icon:                   (image.charAt(image.length-1) !== "/")? "file:///"+image:""
                    onPressed:              client.sendAction(index+1,true)
                    onReleased:             client.sendAction(index+1,false)
                }
            }
            model: ListModel {
                id: listModel
            }
            Behavior on rotation {
                            enabled: (mainRect.state == "actionsPageState")
                            NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
            }
            Behavior on width {
                            enabled: (mainRect.state == "actionsPageState")
                            NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                            enabled: (mainRect.state == "actionsPageState")
                            NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                            }
        }
    }

    function clearActions()
    {
        listModel.clear()
    }
    function addAction(id,name,image)
    {
        if (id === 1)
            clearActions();
        //if (id > listModel.count)
            listModel.append({"name": name, "image": image})
        //else
        //{
            //for (var i = id-1; i < listModel.count; i++)
            //    listModel.remove(i)
            //listModel.insert(id-1,{"name": name, "image": image})
        //}
    }
    function actionReceived(id,name,filePath)
    {
        addAction(id,name,filePath)
    }
}
