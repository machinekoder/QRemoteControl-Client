// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "../MyComponents"

Style {
    name:                    qsTr("Green") + client.emptyString
    themeName:               "green"
    backgroundImage:         "images/background_green.png"
    backgroundImageFillMode: Image.Stretch
    iconTheme:               "black"
    defaultGradient:         defaultGrad
    hoveredGradient:         hoveredGrad
    pressedGradient:         pressedGrad
    labelGradient:           labelGrad
    editGradient:            editGrad
    extraGradient:           extraGrad
    buttonBorderColor:       "#84ff00"
    labelBorderColor:        "#00000000"
    editBorderColor:         "#84ff00"
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
    highlightColor:          "#3D6C00"
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
                    color: "#c1db9d"
                }

                GradientStop {
                    position: 1
                    color: "#78d300"
                }
                }
    Gradient {
                id: hoveredGrad
                GradientStop {
                    position: 0
                    color: "#A3B884"
                }

                GradientStop {
                    position: 1
                    color: "#5EA600"
                }
                }
    Gradient {
                id: pressedGrad
                GradientStop {
                    position: 0
                    color: "#A3B884"
                }

                GradientStop {
                    position: 1
                    color: "#5EA600"
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
                     color: "#4aa81f"
                 }

                 GradientStop {
                     position: 0.080
                     color: "#338017"
                 }

                 GradientStop {
                     position: 0.390
                     color: "#177316"
                 }

                 GradientStop {
                     position: 0.410
                     color: "#12641d"
                 }

                 GradientStop {
                     position: 0.900
                     color: "#11470d"
                 }

                 GradientStop {
                     position: 1
                     color: "#0a3109"
                 }
                }
    }
