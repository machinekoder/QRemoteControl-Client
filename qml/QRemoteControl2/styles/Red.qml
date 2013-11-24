// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import "../MyComponents"

Style {
    defaultGradient:  defaultGrad
    hoveredGradient:  hoveredGrad
    pressedGradient:  pressedGrad
    labelGradient:    labelGrad
    editGradient:     editGrad
    extraGradient:    extraGrad
    buttonBorderColor:    "#ff2e00"
    labelBorderColor:     "#00000000"
    editBorderColor:      "#ff2e00"
    borderWidth:          2
    radiusScaler:         6
    primaryTextColor:     "black"
    secondaryTextColor:   "black"
    editTextColor:        "black"
    hintTextColor:        "grey"
    linkTextColor:        "#880000"
    buttonFontSize:       master.width * 0.05
    buttonFontBold:       true
    labelFontSize:        master.width * 0.04
    labelFontBold:        true
    editFontSize:         master.width * 0.04
    editFontBold:         false
    hintFontSize:         master.width * 0.04
    hintFontBold:         false
    fontFamily:           "Arial"

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
