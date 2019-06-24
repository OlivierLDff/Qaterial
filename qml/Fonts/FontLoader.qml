/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12

FontLoader 
{
    source: Qt.resolvedUrl("qrc:/QQuickMaterialHelper/fonts/roboto/Roboto-BlackItalic.ttf")
    onStatusChanged: 
    {
        // FontLoader.Null - no font has been set
        // FontLoader.Ready - the font has been loaded
        // FontLoader.Loading - the font is currently being loaded
        // FontLoader.Error - an error occurred while loading the font
        switch(status)
        {
            case FontLoader.Null:
                console.log("FontLoader source is null")
                break
            case FontLoader.Ready: 
                console.log("Font " + source + " (" + name + ") is ready" )
                break
            case FontLoader.Loading: 
                console.log("Font " + source + " (" + name + ") is loading" )
                break
            case FontLoader.Error: 
                console.log("Error loading font " + source + " (" + name + ")" )
                break
        }
    }
}