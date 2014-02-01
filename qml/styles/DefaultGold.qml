// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "../MyComponents"

Style {
    name:                    qsTr("Gold") + client.emptyString
    themeName:               "gold"
    backgroundImage:         "images/background_gold.png"
    backgroundImageFillMode: Image.Stretch
    iconTheme:               "black"
    defaultGradient:         defaultGrad
    hoveredGradient:         hoveredGrad
    pressedGradient:         pressedGrad
    labelGradient:           labelGrad
    editGradient:            editGrad
    extraGradient:           extraGrad
    buttonBorderColor:       "#ffb300"
    labelBorderColor:        "#00000000"
    editBorderColor:         "#ffb300"
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
    highlightColor:          "#6C4400"
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
                    color: "#f79d00"
                }

                GradientStop {
                    position: 0.400
                    color: "#ffd475"
                }

                GradientStop {
                    position: 1
                    color: "#ec9e18"
                }
                }
    Gradient {
                id: hoveredGrad
                GradientStop {
                    position: 0
                    color: "#e79200"
                }

                GradientStop {
                    position: 0.400
                    color: "#e6bf69"
                }

                GradientStop {
                    position: 1
                    color: "#d28a15"
                }
                }
    Gradient {
                id: pressedGrad
                GradientStop {
                    position: 0
                    color: "#e79200"
                }

                GradientStop {
                    position: 0.400
                    color: "#e6bf69"
                }

                GradientStop {
                    position: 1
                    color: "#d28a15"
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
                     color: "#c2b367"
                 }

                 GradientStop {
                     position: 0.060
                     color: "#ccc271"
                 }

                 GradientStop {
                     position: 0.380
                     color: "#c6a838"
                 }

                 GradientStop {
                     position: 0.390
                     color: "#b18e2d"
                 }

                 GradientStop {
                     position: 0.900
                     color: "#a0822d"
                 }

                 GradientStop {
                     position: 1
                     color: "#886c1f"
                 }
                }
    }
