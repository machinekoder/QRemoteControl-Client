// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Button {
    id: mainButton
    width: height
    height: 161
    round: true
    defaultGradient: master.defaultGradient
    pressedGradient: master.pressedGradient
    hoveredGradient: master.hoveredGradient
    border.color: master.border.color
    signal leftPressed
    signal leftReleased
    signal rightPressed
    signal rightReleased
    signal upPressed
    signal upReleased
    signal downPressed
    signal downReleased
    signal okPressed
    signal okReleased

    Button {
        id: okButton
        round: true
        width: height
        height: parent.height *0.4
        text: ""
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        iconMargin: 15
        iconSource: "images/ok.png"
        defaultGradient: master.defaultGradient
        pressedGradient: master.pressedGradient
        hoveredGradient: master.hoveredGradient
        border.color: master.border.color
        onPressed: okPressed()
        onReleased: okReleased()
    }

    Image {
        id: image2
        width: 30
        height: 30
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
        smooth: true
        fillMode: Image.PreserveAspectFit
        source: "images/right.png"
    }

    Image {
        id: image3
        width: 30
        height: 30
        anchors.left: parent.left
        anchors.leftMargin: 10
        smooth: true
        source: "images/left.png"
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: parent.verticalCenter
    }

    Image {
        id: image4
        width: 30
        height: 30
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        smooth: true
        source: "images/up.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image5
        width: 30
        height: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        smooth: true
        source: "images/down.png"
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        id: downArea
        width: okButton.width
        height: parent.height - okButton.y - okButton.height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        onPressed: downPressed()
        onReleased: downReleased()
    }

    MouseArea {
        id: upArea
        width: okButton.width
        height: okButton.y
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        onPressed: upPressed()
        onReleased: upReleased()
    }

    MouseArea {
        id: leftArea
        width: okButton.x
        height: okButton.height
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        onPressed: leftPressed()
        onReleased: leftReleased()
    }

    MouseArea {
        id: rightArea
        width: parent.width - okButton.x - okButton.width
        height: okButton.height
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        onPressed: rightPressed()
        onReleased: rightReleased()
    }
}
