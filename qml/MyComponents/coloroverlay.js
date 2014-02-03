var myObject

function createColorOverlay() {
    myObject = Qt.createQmlObject("import QtQuick 2.0; import QtGraphicalEffects 1.0;
    ColorOverlay {
        id: overlay
        anchors.fill: image
        source: image
        color: theme.highlightColor
        visible: (checked || (mouseArea.containsMouse && mouseArea.pressed))
    }")
}
