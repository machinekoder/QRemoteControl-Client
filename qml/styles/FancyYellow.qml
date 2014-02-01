// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "../MyComponents"

Style {
    name:                 qsTr("Fancy Yellow") + client.emptyString
    themeName:            "fancyyellow"
    backgroundImage:      "images/yellow_leaf.jpg"
    backgroundImageFillMode: Image.PreserveAspectCrop
    backgroundImageEffect:   true
    iconTheme:               "white2"
    defaultGradient:         defaultGrad
    hoveredGradient:         hoveredGrad
    pressedGradient:         pressedGrad
    labelGradient:           labelGrad
    editGradient:            editGrad
    extraGradient:           extraGrad
    buttonBorderColor:       "#00000000"
    labelBorderColor:        "#00000000"
    editBorderColor:         "#00000000"
    borderWidth:             0
    radiusScaler:            10
    buttonFontBold:          false
    labelFontBold:           false
    editFontBold:            false
    hintFontBold:            false
    fontFamily:              "Arial"
    fontFamilyHeadig:        "Arial"

    primaryColor:            "#ffffff"
    secondaryColor:          "#AAffffff"
    highlightColor:          "#ffd57f"
    secondaryHighlightColor: "#aaccaa65"
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

