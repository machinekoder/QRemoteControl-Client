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
    buttonBorderColor:    "#8d8d8d"
    labelBorderColor:     "#00000000"
    editBorderColor:      "#8d8d8d"
    borderWidth:          2
    radiusScaler:         6
    primaryTextColor:     "black"
    secondaryTextColor:   "black"
    editTextColor:        "black"
    hintTextColor:        "grey"
    linkTextColor:        "#585858"
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
                    color: "#848484"
                }

                GradientStop {
                    position: 0.400
                    color: "#cccccc"
                }

                GradientStop {
                    position: 1
                    color: "#828282"
                }
                }
    Gradient {
                id: hoveredGrad
                GradientStop {
                    position: 0
                    color: "#717171"
                }

                GradientStop {
                    position: 0.400
                    color: "#afafaf"
                }

                GradientStop {
                    position: 1
                    color: "#6d6d6d"
                }
                }
    Gradient {
                id: pressedGrad
                GradientStop {
                    position: 0
                    color: "#a0a0a0"
                }

                GradientStop {
                    position: 0.40
                    color: "#e2e2e2"
                }

                GradientStop {
                    position: 1
                    color: "#9c9c9c"
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
