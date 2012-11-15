// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtWebKit 1.0
import MyComponents 1.0

Rectangle {
    signal continueClicked

    id: rectangle1
    width: 360
    height: 640
    color: "#00000000"
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

        FlickableWebView {
            id: web_view1
            //preferredHeight: height
            //preferredWidth: width
            anchors.bottomMargin: exitButton.height + 20
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.fill: parent
            url: "help.html"
        }
}

