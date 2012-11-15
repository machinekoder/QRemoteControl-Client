// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "MyComponents/"
//import MyComponents 1.0

Rectangle {
    property int status: 0
    property bool ballright: false

    signal abortClicked

    id: main
    width: 360
    height: 640
    color: "#00000000"

    Component.onCompleted: {
        client.passwordIncorrect.connect(showPasswordText)
        client.serverConnecting.connect(showServerText)
    }

    Text {
        id: text
        width: 223
        height: 23
        text: qsTr("Establishing connection...")
        anchors.bottom: rightImage.top
        anchors.bottomMargin: 30
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: parent.width * 0.05
        color: master.textColor1
    }

    Image {
        id: leftImage
        y: 258
        width: parent.width*0.15
        height: width
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        fillMode: Image.PreserveAspectFit
        smooth: true
        source: "images/remote.png"
    }

    Image {
        id: rightImage
        width: parent.width*0.2
        height: width
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        smooth: true
        source: "images/computer.png"
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: ball
        gradient: master.defaultGradient
        width: 19
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
        text: qsTr("Errortext")
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        anchors.top: rightImage.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        font.pixelSize: parent.width * 0.05
        color: master.textColor1
    }

    function showPasswordText()
    {
        text.text = qsTr("Password Incorrect!")
        main.status = 1
    }
    function showNormalText()
    {
        text.text = qsTr("Establishing connection...")
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
