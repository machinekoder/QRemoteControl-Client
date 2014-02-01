import QtQuick 2.0
import "../MyComponents"

Style {
    name:                    qsTr("Nerdy") + client.emptyString
    themeName:               "nerdy"
    backgroundImage:         ""
    backgroundImageFillMode: Image.Stretch
    iconTheme:               "nerdy"
    defaultGradient:         defaultGrad
    hoveredGradient:         hoveredGrad
    pressedGradient:         pressedGrad
    labelGradient:           labelGrad
    editGradient:            editGrad
    extraGradient:           extraGrad
    buttonBorderColor:       "green"
    labelBorderColor:        "#00000000"
    editBorderColor:         "green"
    borderWidth:             2
    radiusScaler:            100
    buttonFontBold:          true
    labelFontBold:           true
    editFontBold:            false
    hintFontBold:            false
    fontFamily:              "Courier"
    fontFamilyHeadig:        "Courier"
    primaryColor:            "green"
    secondaryColor:          "green"
    highlightColor:          "green"
    secondaryHighlightColor: "#92009909"
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
                        color: "#1e04ff00"
                    }

                    GradientStop {
                        position: 1
                        color: "#32007309"
                    }
                }
    Gradient {
                id: hoveredGrad
                    GradientStop {
                        position: 0.020
                        color: "#4404ff00"
                    }

                    GradientStop {
                        position: 1
                        color: "#99007309"
                    }
                }
    Gradient {
                id: pressedGrad
                GradientStop {
                        position: 0.020
                        color: "#8804ff00"
                    }

                    GradientStop {
                        position: 1
                        color: "#bb007309"
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
                    color: "#1e04ff00"
                }

                GradientStop {
                    position: 1
                    color: "#32007309"
                }
                }
    Gradient {
                 id: extraGrad
                    GradientStop {
                        position: 0
                        color: "#333333"
                    }

                    GradientStop {
                        position: 0.080
                        color: "#232323"
                    }

                    GradientStop {
                        position: 0.390
                        color: "#1b1b1b"
                    }

                    GradientStop {
                        position: 0.400
                        color: "#0e0d0d"
                    }

                    GradientStop {
                        position: 0.900
                        color: "#0c0c0c"
                    }

                    GradientStop {
                        position: 1
                        color: "#000000"
                    }
                }
    }
