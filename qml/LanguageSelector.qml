import QtQuick 2.0
import "MyComponents"

Grid {
    id: languageButtons
    width:                       master.buttonHeight * 0.9 * 5 + 4 * master.generalMargin
    height:                      englishButton.height*2
    columns:                     5
    rows:                        2
    spacing:                     master.generalMargin

    function setLanguage(language)
    {
        englishButton.checked   = false
        spanishButton.checked   = false
        germanButton.checked    = false
        russianButton.checked   = false
        turkishButton.checked   = false
        ukrainianButton.checked = false
        italianButton.checked   = false

        switch (language)
        {
            case "en": englishButton.checked = true
                    break
            case "es": spanishButton.checked = true
                    break
            case "de": germanButton.checked = true
                    break
            case "ru": russianButton.checked = true
                    break
            case "tr": turkishButton.checked = true
                    break
            case "uk": ukrainianButton.checked = true
                    break
            case "it": italianButton.checked = true
                    break
        }
    }

    Button {
        id:              englishButton
        checkable:       true
        width:           master.buttonHeight * 0.9
        height:          width
        text:            ""
        icon:            master.imagePath + "lang/english.png"
        onClicked: {
            if (!checked)
            {
                spanishButton.checked = false
                germanButton.checked = false
                russianButton.checked = false
                turkishButton.checked = false
                ukrainianButton.checked = false
                italianButton.checked = false

                client.language = "en"
            }
            else
                checked = false
        }
    }
    Button {
        id:              spanishButton
        checkable:       true
        width:           master.buttonHeight * 0.9
        height:          width
        text:            ""
        icon:            master.imagePath + "lang/spanish.png"
        onClicked: {
            if (!checked)
            {
                englishButton.checked = false
                germanButton.checked = false
                russianButton.checked = false
                turkishButton.checked = false
                ukrainianButton.checked = false
                italianButton.checked = false

                client.language = "es"
            }
            else
                checked = false
        }
    }
    Button {
        id:              germanButton
        checkable:       true
        width:           master.buttonHeight * 0.9
        height:          width
        text:            ""
        icon:            master.imagePath + "lang/german.png"
        onClicked: {
            if (!checked)
            {
                spanishButton.checked = false
                englishButton.checked = false
                russianButton.checked = false
                turkishButton.checked = false
                ukrainianButton.checked = false
                italianButton.checked = false

                client.language = "de"
            }
            else
                checked = false
        }
    }
    Button {
        id:              russianButton
        checkable:       true
        width:           master.buttonHeight * 0.9
        height:          width
        text:            ""
        icon:            master.imagePath + "lang/russian.png"
        onClicked: {
            if (!checked)
            {
                spanishButton.checked = false
                germanButton.checked = false
                englishButton.checked = false
                turkishButton.checked = false
                ukrainianButton.checked = false
                italianButton.checked = false

                client.language = "ru"
            }
            else
                checked = false
        }
    }
    Button {
        id:              turkishButton
        checkable:       true
        width:           master.buttonHeight * 0.9
        height:          width
        text:            ""
        icon:            master.imagePath + "lang/turkish.png"
        onClicked: {
            if (!checked)
            {
                spanishButton.checked = false
                germanButton.checked = false
                englishButton.checked = false
                russianButton.checked = false
                ukrainianButton.checked = false
                italianButton.checked = false

                client.language = "tr"
            }
            else
                checked = false
        }
    }
    Button {
        id:              ukrainianButton
        checkable:       true
        width:           master.buttonHeight * 0.9
        height:          width
        text:            ""
        icon:            master.imagePath + "lang/ukrainian.png"
        onClicked: {
            if (!checked)
            {
                spanishButton.checked = false
                germanButton.checked = false
                englishButton.checked = false
                russianButton.checked = false
                turkishButton.checked = false
                englishButton.checked = false
                italianButton.checked = false

                client.language = "uk"
            }
            else
                checked = false
        }
    }
    Button {
        id:              italianButton
        checkable:       true
        width:           master.buttonHeight * 0.9
        height:          width
        text:            ""
        icon:            master.imagePath + "lang/italian.png"
        onClicked: {
            if (!checked)
            {
                spanishButton.checked = false
                germanButton.checked = false
                englishButton.checked = false
                russianButton.checked = false
                turkishButton.checked = false
                ukrainianButton.checked = false

                client.language = "it"
            }
            else
                checked = false
        }
    }

}

