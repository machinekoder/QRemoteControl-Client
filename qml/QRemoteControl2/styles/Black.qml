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
    buttonBorderColor:    "#111111"
    labelBorderColor:     "#00000000"
    editBorderColor:      "#111111"
    borderWidth:          2
    radiusScaler:         6
    primaryTextColor:     "white"
    secondaryTextColor:   "white"
    editTextColor:        "black"
    hintTextColor:        "grey"
    linkTextColor:        "#1e8de7"
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
    }
