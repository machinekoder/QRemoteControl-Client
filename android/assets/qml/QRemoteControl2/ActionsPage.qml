// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

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
        anchors.margins: 10

        GridView {
            id:             gridView

            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent

            cellWidth:      parent.width / 4 - 1   //4 items in a row
            cellHeight:     cellHeight

            delegate: Item {
                width:  gridView.cellWidth
                height: gridView.cellHeight
                Button {
                    anchors.fill:           parent
                    anchors.leftMargin:     5
                    anchors.rightMargin:    5
                    anchors.topMargin:      5
                    anchors.bottomMargin:   5
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
                            NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on width {
                            NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
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
        if (id > listModel.count)
            listModel.append({"name": name, "image": image})
        else
        {
            for (var i = id-1; i < listModel.count; i++)
                listModel.remove(i)
            listModel.insert(id-1,{"name": name, "image": image})
        }
    }
    function actionReceived(id,name,filePath)
    {
        addAction(id,name,filePath)
    }
}
