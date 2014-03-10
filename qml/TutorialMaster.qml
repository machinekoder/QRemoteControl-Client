import QtQuick 2.0

Item {
    property list<TutorialItem> items
    property string previousItem: ""
    property string currentItem: ""
    property variant loadingItem
    signal tutorialFinished()
    signal tutorialAborted()

    id: main
    width: 400
    height: 600

    Flickable {
        id: flickable
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        clip: true
        contentWidth: parent.width
        contentHeight: contentLoader.height

        Loader {
            id: contentLoader
            anchors.left:   parent.left
            anchors.right:  parent.right

            Behavior on opacity { NumberAnimation{ duration: 150}}
        }
    }

    Timer {
        id: loadTimer
        running: false
        repeat: false
        interval: 150
        onTriggered: {
            contentLoader.opacity = 1.0
            contentLoader.source = loadingItem.source
            main.previousItem = loadingItem.previous
            main.currentItem = loadingItem.name
        }
    }

    Component.onCompleted: {
        loadItem(items[0])
    }

    function showItem(name)
    {
        var i
        for (i = 0; i < items.length; ++i)
        {
            if (items[i].name === name)
            {
                loadItem(items[i])
                return
            }
        }
    }
    function showPreviousItem()
    {
        showItem(main.previousItem)
    }

    function loadItem(item)
    {
        loadingItem = item
        contentLoader.opacity = 0.0
        loadTimer.start()
    }
}
