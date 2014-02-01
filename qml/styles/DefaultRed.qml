// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "../MyComponents"

Style {
    name:                    qsTr("Red") + client.emptyString
    themeName:               "red"
    backgroundImage:         "images/background_red.png"
    backgroundImageFillMode: Image.Stretch
    iconTheme:               "black"
    defaultGradient:         defaultGrad
    hoveredGradient:         hoveredGrad
    pressedGradient:         pressedGrad
    labelGradient:           labelGrad
    editGradient:            editGrad
    extraGradient:           extraGrad
    buttonBorderColor:       "#ff2e00"
    labelBorderColor:        "#00000000"
    editBorderColor:         "#ff2e00"
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
    highlightColor:          "#880000"
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
                    color: "#db9d9d"
                }

                GradientStop {
                    position: 1
                    color: "#db0b0b"
                }
                }
    Gradient {
                id: hoveredGrad
                GradientStop {
                    position: 0
                    color: "#db3939"
                }

                GradientStop {
                    position: 1
                    color: "#730000"
                }
                }
    Gradient {
                id: pressedGrad
                GradientStop {
                    position: 0
                    color: "#ddc7c2"
                }

                GradientStop {
                    position: 1
                    color: "#d36a6a"
                }
                }
    Gradient {
                id: labelGrad
                GradientStop {
                    position: 0
                    color: "#cc3535"
                }

                GradientStop {
                    position: 1
                    color: "#7c0000"
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
                     color: "#a62828"
                 }

                 GradientStop {
                     position: 0.080
                     color: "#841818"
                 }

                 GradientStop {
                     position: 0.390
                     color: "#711919"
                 }

                 GradientStop {
                     position: 0.410
                     color: "#621212"
                 }

                 GradientStop {
                     position: 0.900
                     color: "#4d0b0b"
                 }

                 GradientStop {
                     position: 1
                     color: "#2f0a0a"
                 }
                }
    }
