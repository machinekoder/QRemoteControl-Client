// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

 Rectangle {
     id: slider; width: 400; height: 16

     // value is read/write.
     property real value: 1
     property real maximum: 1
     property real minimum: 10
     property int xMax: width - handle.width - 4
     property Gradient defaultGradient: theme.defaultGradient
     property color    borderColor:     theme.buttonBorderColor
     property real     radiusScaler:    theme.radiusScaler
     property Style theme: master.theme

     border.color: theme.buttonBorderColor;
     border.width: theme.borderWidth;
     radius: (width < height)?width/radiusScaler:height/radiusScaler
     gradient: theme.labelGradient

     onValueChanged: updatePos();
     onXMaxChanged: updatePos();
     onMinimumChanged: updatePos();

     function updatePos() {
         if (maximum > minimum) {
             var pos = 2 + (value - minimum) * slider.xMax / (maximum - minimum);
             pos = Math.min(pos, width - handle.width - 2);
             pos = Math.max(pos, 2);
             handle.x = pos;
         } else {
             handle.x = 2;
         }
     }

     Rectangle {
         id: handle;
         y: 2; width: parent.width/8; height: slider.height-4;
         gradient:      defaultGradient
         border.color:  borderColor
         radius:        (width < height)?width/radiusScaler:height/radiusScaler

         MouseArea {
             id: mouse
             anchors.fill: parent; drag.target: parent
             drag.axis: Drag.XAxis; drag.minimumX: 2; drag.maximumX: slider.xMax+2
             onPositionChanged: { value = (maximum - minimum) * (handle.x-2) / slider.xMax + minimum; }
             onClicked: {

             }
         }
     }
 }
