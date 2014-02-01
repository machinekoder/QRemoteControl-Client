// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "../MyComponents"

Style {
    name:                   qsTr("Blue") + client.emptyString
    themeName:              "blue"
    backgroundImage:        "images/background_blue.png"
    backgroundImageFillMode: Image.Stretch
    iconTheme:               "black"
    defaultGradient:         defaultGrad
    hoveredGradient:         hoveredGrad
    pressedGradient:         pressedGrad
    labelGradient:           labelGrad
    editGradient:            editGrad
    extraGradient:           extraGrad
    buttonBorderColor:       "#009dff"
    labelBorderColor:        "#00000000"
    editBorderColor:         "#009dff"
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
                    color: "#9dd0db"
                }

                GradientStop {
                    position: 1
                    color: "#0078d3"
                }
                }
    Gradient {
                id: hoveredGrad
                GradientStop {
                    position: 0
                    color: "#80b1bb"
                }

                GradientStop {
                    position: 1
                    color: "#00497e"
                }
                }
    Gradient {
                id: pressedGrad
                GradientStop {
                    position: 0
                    color: "#cbedf3"
                }

                GradientStop {
                    position: 1
                    color: "#4694cc"
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
                     color: "#1f43a8"
                 }

                 GradientStop {
                     position: 0.080
                     color: "#173382"
                 }

                 GradientStop {
                     position: 0.390
                     color: "#1b3375"
                 }

                 GradientStop {
                     position: 0.440
                     color: "#162764"
                 }

                 GradientStop {
                     position: 0.900
                     color: "#0e2649"
                 }

                 GradientStop {
                     position: 1
                     color: "#09203a"
                 }
                }
    }
