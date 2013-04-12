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
        horizontalAlignment: Text.AlignHCenter
        text: "TEST"
        anchors.bottom: rightImage.top
        anchors.bottomMargin: 30
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: parent.width * 0.05
        color: theme.primaryTextColor
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
        source: master.imagePath + master.iconTheme + "/remote.png"
    }

    Image {
        id: rightImage
        width: parent.width*0.2
        height: width
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        smooth: true
        source: master.imagePath + master.iconTheme + "/computer.png"
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: ball
        gradient: theme.pressedGradient
        width: parent.width * 0.05
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
            height: parent.height * 0.08
            text: qsTr("Abort") + client.emptyString
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
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
        text: qsTr("Errortext") + client.emptyString
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        anchors.top: rightImage.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        font.pixelSize: parent.width * 0.05
        color: theme.primaryTextColor
    }

    function showPasswordText()
    {
        text.text = qsTr("Password Incorrect!") + client.emptyString
        main.status = 1
    }
    function showNormalText()
    {
        text.text = qsTr("Establishing connection to <br>") + connectPage.hostname + "..." + client.emptyString
        main.status = 0
        timeoutText.visible = false
        timeoutTimer.start()
    }
    function showServerText()
    {
        text.text = qsTr("Server trying to connect...") + client.emptyString
        main.status = 2
    }
    function showTimeout()
    {
        timeoutText.visible = true
        if (status == 0)
            timeoutText.text = qsTr("Timeout: Check server address and wireless connection.") + client.emptyString
        else if (status == 1)
            timeoutText.text = qsTr("Change password in advanced tab.") + client.emptyString
        else if (status == 2)
            timeoutText.text = qsTr("Timeout: Check your firewall settings.") + client.emptyString
    }
}
