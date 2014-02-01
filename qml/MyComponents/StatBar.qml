// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

Rectangle {
    property double value1: 0.3
    property double value2: 0.2
    property color color1: "blue"
    property color color2: "green"
    property color color3: "red"
    property color textColor: "white"
    property bool textVisible: true
    width: 200
    height: 20
    radius: 5
    z: 2147483646
    border.width: 2
    border.color: "#000000"

    Rectangle {
        id: leftRectangle
        x: 0
        y: 0
        width: parent.width * value1
        height: parent.height
        gradient: Gradient {
            GradientStop {
                position: 0
                color: color1
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }

        Text {
            id: text1
            text: value1*100 + "%"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: (color1 == "#ffffff")?"black": textColor
            font.pixelSize: 12
            visible: textVisible?(width < parent.width) && (height < parent.height) ? true : false:false;
        }
    }

    Rectangle {
        id: middleRectangle
        x: leftRectangle.width
        y: 0
        width: parent.width * value2
        height: parent.height
        gradient: Gradient {
            GradientStop {
                position: 0
                color: color2
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }

        Text {
            id: text3
            text: value2*100 + "%"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: textColor
            font.pixelSize: 12
            visible: textVisible?(width < parent.width) && (height < parent.height) ? true : false : false;
        }
    }

    Rectangle {
        id: rightRectangle
        x: leftRectangle.width + middleRectangle.width
        y: 0
        width: parent.width-leftRectangle.width-middleRectangle.width
        height: parent.height
        gradient: Gradient {
            GradientStop {
                position: 0
                color: color3
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }

        Text {
            id: text2
            text: 100-value1*100-value2*100 + "%"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            color: textColor
            font.pixelSize: 12
            visible: textVisible?(width < parent.width) && (height < parent.height) ? true : false: false;
        }
    }
}
