import QtQuick 1.1
import "MyComponents/"

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
        source: master.imagePath + master.iconTheme + "/remote.png"
        rotation: master.screenRotation

        Behavior on rotation {
                         enabled: master.state == "broadcastState"
                         NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                     }
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
        source: master.imagePath + master.iconTheme + "/computer.png"
        fillMode: Image.PreserveAspectFit
        rotation: master.screenRotation

        Behavior on rotation {
                         enabled: master.state == "broadcastState"
                         NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                     }
    }


    Rectangle {
        id: ball
        x: 170
        y: 40
        gradient: theme.pressedGradient
        height: width
        radius: width/2
        anchors.verticalCenter: rightImage.verticalCenter
        smooth: true
        border.color: theme.buttonBorderColor
        border.width: 2
        Behavior on x {
            NumberAnimation { easing.type: Easing.Linear; duration: ballTimer.interval-50 }
        }
        Behavior on y {
            NumberAnimation { easing.type: Easing.Linear; duration: ballTimer.interval-50 }
        }
        width: parent.width * 0.04
    }


    Timer {
        id: ballTimer
        interval: 800
        running: true//master.state == "broadcastState"
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


    Item {
        id: wrapper
        anchors.top: rightImage.bottom
        anchors.topMargin: master.generalMargin
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Item {
            id: rotator
            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent

            Behavior on width {
                             enabled: master.state == "broadcastState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                             enabled: master.state == "broadcastState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }

            Button {
                    id: exitButton
                    height: master.buttonHeight * 0.8
                    text: qsTr("Abort") + client.emptyString
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: master.generalMargin
                    onClicked: abortClicked()
            }

            Rectangle {
                id: listRect
                radius: exitButton.radius
                border.color: theme.buttonBorderColor
                border.width: 2
                smooth: true
                gradient: theme.defaultGradient
                anchors.top: parent.top
                anchors.topMargin: master.generalMargin
                anchors.right: parent.right
                anchors.rightMargin: master.generalMargin
                anchors.bottom: exitButton.top
                anchors.bottomMargin: master.generalMargin
                anchors.left: parent.left
                anchors.leftMargin: master.generalMargin

                ListView {
                    id: listVew
                    anchors.fill: parent
                    clip: true

                    delegate: Item {
                            height: master.buttonHeight
                            width: listVew.width

                            Button {
                            anchors.fill:           parent
                            anchors.leftMargin:     master.generalMargin/2
                            anchors.rightMargin:    master.generalMargin/2
                            anchors.topMargin:      master.generalMargin/2
                            border.color: theme.buttonBorderColor

                            Row {
                                id: row1
                                x: master.generalMargin
                                spacing: master.generalMargin*2
                                height: parent.height
                                Image {
                                    width: parent.height * 0.8
                                    height: width
                                    source: master.imagePath + master.iconTheme + "/computer.png"
                                    fillMode: Image.PreserveAspectFit
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                Text {
                                    text: hostName //+ ", Connected: " + (connected?"Yes":"No")
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.bold: theme.buttonFontBold
                                    font.pixelSize: theme.buttonFontSize
                                    font.family: theme.fontFamily
                                    color: theme.primaryTextColor
                                }
                            }

                            onReleased: {
                                loadingPage.showNormalText()
                                client.connectToServer(index)
                            }

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

                Text {
                    id: text1
                    text: qsTr("Searching Servers...") + client.emptyString
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: master.generalMargin
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: theme.labelFontSize
                    font.bold: theme.labelFontBold
                    color: theme.primaryTextColor
                }
            }

        }
    }
    function addServer(ipAddress,hostName, connected)
    {
        listModel.append({"hostName":hostName,"connected":connected})
    }

    function clearServers()
    {
        listModel.clear()
    }
}
