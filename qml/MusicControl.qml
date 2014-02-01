import QtQuick 2.0
import "MyComponents/"

Item {
    id: sizeRect

Row {
    //id: row1
    //width: button18.width + button16.width + button19.width + button17.width + spacing * 3
    //height: button18.height
    anchors.horizontalCenter: parent.horizontalCenter
    //anchors.bottom: parent.bottom
    //anchors.bottomMargin: master.generalMargin
    //width: 300
    height: parent.height
    spacing: master.generalMargin



    Button {
        id:                     button16
        width:                  sizeRect.width*0.19
        height:                 parent.height*0.8
        anchors.verticalCenter: parent.verticalCenter
        iconSource:             master.imagePath + master.iconTheme + "/seek_backward.png"
        onPressed:              buttonPressed(16)
        onReleased:             buttonReleased(16)
        rotation:               buttonRotation
        animated:               buttonAnimated
    }

    Button {
        id:                     button18
        width:                  sizeRect.width*0.25
        height:                 parent.height
        anchors.verticalCenter: parent.verticalCenter
        iconSource:             master.imagePath + master.iconTheme + "/play_pause.png"
        onPressed:              buttonPressed(18)
        onReleased:             buttonReleased(18)
        rotation:               buttonRotation
        animated:               buttonAnimated
    }
    Button {
        id:                     button19
        width:                  sizeRect.width*0.19
        height:                 parent.height*0.8
        anchors.verticalCenter: parent.verticalCenter
        iconSource:             master.imagePath + master.iconTheme + "/stop.png"
        onPressed:              buttonPressed(19)
        onReleased:             buttonReleased(19)
        rotation:               buttonRotation
        animated:               buttonAnimated
    }
    Button {
        id:                     button17
        width:                  sizeRect.width*0.19
        height:                 parent.height*0.8
        anchors.verticalCenter: parent.verticalCenter
        iconSource:             master.imagePath + master.iconTheme + "/seek_forward.png"
        onPressed:              buttonPressed(17)
        onReleased:             buttonReleased(17)
        rotation:               buttonRotation
        animated:               buttonAnimated
    }
}
}
