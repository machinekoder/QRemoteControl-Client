import QtQuick 2.0
import "MyComponents/"

import "styles" as Styles

Item {
    id: main
    width: 400
    height: 600

    signal continueClicked

    Timer {
        id: loadTimer
        interval: 100
        repeat: false
        running: false
        onTriggered: {
            var roundness = client.uiRoundness;
            var found = false

            console.log("count: " + grid1.count)

            for(var i = 0; i < grid1.count ; i++) {
                grid1.currentIndex = i
                if (grid1.currentItem.themeName === client.uiColor)
                {
                    grid1.currentItem.clicked()
                    found = true
                    break
                }
            }

            if ((!found) && (grid1.count > 0))   // if theme was not found load first one
            {
                grid1.currentIndex = 0
                grid1.currentItem.clicked()
            }

            theme.radiusScaler = roundness
            roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
        }
    }

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
                             enabled: master.state == "settingsState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }
            Behavior on height {
                             enabled: master.state == "settingsState"
                             NumberAnimation { easing.type: Easing.OutCubic; duration: 300 }
                         }

            Flickable {
                id: flicker
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: exitButton.top
                anchors.bottomMargin: master.generalMargin
                contentHeight: master.buttonHeight * 12
                contentWidth: width
                flickableDirection: Flickable.VerticalFlick
                clip: true

                Label {
                    id: label1
                    text: qsTr("Color:") + client.emptyString
                    height: master.buttonHeight * 0.7
                    anchors.top: languageButtons.bottom
                    anchors.topMargin: master.generalMargin
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                }

               Label {
                    id: label2
                    text: qsTr("Roundness:") + client.emptyString
                    height: master.buttonHeight * 0.7
                    anchors.top: grid1.bottom
                    anchors.topMargin: master.generalMargin
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                }

               Slider {
                   id: roundnessSlider
                   anchors.top: label2.bottom
                   anchors.topMargin: master.generalMargin
                   anchors.right: parent.right
                   anchors.rightMargin: master.generalMargin
                   anchors.left: parent.left
                   anchors.leftMargin: master.generalMargin

                   height: master.buttonHeight*0.7

                   minimum: 2
                   maximum: 20

                   onValueChanged: {
                       theme.radiusScaler = maximum-value
                       client.uiRoundness = theme.radiusScaler
                   }
               }

               Label {
                    id: label3
                    text: qsTr("Orientation Lock:") + client.emptyString
                    height: master.buttonHeight * 0.7
                    anchors.top: parent.top
                    anchors.topMargin: master.generalMargin
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                }

               Item {
                   id: orientationLockButtons
                   anchors.top:                 label3.bottom
                   anchors.topMargin:           master.generalMargin
                   anchors.horizontalCenter:    parent.horizontalCenter
                   width:                       master.buttonHeight * 0.9 * 5 + 4 * master.generalMargin
                   height:                      master.buttonHeight*0.9
                   Button {
                       id:              noLockButton
                       checkable:       true
                       width:           master.buttonHeight * 0.9
                       height:          width
                       text:            ""
                       icon:            master.imagePath + master.iconTheme + "/exit.png"
                       anchors.top:     parent.top
                       anchors.left:    parent.left
                       onClicked: {
                           if (!checked)
                           {
                               portraitLockButton.checked = false
                               reversePortraitLockButton.checked = false
                               landscapeLockButton.checked = false
                               reverseLandcapeLockButton.checked = false

                               client.screenOrientation = 0
                           }
                           else
                               checked = false
                       }
                   }

                   Button {
                       id:                  portraitLockButton
                       checkable:           true
                       width:               master.buttonHeight * 0.9
                       height:              width
                       text:                ""
                       icon:                master.imagePath + master.iconTheme + "/up.png"
                       anchors.top:         parent.top
                       anchors.left:        noLockButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               noLockButton.checked = false
                               reversePortraitLockButton.checked = false
                               landscapeLockButton.checked = false
                               reverseLandcapeLockButton.checked = false

                               client.screenOrientation = 1
                               master.screenRotation = 0
                               if (!device.landscapeMode)
                                    master.screenRotation += 90
                           }
                           else
                               checked = false
                       }
                   }

                   Button {
                       id:                  reversePortraitLockButton
                       checkable:           true
                       width:               master.buttonHeight * 0.9
                       height:              width
                       text:                ""
                       icon:                master.imagePath + master.iconTheme + "/down.png"
                       anchors.top:         parent.top
                       anchors.left:        portraitLockButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               portraitLockButton.checked = false
                               noLockButton.checked = false
                               landscapeLockButton.checked = false
                               reverseLandcapeLockButton.checked = false

                               client.screenOrientation = 2
                               master.screenRotation = 180
                               if (!device.landscapeMode)
                                    master.screenRotation += 90
                           }
                           else
                               checked = false
                       }
                   }

                   Button {
                       id:                  landscapeLockButton
                       checkable:           true
                       width:               master.buttonHeight * 0.9
                       height:              width
                       text:                ""
                       icon:                master.imagePath + master.iconTheme + "/right.png"
                       anchors.top:         parent.top
                       anchors.left:        reversePortraitLockButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               portraitLockButton.checked = false
                               reversePortraitLockButton.checked = false
                               noLockButton.checked = false
                               reverseLandcapeLockButton.checked = false

                               client.screenOrientation = 3
                               master.screenRotation = 90
                               if (!device.landscapeMode)
                                    master.screenRotation += 90
                           }
                           else
                               checked = false
                       }
                   }

                   Button {
                       id:                  reverseLandcapeLockButton
                       checkable:           true
                       width:               master.buttonHeight * 0.9
                       height:              width
                       text:                ""
                       icon:                master.imagePath + master.iconTheme + "/left.png"
                       anchors.top:         parent.top
                       anchors.left:        landscapeLockButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               portraitLockButton.checked = false
                               reversePortraitLockButton.checked = false
                               landscapeLockButton.checked = false
                               noLockButton.checked = false

                               client.screenOrientation = 4
                               master.screenRotation = -90
                               if (!device.landscapeMode)
                                    master.screenRotation += 90
                           }
                           else
                               checked = false
                       }
                   }
               }

               Label {
                    id: label4
                    text: qsTr("Language:") + client.emptyString
                    height: master.buttonHeight * 0.7
                    anchors.top: orientationLockButtons.bottom
                    anchors.topMargin: master.generalMargin
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                }

               Item {
                   id: languageButtons
                   anchors.top:                 label4.bottom
                   anchors.topMargin:           master.generalMargin
                   anchors.horizontalCenter:    parent.horizontalCenter
                   width:                       master.buttonHeight * 0.9 * 5 + 4 * master.generalMargin
                   height: englishButton.height

                   Button {
                       id:              englishButton
                       checkable:       true
                       width:           master.buttonHeight * 0.9
                       height:          width
                       text:            ""
                       icon:            master.imagePath + "lang/english.png"
                       anchors.top:     parent.top
                       anchors.left:    parent.left
                       onClicked: {
                           if (!checked)
                           {
                               spanishButton.checked = false
                               germanButton.checked = false
                               russianButton.checked = false
                               ukrainianButton.checked = false

                               client.language = "en"
                           }
                           else
                               checked = false
                       }
                   }
                   Button {
                       id:              spanishButton
                       checkable:       true
                       width:           master.buttonHeight * 0.9
                       height:          width
                       text:            ""
                       icon:            master.imagePath + "lang/spanish.png"
                       anchors.top:     parent.top
                       anchors.left:    englishButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               englishButton.checked = false
                               germanButton.checked = false
                               russianButton.checked = false
                               ukrainianButton.checked = false

                               client.language = "es"
                           }
                           else
                               checked = false
                       }
                   }
                   Button {
                       id:              germanButton
                       checkable:       true
                       width:           master.buttonHeight * 0.9
                       height:          width
                       text:            ""
                       icon:            master.imagePath + "lang/german.png"
                       anchors.top:     parent.top
                       anchors.left:    spanishButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               spanishButton.checked = false
                               englishButton.checked = false
                               russianButton.checked = false
                               ukrainianButton.checked = false

                               client.language = "de"
                           }
                           else
                               checked = false
                       }
                   }
                   Button {
                       id:              russianButton
                       checkable:       true
                       width:           master.buttonHeight * 0.9
                       height:          width
                       text:            ""
                       icon:            master.imagePath + "lang/russian.png"
                       anchors.top:     parent.top
                       anchors.left:    germanButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               spanishButton.checked = false
                               germanButton.checked = false
                               englishButton.checked = false
                               ukrainianButton.checked = false

                               client.language = "ru"
                           }
                           else
                               checked = false
                       }
                   }
                   Button {
                       id:              ukrainianButton
                       checkable:       true
                       width:           master.buttonHeight * 0.9
                       height:          width
                       text:            ""
                       icon:            master.imagePath + "lang/ukrainian.png"
                       anchors.top:     parent.top
                       anchors.left:    russianButton.right
                       anchors.leftMargin:  master.generalMargin
                       onClicked: {
                           if (!checked)
                           {
                               spanishButton.checked = false
                               germanButton.checked = false
                               russianButton.checked = false
                               englishButton.checked = false

                               client.language = "uk"
                           }
                           else
                               checked = false
                       }
                   }

                }

               ListModel {
                    id: styleListModel
               }

                GridView {
                    id: grid1
                    cellWidth: width / 4
                    cellHeight: master.buttonHeight * 0.8 + master.generalMargin
                    anchors.top: label1.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.margins: master.generalMargin
                    height: Math.ceil(count/4)*cellHeight

                    model: styleListModel
                    delegate: styleButtonDelegate

                    Component.onCompleted: {
                        initThemes()
                        loadTimer.start()
                    }

                    Component {
                        id: styleButtonDelegate

                        Item {
                            property string themeName: loadedTheme.item.themeName
                            signal clicked

                            width: grid1.cellWidth - master.generalMargin
                            height: grid1.cellHeight - master.generalMargin

                            onClicked: button.click()
                            JollaImage {
                                anchors.fill: parent
                                fillMode: Image.Tile
                                source: loadedTheme.item.backgroundImage
                                effectEnabled: loadedTheme.item.backgroundImageEffect
                                visible: effectEnabled
                            }

                            Button {
                                id: button

                                visible:  loadedTheme.item.themeName !== null
                                anchors.fill: parent
                                theme: loadedTheme.item
                                text: loadedTheme.item.name
                                onClicked: {
                                    master.theme.load(loadedTheme.item)
                                    roundnessSlider.value = roundnessSlider.maximum-theme.radiusScaler
                                    master.backgroundImage = loadedTheme.item.backgroundImage
                                    master.color = loadedTheme.item.backgroundColor
                                    master.iconTheme = loadedTheme.item.iconTheme
                                    client.uiColor = loadedTheme.item.themeName
                                    master.loadBackgroundImage(loadedTheme.item.backgroundImage,
                                                               loadedTheme.item.backgroundImageEffect,
                                                               loadedTheme.item.backgroundImageFillMode)
                                }
                            }

                            Loader {
                                id: loadedTheme
                                source: "styles" + "/" + fileName
                                Component.onCompleted: console.log(fileName)
                            }
                        }
                    }
                }
            }
            Button {
                    id: exitButton
                    height: master.buttonHeight * 0.8
                    text: qsTr("Continue") + client.emptyString
                    anchors.right: parent.right
                    anchors.rightMargin: master.generalMargin
                    anchors.left: parent.left
                    anchors.leftMargin: master.generalMargin
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: master.generalMargin
                    icon: ""
                    onClicked: continueClicked()
                }
        }
    }

    function setScreenOrientation(screenOrientation)
    {
        noLockButton.checked = false
        portraitLockButton.checked = false
        reversePortraitLockButton.checked = false
        landscapeLockButton.checked = false
        reverseLandcapeLockButton.checked = false

        switch (screenOrientation)
        {
            case 0: noLockButton.checked = true
                break
            case 1: portraitLockButton.checked = true
                master.screenRotation = 0
                break
            case 2: reversePortraitLockButton.checked = true
                master.screenRotation = 180
                break
            case 3: landscapeLockButton.checked = true
                master.screenRotation = 90
                break
            case 4: reverseLandcapeLockButton.checked = true
                master.screenRotation = -90
                break
        }

        if (!device.landscapeMode)
             master.screenRotation += 90
    }

    function setLanguage(language)
    {
        englishButton.checked   = false
        spanishButton.checked   = false
        germanButton.checked    = false
        russianButton.checked   = false
        ukrainianButton.checked = false

        switch (language)
        {
            case "en": englishButton.checked = true
                    break
            case "es": spanishButton.checked = true
                    break
            case "de": germanButton.checked = true
                    break
            case "ru": russianButton.checked = true
                    break
            case "uk": ukrainianButton.checked = true
                    break
        }
    }

    function initThemes()
    {
        console.log("init themes")

        styleListModel.append({"fileName": "DefaultBlack.qml" })
        styleListModel.append({"fileName": "DefaultBlue.qml" })
        styleListModel.append({"fileName": "DefaultGold.qml" })
        styleListModel.append({"fileName": "DefaultGreen.qml" })
        styleListModel.append({"fileName": "DefaultGrey.qml" })
        styleListModel.append({"fileName": "DefaultPink.qml" })
        styleListModel.append({"fileName": "DefaultRed.qml" })
        styleListModel.append({"fileName": "DefaultSilver.qml" })
        styleListModel.append({"fileName": "DefaultWhite.qml" })

        if ((master.platform === "SailfishOS"))
        {
            styleListModel.append({"fileName": "SailfishAmbience.qml"})

        }
        else
        {
            styleListModel.append({"fileName": "FancyBlack.qml" })
            styleListModel.append({"fileName": "FancyBlue.qml" })
            styleListModel.append({"fileName": "FancyBrown.qml" })
            styleListModel.append({"fileName": "FancyGreen.qml" })
            styleListModel.append({"fileName": "FancyPink.qml" })
            styleListModel.append({"fileName": "FancyRed.qml" })
            styleListModel.append({"fileName": "FancyYellow.qml" })

            if (!((master.platform === "Android") || (master.platform === "iOS")))
            {
                styleListModel.append({"fileName":"AlphaNerdy.qml" })
                styleListModel.append({"fileName": "AlphaTech.qml" })
            }
        }

        console.log("init themes end")
    }

    function removeThemes(filter)
    {
        for (i = styleListModel.count(); i >= 0; --i)
        {
            if (styleListModel.get(i).fileName.indexOf(filter) === 0)
            {
                styleListModel.remove()
            }
        }
    }
}


