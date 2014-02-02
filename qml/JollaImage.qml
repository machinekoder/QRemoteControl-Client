import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    property bool effectEnabled: true
    property alias source: bug.source
    property alias fillMode: bug.fillMode
    property alias blurRadius: blur.radius
    property alias blurSamples: blur.samples
    property alias brightness: brightness.brightness
    property alias patternSize: pyramid.sourceSize.width
    property alias patternOpacity: blend.opacity

    id: main

    Image {
            id: bug
            source: ""
            sourceSize: Qt.size(parent.width, parent.height)
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            smooth: true
            visible: !main.effectEnabled
        }

    GaussianBlur {
        id: blur
        anchors.fill: bug
        source: bug
        radius: 32
        samples: 16
        transparentBorder: false
        visible: main.effectEnabled
    }

    BrightnessContrast {
            id: brightness
            anchors.fill: blur
            source: blur
            brightness: -0.5
            visible: main.effectEnabled
        }

    Image {
            id: pyramid
            source: "images/jolla_pyramid.png"
            sourceSize.width: 24
            anchors.fill: bug
            fillMode: Image.Tile
            smooth: true
            visible: false
        }

    Blend {
           id: blend
           anchors.fill: brightness
           source: brightness
           foregroundSource: pyramid
           mode: "softLight"
           visible: main.effectEnabled
           opacity: 0.2

           /*
             addition
             average
             colorDodge
             screen
             softLight
             */
       }
}
