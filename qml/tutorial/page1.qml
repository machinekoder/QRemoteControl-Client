import QtQuick 2.0
import QtMultimedia 5.0
import "../MyComponents"

Item {
    id: main

    width: 100
    height: image.height + exitButton.height + master.generalMargin*2

    /*Video {
        source: "browser_qremote.mp4"
        autoPlay: true
        onStopped: play()
        width: parent.width
        //height: 100
        height: 200
        onErrorStringChanged: console.log(errorString)
    }*/
    AnimatedImage {
        id: image
        anchors.left:   parent.left
        anchors.right:  parent.right
        height:         master.buttonHeight*2.5
        playing:        true
        source:         "browser_qremote.gif"
        fillMode:       Image.PreserveAspectFit
    }

    Text {
        id: tutorialText
        anchors {
            top: image.bottom
            topMargin: master.generalMargin*2
            left: parent.left
            right: parent.right
        }
        text: "<html><head><style>a:link{color:" + theme.highlightColor + "} a:visited{color:" + theme.highlightColor + "}</style></head><body>" +
              qsTr("Start the web-browser on your desktop computer and open the website of the qremote project: <a href=\"http://qremote.org/download.php#Download\">qremote.org</a>")
        wrapMode: Text.WordWrap
        textFormat: Text.RichText
        color: theme.primaryColor
        font.pixelSize: theme.fontSizeSmall

        onLinkActivated : Qt.openUrlExternally(link);
    }

    Button {
            id: exitButton
            height: master.buttonHeight * 0.8
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: tutorialText.bottom
            anchors.margins: master.generalMargin
            text: qsTr("Continue") + client.emptyString
            icon: ""
            onClicked: showItem("page2")//main.parent.parent.parent.showItem("page2")
        }

    function showItem(name)
    {
        main.parent.parent.parent.parent.showItem(name)
    }
}
