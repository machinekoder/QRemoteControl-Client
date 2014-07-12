import QtQuick 2.0
 
Rectangle {
    id: splash
    z: 100
    property alias loadingProgress: progressRect.percent


    Rectangle {
        id: rectangle1
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#6f6f6f"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }
        anchors.fill: parent
    }

    Image {
        readonly property int smallerSide: width < height ? width : height

        source: "images/body_background_dark.png"
        fillMode: Image.Tile
        anchors.fill: parent
        smooth: true

        Image {
            id: logoImg
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -parent.smallerSide*0.1
            source: "images/qrc.png"
            smooth: true
            width: parent.smallerSide*0.40
            height: width
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
        }
        Text {
            id: text
            anchors.top: logoImg.bottom
            anchors.topMargin: parent.smallerSide*0.04
            anchors.horizontalCenter: parent.horizontalCenter
            text: "QRemoteControl"
            color: "white"
            font.pixelSize: parent.smallerSide*0.08
        }
        Rectangle {
            id:  barRect
            anchors.top: text.bottom
            anchors.topMargin: parent.smallerSide*0.04
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.smallerSide*0.6
            height: parent.smallerSide*0.015
            smooth: true
            border.color: "white"; border.width: 0; radius: 8
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#66343434" }
                GradientStop { position: 1.0; color: "#66000000" }
            }
            Rectangle {
                id: progressRect
                property real percent: 0.5
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.width*0.01
                width: parent.width*0.98*percent
                height: parent.height*0.8
                smooth: true
                border.color: "white"; border.width: 0; radius: 8
                color: "white"
            }
        }
    }

    Behavior on opacity { NumberAnimation { duration: 200 } }
} 
