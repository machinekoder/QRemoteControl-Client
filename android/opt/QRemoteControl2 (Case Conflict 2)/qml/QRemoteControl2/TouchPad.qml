// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    property alias leftButtonCheckable: leftButton.checkable
    property alias middleButtonCheckable: middleButton.checkable
    property alias rightButtonCheckable: rightButton.checkable

    id: main
    width: 300
    height: 300
    color: "#00000000"

    property int clickTime: 150

    signal leftButtonClicked
    signal leftButtonPressed
    signal leftButtonReleased
    signal middleButtonClicked
    signal middleButtonPressed
    signal middleButtonReleased
    signal rightButtonClicked
    signal rightButtonPressed
    signal rightButtonReleased
    signal horizontalScroll(int delta)
    signal verticalScroll(int delta)
    signal mouseMove(int deltaX, int deltaY)

    Rectangle {
        id: rectangle1
        width: parent.width
        height: parent.height - buttonRow.height - 5
        radius: 11
        smooth: true
        gradient: master.defaultGradient
        border.width: 2
        border.color: master.border.color

        MouseArea {
            property int lastPos

            id: horizontalScrollArea
            width: parent.width
            height: 45
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0

            onPressed: lastPos = mouseX
            onMouseXChanged: {
                if (pressed) {
                    var delta = mouseX - lastPos
                    if (delta != 0) {
                        lastPos = mouseX
                        horizontalScroll(delta)
                        //console.log("X scroll:" + delta)
                    }
                }
            }
        }

        MouseArea {
            property int lastPos

            id: verticalScrollArea
            width: 45
            height: parent.height - horizontalScrollArea.height
            anchors.right: parent.right
            anchors.rightMargin: 0

            onPressed: lastPos = mouseY
            onMouseXChanged: {
                if (pressed) {
                    var delta = mouseY - lastPos
                    if (delta != 0)
                    {
                        lastPos = mouseY
                        verticalScroll(delta)
                        //console.log("Y scroll:" + delta)
                    }
                }
            }
        }

        MouseArea {
            property int lastPosX
            property int lastPosY
            property variant pressTime

            id: touchArea
            width: parent.width - verticalScrollArea.width
            height: parent.height - horizontalScrollArea.height
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            onPressed: {
                lastPosX = mouseX
                lastPosY = mouseY
                pressTime = (new Date()).getTime()
            }
            onReleased: {
                var currentTime = (new Date()).getTime()
                var clickedTime = currentTime - pressTime
                if (clickedTime < clickTime) {
                    if (!leftButton.checked)
                    {
                        main.leftButtonClicked()
                        main.leftButtonPressed()
                        main.leftButtonReleased()
                    }
                    //console.log("clicked time: " + clickedTime)
                }
            }

            onMouseXChanged: {
                if (pressed) {
                    var deltaX = mouseX - lastPosX
                    var deltaY = mouseY - lastPosY
                    if ((deltaX != 0) || (deltaY != 0)) {
                        lastPosX = mouseX
                        lastPosY = mouseY
                        mouseMove(deltaX, deltaY)
                        //console.log("Mouse-move: x:" + deltaX + " y:" + deltaY)
                    }
                }
            }
        }

        Image {
            id: image1
            width:  horizontalScrollArea.width * 0.8
            smooth: true
            anchors.horizontalCenter: horizontalScrollArea.horizontalCenter
            anchors.verticalCenter: horizontalScrollArea.verticalCenter
            source: "images/hscroll.png"
        }

        Image {
            id: image2
            height: verticalScrollArea.height * 0.8
            smooth: true
            anchors.horizontalCenter: verticalScrollArea.horizontalCenter
            anchors.verticalCenter: verticalScrollArea.verticalCenter
            source: "images/vscroll.png"
        }
    }

    Row {
        id: buttonRow
        width: parent.width
        height: parent.height*0.13
        spacing: 7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Button {
            id: leftButton
            width:  (parent.width - parent.spacing*2) / 3
            height: parent.height
            onClicked: main.leftButtonClicked()
            onPressed: {
                if (!(checkable && checked))
                    main.leftButtonPressed()
            }
            onReleased: {
                if (!(checkable && !checked))
                    main.leftButtonReleased()
            }
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
        }

        Button {
            id: middleButton
            width:  (parent.width - parent.spacing*2) / 3
            height: parent.height
            onClicked: main.middleButtonClicked()
            onPressed: {
                if (!(checkable && checked))
                    main.middleButtonPressed()
            }
            onReleased: {
                if (!(checkable && !checked))
                    main.middleButtonReleased()
            }
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
        }

        Button {
            id: rightButton
            width:  (parent.width - parent.spacing*2) / 3
            height: parent.height
            onClicked: main.rightButtonClicked()
            onPressed: {
                if (!(checkable && checked))
                    main.rightButtonPressed()
            }
            onReleased: {
                if (!(checkable && !checked))
                    main.rightButtonReleased()
            }
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
        }
    }
}
