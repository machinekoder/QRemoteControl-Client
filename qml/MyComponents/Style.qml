// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

Item {
    id: main

    property string   name:                 "Default"
    property string   themeName:            "default"
    property string   backgroundImage:      ""
    property int      backgroundImageFillMode: Image.Stretch
    property string   backgroundColor:      "black"
    property bool     backgroundImageEffect: false
    property string   iconTheme:            "white"
    property Gradient defaultGradient:      defaultGrad
    property Gradient hoveredGradient:      hoveredGrad
    property Gradient pressedGradient:      pressedGrad
    property Gradient labelGradient:        labelGrad
    property Gradient editGradient:         editGrad
    property Gradient extraGradient:        extraGrad
    property color    buttonBorderColor:    "#111111"
    property color    labelBorderColor:     "#00000000"
    property color    editBorderColor:      "#111111"
    property int      borderWidth:          2
    property real     radiusScaler:         2.8
    //property color    primaryTextColor:     "white"
    //property color    secondaryTextColor:   "white"
    //property color    editTextColor:        "black"
    //property color    hintTextColor:        "grey"
    //property color    linkTextColor:        "blue"
    //property int      buttonFontSize:       10
    property bool     buttonFontBold:       true
    //property int      labelFontSize:        10
    property bool     labelFontBold:        true
    //property int      editFontSize:         10
    property bool     editFontBold:         false
    //property int      hintFontSize:         10
    property bool     hintFontBold:         false
    property string   fontFamily:           ""
    property string   fontFamilyHeadig:     fontFamily

    property color    primaryColor:             "white"
    property color    secondaryColor:           "white"
    property color    highlightColor:           "blue"
    property color    secondaryHighlightColor:  "lightblue"
    property int      fontSizeExtraLarge:       20
    property int      fontSizeExtraSmall:       6
    property int      fontSizeHuge:             16
    property int      fontSizeLarge:            14
    property int      fontSizeMedium:           12
    property int      fontSizeSmall:            10
    property int      fontSizeTiny:             8
    property int      paddingSmall:             2
    property int      paddingMedium:            4
    property int      paddingLarge:             6


    Gradient {
                id: defaultGrad
                    GradientStop {
                        position: 0
                        color: "#3e3e3e"
                    }

                    GradientStop {
                        position: 1
                        color: "#1a1a1a"
                    }
                }
    Gradient {
                id: hoveredGrad
                    GradientStop {
                        position: 0
                        color: "#4e4e4e"
                    }

                    GradientStop {
                        position: 1
                        color: "#2a2a2a"
                    }
                }
    Gradient {
                id: pressedGrad
                    GradientStop {
                        position: 0
                        color: "#1e8de7"
                    }

                    GradientStop {
                        position: 1
                        color: "#2b8fe5"
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

    function load(newTheme)
    {
        main.defaultGradient = newTheme.defaultGradient
        main.hoveredGradient = newTheme.hoveredGradient
        main.pressedGradient = newTheme.pressedGradient
        main.labelGradient = newTheme.labelGradient
        main.editGradient = newTheme.editGradient
        main.extraGradient = newTheme.extraGradient
        main.buttonBorderColor = newTheme.buttonBorderColor
        main.labelBorderColor = newTheme.labelBorderColor
        main.editBorderColor = newTheme.editBorderColor
        main.borderWidth = newTheme.borderWidth
        main.radiusScaler = newTheme.radiusScaler
        main.buttonFontBold = newTheme.buttonFontBold
        main.labelFontBold = newTheme.labelFontBold
        main.editFontBold = newTheme.editFontBold
        main.hintFontBold = newTheme.hintFontBold
        main.fontFamily = newTheme.fontFamily
        main.primaryColor = newTheme.primaryColor
        main.secondaryColor = newTheme.secondaryColor
        main.highlightColor = newTheme.highlightColor
        main.secondaryHighlightColor = newTheme.secondaryHighlightColor
        main.fontSizeExtraLarge = newTheme.fontSizeExtraLarge
        main.fontSizeExtraSmall = newTheme.fontSizeExtraSmall
        main.fontSizeHuge = newTheme.fontSizeHuge
        main.fontSizeLarge = newTheme.fontSizeLarge
        main.fontSizeMedium = newTheme.fontSizeMedium
        main.fontSizeSmall = newTheme.fontSizeSmall
        main.fontSizeTiny = newTheme.fontSizeTiny
        main.paddingSmall = newTheme.paddingSmall
        main.paddingMedium = newTheme.paddingMedium
        main.paddingLarge = newTheme.paddingLarge
    }
}
