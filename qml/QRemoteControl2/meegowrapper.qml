import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow

    initialPage: mainPage

    Page {
        id: mainPage
        orientationLock: PageOrientation.LockPortrait

        Main {
            anchors.fill: parent
        }
    }
}
