// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Button {
    id: mainButton
    width: height
    height: 161
    round: true

    property bool ignorePress: false

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
        iconSource: master.imagePath + master.iconTheme + "/ok.png"

        onPressed: {
            if (!ignorePress)
                okPressed()
        }
        onReleased: {
            if (!ignorePress)
                okReleased()
            ignorePress = false
        }
    }

    Image {
        id: image2
        width: mainButton.width/5
        height: width
        anchors.horizontalCenter: rightArea.horizontalCenter
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: rightArea.verticalCenter
        smooth: true
        fillMode: Image.PreserveAspectFit
        source: master.imagePath + master.iconTheme + "/right.png"
    }

    Image {
        id: image3
        width: mainButton.width/5
        height: width
        anchors.horizontalCenter: leftArea.horizontalCenter
        smooth: true
        source: master.imagePath + master.iconTheme + "/left.png"
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenterOffset: 0
        anchors.verticalCenter: leftArea.verticalCenter
    }

    Image {
        id: image4
        width: mainButton.width/5
        height: width
        anchors.verticalCenter: upArea.verticalCenter
        anchors.horizontalCenter: upArea.horizontalCenter
        smooth: true
        source: master.imagePath + master.iconTheme + "/up.png"
        fillMode: Image.PreserveAspectFit
    }

    Image {
        id: image5
        width: mainButton.width/5
        height: width
        anchors.horizontalCenter: downArea.horizontalCenter
        anchors.verticalCenter: downArea.verticalCenter
        smooth: true
        source: master.imagePath + master.iconTheme + "/down.png"
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        id: downArea
        width: okButton.width
        height: parent.height - okButton.y - okButton.height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        onPressed: {
            downPressed()
            ignorePress = true
            mouse.accepted = false
        }
        onReleased: {
            downReleased()
            mouse.accepted = false
        }
    }

    MouseArea {
        id: upArea
        width: okButton.width
        height: okButton.y
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        onPressed: {
            upPressed()
            ignorePress = true
            mouse.accepted = false
        }
        onReleased: {
            upReleased()
            mouse.accepted = false
        }
    }

    MouseArea {
        id: leftArea
        width: okButton.x
        height: okButton.height
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        onPressed: {
            leftPressed()
            ignorePress = true
            mouse.accepted = false
        }
        onReleased: {
            leftReleased()
            mouse.accepted = false
        }
    }

    MouseArea {
        id: rightArea
        width: parent.width - okButton.x - okButton.width
        height: okButton.height
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        onPressed: {
            rightPressed()
            ignorePress = true
            mouse.accepted = false
        }
        onReleased: {
            rightReleased()
            mouse.accepted = false
        }
    }
}
