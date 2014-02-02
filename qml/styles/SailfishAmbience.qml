import QtQuick 2.0
import "../MyComponents"
import Sailfish.Silica 1.0

Style {
    name:                     qsTr("Ambience") + client.emptyString
    themeName:                "ambience"
    backgroundImage:          ""
    backgroundColor:          "#00000000"
    iconTheme:                "white2"
    defaultGradient:          defaultGrad
    hoveredGradient:          hoveredGrad
    pressedGradient:          pressedGrad
    labelGradient:            labelGrad
    editGradient:             editGrad
    extraGradient:            extraGrad
    buttonBorderColor:        "#00000000"
    labelBorderColor:         "#00000000"
    editBorderColor:          "#00000000"
    borderWidth:              2
    radiusScaler:             10
    buttonFontBold:           false
    labelFontBold:            false
    editFontBold:             false
    hintFontBold:             false
    fontFamily:               Theme.fontFamily
    fontFamilyHeadig:         Theme.fontFamilyHeading
    primaryColor:             Theme.primaryColor
    secondaryColor:           Theme.secondaryColor
    highlightColor:           Theme.highlightColor
    secondaryHighlightColor:  Theme.secondaryHighlightColor
    fontSizeExtraLarge:       Theme.fontSizeExtraLarge
    fontSizeExtraSmall:       Theme.fontSizeExtraSmall
    fontSizeHuge:             Theme.fontSizeHuge
    fontSizeLarge:            Theme.fontSizeLarge
    fontSizeMedium:           Theme.fontSizeMedium
    fontSizeSmall:            Theme.fontSizeSmall
    fontSizeTiny:             Theme.fontSizeTiny
    paddingSmall:             Theme.paddingSmall
    paddingMedium:            Theme.paddingMedium
    paddingLarge:             Theme.paddingLarge


    Gradient {
                id: defaultGrad
                    GradientStop {
                        position: 0
                        //color: Theme.secondaryHighlightColor
                        color: "#00000000"
                    }

                    GradientStop {
                        position: 1
                        //color: Theme.secondaryHighlightColor
                        color: "#00000000"
                    }
                }
    Gradient {
                id: hoveredGrad
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
                id: pressedGrad
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
                    color: "#00000000"
                }

                GradientStop {
                    position: 1
                    color: "#00000000"
                }
                }
    Gradient {
                 id: extraGrad
                    GradientStop {
                        position: 0
                        color: "#00000000"
                    }

                    GradientStop {
                        position: 1
                        color: "#00000000"
                    }
                }
    }
