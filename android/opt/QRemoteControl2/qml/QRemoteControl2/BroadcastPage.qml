// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import MyComponents 1.0

Rectangle {
    property bool ballright: false

    signal abortClicked

    id: main
    width: 360
    height: 640
    color: "#00000000"

    Component.onCompleted: {
        client.serverFound.connect(addServer)
        client.serversCleared.connect(clearServers)
    }


    Image {
        id: leftImage
        width: parent.width*0.10
        height: width
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: "images/remote.png"
    }


    Image {
        id: rightImage
        x: 274
        width: parent.width*0.15
        height: width
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 20
        smooth: true
        source: "images/computer.png"
        fillMode: Image.PreserveAspectFit
    }


    Rectangle {
        id: ball
        x: 170
        y: 40
        gradient: master.defaultGradient
        height: width
        radius: width/2
        anchors.verticalCenter: rightImage.verticalCenter
        smooth: true
        border.color: master.border.color
        border.width: 2
        Behavior on x {
            NumberAnimation { easing.type: Easing.Linear; duration: ballTimer.interval-50 }
        }
        Behavior on y {
            NumberAnimation { easing.type: Easing.Linear; duration: ballTimer.interval-50 }
        }
        width: parent.width* 0.04
    }


    Timer {
        id: ballTimer
        interval: 800
        running: true
        repeat: true
        onTriggered: {
            if (!ballright)
            {
                ball.x = rightImage.x-ball.width
                ballright = true
            }
            else
            {
                ball.x = leftImage.x+leftImage.width
                ballright = false
            }
        }
    }


    Button {
            id: exitButton
            height: parent.height * 0.08
            text: "Abort"
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            font.bold: true
            font.pixelSize: master.textSize2
            defaultGradient: master.defaultGradient
            pressedGradient: master.pressedGradient
            hoveredGradient: master.hoveredGradient
            border.color: master.border.color
            textColor: master.textColor1
            onClicked: abortClicked()
    }


        Rectangle {
            id: listRect
            color: "#ffffff"
            radius: 11
            border.color: master.border.color
            border.width: 2
            smooth: true
            gradient: master.defaultGradient
            anchors.top: rightImage.bottom
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: exitButton.top
            anchors.bottomMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10

            ListView {
                id: listVew
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
                anchors.topMargin: 5
                anchors.fill: parent
                delegate: Button {
                    height: 50
                    width: listVew.width
                    radius: 8
                    border.width: 1
                    border.color: master.border.color
                    defaultGradient: master.defaultGradient
                    pressedGradient: master.pressedGradient
                    hoveredGradient: master.hoveredGradient

                    Row {
                        id: row1
                        x: 10
                        spacing: 20
                        height: parent.height
                        Image {
                            width: 40
                            height: 40
                            source: "images/computer.png"
                            fillMode: Image.PreserveAspectFit
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Text {
                            text: hostName //+ ", Connected: " + (connected?"Yes":"No")
                            anchors.verticalCenter: parent.verticalCenter
                            font.bold: true
                            font.pixelSize: master.textSize2
                            color: master.textColor1
                        }
                    }

                    onClicked: {
                        loadingPage.showNormalText()
                        client.connectToServer(index)
                    }

                }
                model: ListModel {
                    id: listModel
                    ListElement {
                        hostName: "10.0.0.1"
                        connected: true
                    }
                }
            }
        }

        function addServer(hostName, connected)
        {
            listModel.append({"hostName":hostName,"connected":connected})
        }

        function clearServers()
        {
            listModel.clear()
        }
        Text {
            id: text1
            width: 179
            height: 27
            text: qsTr("Searching Servers...")
            anchors.bottom: listRect.bottom
            anchors.bottomMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: parent.width * 0.05
            color: master.textColor1
        }
}
