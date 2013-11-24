import QtQuick 2.0
import "MyComponents/"

Rectangle {
    signal exitClicked

    id: trialPage
    width: 360
    height: 640
    color: "#00000000"

    Item {
        id: wrapper
        anchors.fill: parent
        anchors.leftMargin:     master.generalMargin
        anchors.bottomMargin:   master.generalMargin
        anchors.topMargin:      master.generalMargin
        anchors.rightMargin:    master.generalMargin

        Item {
            id: rotator
            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent

            Button {
                id:                 exitButton
                width:              master.buttonHeight * 0.7
                height:             width
                text:               ""
                icon:               master.imagePath + master.iconTheme + "/exit.png"
                anchors.right:      parent.right
                anchors.top:        parent.top
                rotation:           master.screenRotation
                onClicked:          Qt.quit()
            }

            Image {
                id:                 logoImg
                source:             "images/qrc_trial.png"
                smooth:             true
                anchors.left:       parent.left
                anchors.top:        parent.top
                width:              master.buttonHeight*2
                height:             width
                sourceSize.width:   width
                sourceSize.height:  height
                fillMode:           Image.PreserveAspectFit
            }

            Item {
                id: aboutContainer

                anchors.left:       parent.left
                anchors.right:      parent.right
                anchors.top:        logoImg.bottom
                anchors.topMargin:  master.generalMargin*3
                anchors.leftMargin: master.generalMargin*2
                anchors.rightMargin: master.generalMargin*2

                Text {
                    text:       qsTr("QRemoteControl Trial has expired!") + client.emptyString
                    id:         aboutText
                    color:      theme.primaryTextColor
                    wrapMode:   Text.WordWrap
                    anchors {
                        left:       parent.left
                        leftMargin: master.generalMargin*2
                        right:      parent.right
                        rightMargin:master.generalMargin*2
                        top:        parent.top
                    }

                    font {
                        pixelSize:  theme.buttonFontSize
                        bold:       theme.buttonFontBold
                    }
                }

                height: aboutText.height
            }

            Text {
                id: moreText
                text: qsTr("Your trial version of QRemoteControl has expired. Get the full version now.") + client.emptyString

                anchors {
                    top: aboutContainer.bottom
                    topMargin: master.generalMargin*2
                    left: parent.left
                    right: parent.right
                    leftMargin: master.generalMargin*2
                    rightMargin: master.generalMargin*2
                }
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                color: theme.primaryTextColor

                font {
                    pixelSize: theme.labelFontSize  //aboutPage.width * 0.025
                }

                onLinkActivated : Qt.openUrlExternally(link);
            }

            Button {
                    id:                 shopButton
                    height:             master.buttonHeight
                    text:               qsTr("Get Full Version") + client.emptyString
                    anchors.right:      parent.right
                    anchors.left:       parent.left
                    anchors.bottom:     parent.bottom
                    icon:               ""

                    onClicked: {
                        if (master.platform === "MeeGo")
                        {
                            Qt.openUrlExternally("http://qremote.org/links/meego.php");
                        }
                        else if (master.platform === "Symbian")
                        {
                            Qt.openUrlExternally("http://qremote.org/links/symbian.php");
                        }
                        else if (master.platform === "Android")
                        {
                            Qt.openUrlExternally("http://qremote.org/links/googleplay.php");
                        }
                        else if (platform.platform === "BlackBerry")
                        {
                            Qt.openUrlExternally("http://qremote.org/links/blackberry.php");
                        }
                        else if (platform.platform === "Simulator")
                        {
                            Qt.openUrlExternally("http://qremote.org/");
                        }
                    }
                }
        }
    }
}
