// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "../MyComponents"

Style {
    name:                    qsTr("Tech") + client.emptyString
    themeName:               "tech"
    backgroundImage:         "images/tile.png"
    backgroundImageFillMode: Image.Tile
    iconTheme:               "white2"
    defaultGradient:         defaultGrad
    hoveredGradient:         hoveredGrad
    pressedGradient:         pressedGrad
    labelGradient:           labelGrad
    editGradient:            editGrad
    extraGradient:           extraGrad
    buttonBorderColor:       "#596b7f"
    labelBorderColor:        "#596b7f"
    editBorderColor:         "#596b7f"
    borderWidth:             2
    radiusScaler:            100
    buttonFontBold:          true
    labelFontBold:           true
    editFontBold:            false
    hintFontBold:            false
    fontFamily:              "Arial"
    fontFamilyHeadig:        "Arial"
    primaryColor:            "#81d4ff"
    secondaryColor:          "#81d4ff"
    highlightColor:          "#C0FFFF"
    secondaryHighlightColor: "#71e4ef"
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
                        position: 0.020
                        color: "#CC0B3450"
                    }

                    GradientStop {
                        position: 1
                        color: "#CC132C42"
                    }
                }
    Gradient {
                id: hoveredGrad
                    GradientStop {
                        position: 0.020
                        color: "#CC3484BF"
                    }

                    GradientStop {
                        position: 1
                        color: "#CC3D7CA5"
                    }
                }
    Gradient {
                id: pressedGrad
                GradientStop {
                        position: 0.020
                        color: "#CC399ADE"
                    }

                    GradientStop {
                        position: 1
                        color: "#CC4190C8"
                    }
                }
    Gradient {
                id: labelGrad
                GradientStop {
                    position: 0.020
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
                    position: 0.020
                    color: "#CC2E6792"
                }

                GradientStop {
                    position: 1
                    color: "#CC2B577A"
                }
                }
    Gradient {
                 id: extraGrad
                    GradientStop {
                        position: 0
                        color: "#CC1D2F3D"
                    }

                    GradientStop {
                        position: 0.080
                        color: "#CC24425A"
                    }

                    GradientStop {
                        position: 0.390
                        color: "#CC5F94BC"
                    }

                    GradientStop {
                        position: 0.400
                        color: "#CC24425A"
                    }

                    GradientStop {
                        position: 0.900
                        color: "#CC24445D"
                    }

                    GradientStop {
                        position: 1
                        color: "#CC212E37"
                    }
                }
    }
