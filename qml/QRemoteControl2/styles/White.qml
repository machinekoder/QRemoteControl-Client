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
    buttonBorderColor:    "#eeeeee"
    labelBorderColor:     "#00000000"
    editBorderColor:      "#eeeeee"
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
                    color: "#ffffff"
                }

                GradientStop {
                    position: 1
                    color: "#d1d1d1"
                }
                }
    Gradient {
                id: hoveredGrad
                GradientStop {
                    position: 0
                    color: "#eaeaea"
                }

                GradientStop {
                    position: 1
                    color: "#d3d3d3"
                }
                }
    Gradient {
                id: pressedGrad
                GradientStop {
                    position: 0
                    color: "#e0e0e0"
                }

                GradientStop {
                    position: 1
                    color: "#ffffff"
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
                     color: "#b5b5b5"
                 }

                 GradientStop {
                     position: 0.080
                     color: "#999999"
                 }

                 GradientStop {
                     position: 0.390
                     color: "#8f8f8f"
                 }

                 GradientStop {
                     position: 0.430
                     color: "#7a7a7a"
                 }

                 GradientStop {
                     position: 0.900
                     color: "#5a5959"
                 }

                 GradientStop {
                     position: 1
                     color: "#585858"
                 }
                }
    }
