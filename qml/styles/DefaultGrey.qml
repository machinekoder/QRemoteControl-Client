// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "../MyComponents"

Style {
    name:                    qsTr("Grey") + client.emptyString
    themeName:               "grey"
    backgroundImage:         "images/background_grey.png"
    backgroundImageFillMode: Image.Stretch
    iconTheme:               "black"
    defaultGradient:         defaultGrad
    hoveredGradient:         hoveredGrad
    pressedGradient:         pressedGrad
    labelGradient:           labelGrad
    editGradient:            editGrad
    extraGradient:           extraGrad
    buttonBorderColor:       "#999"
    labelBorderColor:        "#00000000"
    editBorderColor:         "#999"
    borderWidth:             2
    radiusScaler:            6
    buttonFontBold:          true
    labelFontBold:           true
    editFontBold:            false
    hintFontBold:            false
    fontFamily:              "Arial"
    fontFamilyHeadig:        "Arial"
    primaryColor:            "black"
    secondaryColor:          "black"
    highlightColor:          "blue"
    secondaryHighlightColor: "grey"
    fontSizeExtraLarge:       master.width * 0.08
    fontSizeExtraSmall:       master.width * 0.02
    fontSizeHuge:             master.width * 0.07
    fontSizeLarge:            master.width * 0.06
    fontSizeMedium:           master.width * 0.05
    fontSizeSmall:            master.width * 0.04
    fontSizeTiny:             master.width * 0.03
    paddingSmall:             master.generalMargin*0.5
    paddingMedium:            master.generalMargin
    paddingLarge:             master.generalMargin*1.5

    Gradient {
                id: defaultGrad
                GradientStop {
                    position: 0
                    color: "#fff"
                }
                GradientStop {
                    position: 1
                    color: "#888"
                }
                }
    Gradient {
                id: hoveredGrad
                GradientStop {
                    position: 0
                    color: "#bbb"
                }
                GradientStop {
                    position: 1
                    color: "#777"
                }
                }
    Gradient {
                id: pressedGrad
                GradientStop {
                    position: 0
                    color: "#fff"
                }
                GradientStop {
                    position: 1
                    color: "#ddd"
                }
                }
    Gradient {
                id: labelGrad
                    GradientStop {
                        position: 0
                        color: "#00000000"
                    }

                    GradientStop {
                        position: 1
                        color: "#00000000"
                    }
                }
    Gradient {
                id: editGrad
                    GradientStop {
                        position: 0
                        color: "#fefdfd"
                    }

                    GradientStop {
                        position: 1
                        color: "#f4f5f5"
                    }
                }
    Gradient {
                 id: extraGrad
                 GradientStop {
                     position: 0
                     color: "#a6a6a6"
                 }

                 GradientStop {
                     position: 0.08
                     color: "#7f7f7f"
                 }

                 GradientStop {
                     position: 0.39999
                     color: "#717171"
                 }

                 GradientStop {
                     position: 0.4
                     color: "#626262"
                 }

                 GradientStop {
                     position: 0.9
                     color: "#4c4c4c"
                 }

                 GradientStop {
                     position: 1
                     color: "#333333"
                 }
                }
    }
