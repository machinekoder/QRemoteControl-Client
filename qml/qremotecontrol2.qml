import QtQuick 2.0
import Sailfish.Silica 1.0

ApplicationWindow
{
    property int orientationLock: 0

    id: appWindow

    allowedOrientations: Orientation.All

    initialPage: Component {
                    Page {

                        Main { anchors.fill: parent}
                    }
                    }
    cover: Qt.resolvedUrl("sailfish/CoverPage.qml")
}
