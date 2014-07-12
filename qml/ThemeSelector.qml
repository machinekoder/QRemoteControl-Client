import QtQuick 2.0
import "MyComponents"

GridView {
    id: grid1
    cellWidth: width / 4
    cellHeight: master.buttonHeight * 0.8 + master.generalMargin
    height: Math.ceil(count/4)*cellHeight

    model: styleListModel
    delegate: styleButtonDelegate

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

    Component.onCompleted: {
        initThemes()
        loadTimer.start()
    }

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

    ListModel {
         id: styleListModel
    }
}
