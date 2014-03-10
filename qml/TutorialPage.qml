import QtQuick 2.0
import "MyComponents"

Item {
    signal tutorialFinished()
    signal tutorialAborted()

    id: main
    width: 400
    height: 600

    Item {
        id: wrapper
        anchors.fill: parent

        Item {
            id: rotator
            rotation:       master.screenRotation
            width:          ((rotation === 0) || (rotation === 180)) ? parent.width : parent.height
            height:         ((rotation === 0) || (rotation === 180)) ? parent.height : parent.width
            anchors.centerIn: parent

            Behavior on width {
                             enabled: master.state == "tutorialState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                             enabled: master.state == "tutorialState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }

            Button {
                id: previousButton
                anchors.left:       parent.left
                anchors.leftMargin: master.generalMargin
                anchors.top:        parent.top
                anchors.topMargin:  master.generalMargin
                width:              master.buttonHeight
                height:             width
                text:               ""
                icon:               master.imagePath + master.iconTheme + "/left.png"
                rotation:           master.screenRotation
                visible:            tutorialMaster.previousItem !== ""
                onClicked:          tutorialMaster.showPreviousItem()
            }

            Button {
                id: exitButton
                anchors.right:      parent.right
                anchors.rightMargin:master.generalMargin
                anchors.top:        parent.top
                anchors.topMargin:  master.generalMargin
                width:              master.buttonHeight
                height:             width
                text:               ""
                icon:               master.imagePath + master.iconTheme + "/exit.png"
                rotation:           master.screenRotation
                onClicked:          tutorialAborted()
            }

            /*Flickable {
                id: flickable
                anchors {
                    left:           parent.left
                    right:          parent.right
                    top:            exitButton.bottom
                    bottom:         previousButton.top
                    leftMargin:     master.generalMargin*2
                    rightMargin:    master.generalMargin*2
                    topMargin:      master.generalMargin*2
                    bottomMargin:   master.generalMargin
                }
                flickableDirection: Flickable.VerticalFlick
                clip:               true
                contentWidth:       parent.width - master.generalMargin*6
                //contentHeight:    aboutContainer.height + moreText.height + 60
                contentHeight:      height


            }*/

            TutorialMaster {
                id: tutorialMaster
                anchors {
                    left:           parent.left
                    right:          parent.right
                    top:            exitButton.bottom
                    bottom:         parent.bottom
                    leftMargin:     master.generalMargin*2
                    rightMargin:    master.generalMargin*2
                    topMargin:      master.generalMargin*2
                    bottomMargin:   master.generalMargin
                }

                items: [TutorialItem { name: "page1"; previous: ""; source: "tutorial/page1.qml" },
                        TutorialItem { name: "page2"; previous: "page1"; source: "tutorial/page2.qml" }]
            }
        }
    }
}
