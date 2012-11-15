// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    signal continueClicked

    id: rectangle1
    width: 360
    height: 640
    color: "#00000000"

    Label {
        id: label1
        height: parent.height*0.4
        text: "<html>
                <p align=center>
                <nobr><b>QRemoteControl 2.0</b></nobr>
                <br><br>
                <nobr>Copyright 2012 by</nobr><br>
                <nobr>Alexander R&ouml;ssler</nobr><br>
                <br>
                If you find bugs and errors or want to give feedback please contact:
                <i>mail.aroessler@gmail.com</i><br>
                <br>
                If you find this application useful please show it to your friends and vote for it.
                </p>
                </html>"
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20
                wrapMode: 1
         anchors.verticalCenter: parent.verticalCenter
         gradient: master.labelGradient
         textColor: master.textColor2
         font.pixelSize: master.textSize1
    }

    Button {
            id: exitButton
            height: parent.height * 0.08
            text: "Continue"
            font.bold: true
            font.pixelSize: master.textSize2
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            icon: ""
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            textColor: master.textColor1
            onClicked: continueClicked()
        }

        Image {
            id: image1
            width: parent.width*0.3
            height: width
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
            anchors.bottom: label1.top
            anchors.bottomMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/qrc.png"
            smooth: true
        }
}
