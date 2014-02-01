// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "MyComponents/"
//import MyComponents 1.0

Item {
    property alias leftButtonCheckable: leftButton.checkable
    property alias middleButtonCheckable: middleButton.checkable
    property alias rightButtonCheckable: rightButton.checkable

    id: main
    width: 300
    height: 300

    property int clickTime: 150
    property int buttonTime: 500

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
        height: parent.height - buttonRow.height - master.generalMargin
        radius: leftButton.radius
        gradient: theme.defaultGradient
        border.width: theme.borderWidth
        border.color: theme.buttonBorderColor

        MouseArea {
            property int lastPos

            id: horizontalScrollArea
            width: parent.width
            height: verticalScrollArea.width
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0

            onPressed: lastPos = mouseX
            onMouseXChanged: {
                if (pressed) {
                    var delta = mouseY - lastPos
                    var deltaRounded = 0

                    if ((delta >= 1) || (delta <= -1))
                    {
                        if (delta < 0)
                            deltaRounded = Math.ceil(delta)
                        else
                            deltaRounded = Math.floor(delta)
                        lastPos += deltaRounded
                    }

                    if (deltaRounded !== 0) {
                        horizontalScroll(delta)
                    }
                }
            }

            Image {
                id: image1
                width:  parent.width * 0.8
                height: parent.height * 0.2
                smooth: true
                fillMode: Image.Stretch
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: master.imagePath + master.iconTheme + "/hscroll.png"
            }
        }

        MouseArea {
            property int lastPos

            id: verticalScrollArea
            width: parent.width * 0.13
            height: parent.height - horizontalScrollArea.height
            anchors.right: parent.right
            anchors.rightMargin: 0

            onPressed: lastPos = mouseY
            onMouseXChanged: {
                if (pressed) {
                    var delta = mouseY - lastPos
                    var deltaRounded = 0

                    if ((delta >= 1) || (delta <= -1))
                    {
                        if (delta < 0)
                            deltaRounded = Math.ceil(delta)
                        else
                            deltaRounded = Math.floor(delta)
                        lastPos += deltaRounded
                    }

                    if (deltaRounded !== 0) {
                        verticalScroll(delta)
                    }
                }
            }

            Image {
                id: image2
                width:  parent.width * 0.2
                height: parent.height * 0.8
                smooth: true
                fillMode: Image.Stretch
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: master.imagePath + master.iconTheme + "/vscroll.png"
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
                    var deltaX = touchArea.mouseX - touchArea.lastPosX
                    var deltaY = touchArea.mouseY - touchArea.lastPosY
                    var deltaYrounded = 0
                    var deltaXrounded = 0

                    if ((deltaX >= 1) || (deltaX <= -1))
                    {
                        if (deltaX < 0)
                            deltaXrounded = Math.ceil(deltaX)
                        else
                            deltaXrounded = Math.floor(deltaX)
                        touchArea.lastPosX += deltaXrounded
                    }
                    if ((deltaY >= 1) || (deltaY <= -1))
                    {
                        if (deltaY < 0)
                            deltaYrounded = Math.ceil(deltaY)
                        else
                            deltaYrounded = Math.floor(deltaY)
                        touchArea.lastPosY += deltaYrounded
                    }

                    if ((deltaXrounded !== 0) || (deltaYrounded !== 0)) {
                        mouseMove(deltaXrounded, deltaYrounded)
                        //console.log("Mouse-move: x:" + deltaXrounded + " y:" + deltaYrounded)
                    }
                }
            }
        }
    }

    Row {
        id: buttonRow
        width: parent.width
        height: parent.height*0.13
        spacing: master.generalMargin
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Button {
            property variant pressTime
            property bool    longpress : false

            id: leftButton
            width:  (parent.width - parent.spacing*2) / 3
            height: parent.height

            onClicked: {
                if (!checkable)
                {
                    main.leftButtonClicked();
                }
            }
            onPressed: {
                if (!(checkable && checked))
                {
                    main.leftButtonPressed()
                    pressTime = (new Date()).getTime()
                    longpress = false
                }
            }
            onReleased: {
                var currentTime = (new Date()).getTime()
                var clickedTime = currentTime - pressTime

                if ((clickedTime < buttonTime) || checkable)
                {
                    main.leftButtonReleased()
                    checkable = false
                }
                else
                {
                    checkable = true
                    checked = true
                    longpress = true
                }
            }
            Rectangle {
                anchors.fill: leftButton
                border.color: theme.secondaryColor
                border.width: 2
                radius: leftButton.radius+1
                color: "#00000000"
                z:-1
            }
        }

        Button {
            property variant pressTime
            property bool    longpress : false

            id: middleButton
            width:  (parent.width - parent.spacing*2) / 3
            height: parent.height

            onClicked: {
                if (!checkable)
                {
                    main.middleButtonClicked();
                }
            }
            onPressed: {
                if (!(checkable && checked))
                {
                    main.middleButtonPressed()
                    pressTime = (new Date()).getTime()
                    longpress = false
                }
            }
            onReleased: {
                var currentTime = (new Date()).getTime()
                var clickedTime = currentTime - pressTime

                if ((clickedTime < buttonTime) || checkable)
                {
                    main.middleButtonReleased()
                    checkable = false
                }
                else
                {
                    checkable = true
                    checked = true
                    longpress = true
                }
            }

            Rectangle {
                anchors.fill: middleButton
                border.color: theme.secondaryColor
                border.width: 2
                radius: middleButton.radius+1
                color: "#00000000"
                z:-1
            }

        }

        Button {
            property variant pressTime
            property bool    longpress : false

            id: rightButton
            width:  (parent.width - parent.spacing*2) / 3
            height: parent.height
            clip: true

            onClicked: {
                if (!checkable)
                {
                    main.rightButtonClicked();
                }
            }
            onPressed: {
                if (!(checkable && checked))
                {
                    main.rightButtonPressed()
                    pressTime = (new Date()).getTime()
                    longpress = false
                }
            }
            onReleased: {
                var currentTime = (new Date()).getTime()
                var clickedTime = currentTime - pressTime

                if ((clickedTime < buttonTime) || checkable)
                {
                    main.rightButtonReleased()
                    checkable = false
                }
                else
                {
                    checkable = true
                    checked = true
                    longpress = true
                }
            }

            Rectangle {
                anchors.fill: rightButton
                border.color: theme.secondaryColor
                border.width: 2
                radius: rightButton.radius+1
                color: "#00000000"
                z:-1
            }
        }
    }
}
