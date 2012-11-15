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

    GridView {
        id: gridView
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.fill: parent
        cellHeight: (parent.width-20) / 4 -1
        cellWidth: cellHeight
        delegate: Item {
            width: gridView.cellWidth
            height: gridView.cellHeight
            Button {
                anchors.fill: parent
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                anchors.topMargin: 5
                anchors.bottomMargin: 5
                text: name
                defaultGradient: master.defaultGradient
                hoveredGradient: master.hoveredGradient
                pressedGradient: master.pressedGradient
                border.color: master.border.color
                font.bold: true
                font.pixelSize: master.textSize1
                textColor: master.textColor1
                icon: (image != "")? "../../"+image:""
                onPressed: client.sendAction(index+1,true)
                onReleased: client.sendAction(index+1,false)
            }
        }
        model: ListModel {
            id: listModel
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
