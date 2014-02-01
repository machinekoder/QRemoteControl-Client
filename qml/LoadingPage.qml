import QtQuick 2.0
import "MyComponents/"

Item {
    property int status: 0
    property bool ballright: false

    signal abortClicked

    id: main
    width: 360
    height: 640

    Component.onCompleted: {
        client.passwordIncorrect.connect(showPasswordText)
        client.serverConnecting.connect(showServerText)
    }

    Item {
        id: wrapper
        anchors.fill: parent
        anchors.leftMargin: master.generalMargin
        anchors.rightMargin: master.generalMargin
        anchors.topMargin: master.generalMargin
        anchors.bottomMargin: master.generalMargin

        Item {
            id: rotator
            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent

            Behavior on width {
                             enabled: master.state == "loadingState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                             enabled: master.state == "loadingState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }

            Text {
                id: text
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                text: "TEST"
                anchors.bottom: rightImage.top
                anchors.bottomMargin:  master.generalMargin*2
                anchors.left: parent.left
                anchors.leftMargin: master.generalMargin
                anchors.right: parent.right
                anchors.rightMargin: master.generalMargin
                font.pixelSize: theme.fontSizeSmall
                color: theme.primaryColor
            }

            Image {
                id: leftImage
                width: parent.width*0.15
                height: width
                anchors.left: parent.left
                anchors.leftMargin: master.generalMargin*2
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                smooth: true
                source: master.imagePath + master.iconTheme + "/remote.png"
            }

            Image {
                id: rightImage
                width: parent.width*0.2
                height: width
                anchors.right: parent.right
                anchors.rightMargin: master.generalMargin*2
                anchors.verticalCenter: parent.verticalCenter
                smooth: true
                source: master.imagePath + master.iconTheme + "/computer.png"
                fillMode: Image.PreserveAspectFit
            }

            Rectangle {
                id: ball
                color: theme.primaryColor
                width: parent.width * 0.05
                height: width
                radius: width/2
                anchors.verticalCenter: rightImage.verticalCenter
                smooth: true
                border.color: theme.primaryColor
                border.width: theme.borderWidth
                Behavior on x {
                    NumberAnimation { easing.type: Easing.Linear; duration: ballTimer.interval-50 }
                }
                Behavior on y {
                    NumberAnimation { easing.type: Easing.Linear; duration: ballTimer.interval-50 }
                }
            }

            Timer {
                id: ballTimer
                interval: 800
                running: true//master.state == "loadingState"
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
                    height: master.buttonHeight * 0.8
                    text: qsTr("Abort") + client.emptyString
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    onClicked: abortClicked()
            }

            Timer {
                id: timeoutTimer
                interval: 5000
                repeat: false
                running: false
                onTriggered: showTimeout()
            }
            Text {
                id: timeoutText
                text: "Errortext"
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                anchors.top: rightImage.bottom
                anchors.topMargin: master.generalMargin*2
                anchors.right: parent.right
                anchors.rightMargin: master.generalMargin
                anchors.left: parent.left
                anchors.leftMargin: master.generalMargin
                font.pixelSize: theme.fontSizeSmall
                color: theme.primaryColor
            }

        }
    }

    function showPasswordText()
    {
        text.text = qsTr("Password Incorrect!")
        main.status = 1
    }
    function showNormalText()
    {
        text.text = qsTr("Establishing connection to <br>") + connectPage.hostname + "..."
        main.status = 0
        timeoutText.visible = false
        timeoutTimer.start()
    }
    function showServerText()
    {
        text.text = qsTr("Server trying to connect...")
        main.status = 2
    }
    function showTimeout()
    {
        timeoutText.visible = true
        if (status == 0)
            timeoutText.text = qsTr("Timeout: Check server address and wireless connection.")
        else if (status == 1)
            timeoutText.text = qsTr("Change password in advanced tab.")
        else if (status == 2)
            timeoutText.text = qsTr("Timeout: Check your firewall settings.")
    }
}
