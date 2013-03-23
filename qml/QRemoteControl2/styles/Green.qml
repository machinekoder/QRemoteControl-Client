// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../MyComponents"

Style {
    defaultGradient:  defaultGrad
    hoveredGradient:  hoveredGrad
    pressedGradient:  pressedGrad
    labelGradient:    labelGrad
    editGradient:     editGrad
    extraGradient:    extraGrad
    buttonBorderColor:    "#84ff00"
    labelBorderColor:     "#00000000"
    editBorderColor:      "#84ff00"
    borderWidth:          2
    radiusScaler:         6
    primaryTextColor:     "black"
    secondaryTextColor:   "black"
    editTextColor:        "black"
    hintTextColor:        "grey"
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
