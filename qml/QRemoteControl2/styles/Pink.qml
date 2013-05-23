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
    buttonBorderColor:    "#e664ff"
    labelBorderColor:     "#00000000"
    editBorderColor:      "#e664ff"
    borderWidth:          2
    radiusScaler:         6
    primaryTextColor:     "black"
    secondaryTextColor:   "black"
    editTextColor:        "black"
    hintTextColor:        "grey"
    linkTextColor:        "#67185E"
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
                    color: "#f28bff"
                }

                GradientStop {
                    position: 1
                    color: "#cc00b1"
                }
                }
    Gradient {
                id: hoveredGrad
                GradientStop {
                    position: 0
                    color: "#db8bff"
                }

                GradientStop {
                    position: 1
                    color: "#b400cc"
                }
                }
    Gradient {
                id: pressedGrad
                GradientStop {
                    position: 0
                    color: "#fea6ff"
                }

                GradientStop {
                    position: 1
                    color: "#c830b7"
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
                     color: "#a234a6"
                 }

                 GradientStop {
                     position: 0.060
                     color: "#852888"
                 }

                 GradientStop {
                     position: 0.380
                     color: "#7b298b"
                 }

                 GradientStop {
                     position: 0.390
                     color: "#581f75"
                 }

                 GradientStop {
                     position: 0.900
                     color: "#51195a"
                 }

                 GradientStop {
                     position: 1
                     color: "#2a0e3c"
                 }
                }
    }
