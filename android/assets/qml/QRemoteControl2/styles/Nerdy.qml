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
    buttonBorderColor:    "green"
    labelBorderColor:     "#00000000"
    editBorderColor:      "green"
    borderWidth:          2
    radiusScaler:         100
    primaryTextColor:     "green"
    secondaryTextColor:   "green"
    editTextColor:        "green"
    hintTextColor:        "#92009909"
    buttonFontSize:       master.width * 0.05
    buttonFontBold:       true
    labelFontSize:        master.width * 0.04
    labelFontBold:        true
    editFontSize:         master.width * 0.04
    editFontBold:         false
    hintFontSize:         master.width * 0.04
    hintFontBold:         false
    fontFamily:           "Courier"

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
