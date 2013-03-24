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
    buttonBorderColor:    "#596b7f"
    labelBorderColor:     "#596b7f"
    editBorderColor:      "#596b7f"
    borderWidth:          2
    radiusScaler:         100
    primaryTextColor:     "#81d4ff"
    secondaryTextColor:   "#81d4ff"
    editTextColor:        "#81d4ff"
    hintTextColor:        "#71e4ef"
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
