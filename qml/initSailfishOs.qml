import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow
{
    id: appWindow

    initialPage: Component { Page { Main { anchors.fill: parent}} }
    cover: Qt.resolvedUrl("sailfish/CoverPage.qml")
}
