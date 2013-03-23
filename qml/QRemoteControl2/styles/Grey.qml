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
    buttonBorderColor:    "#999"
    labelBorderColor:     "#00000000"
    editBorderColor:      "#999"
    borderWidth:          2
    radiusScaler:         2.8
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
                    color: "#fff"
                }
                GradientStop {
                    position: 1
                    color: "#888"
                }
                }
    Gradient {
                id: hoveredGrad
                GradientStop {
                    position: 0
                    color: "#bbb"
                }
                GradientStop {
                    position: 1
                    color: "#777"
                }
                }
    Gradient {
                id: pressedGrad
                GradientStop {
                    position: 0
                    color: "#fff"
                }
                GradientStop {
                    position: 1
                    color: "#ddd"
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
                     color: "#a6a6a6"
                 }

                 GradientStop {
                     position: 0.08
                     color: "#7f7f7f"
                 }

                 GradientStop {
                     position: 0.39999
                     color: "#717171"
                 }

                 GradientStop {
                     position: 0.4
                     color: "#626262"
                 }

                 GradientStop {
                     position: 0.9
                     color: "#4c4c4c"
                 }

                 GradientStop {
                     position: 1
                     color: "#333333"
                 }
                }
    }
