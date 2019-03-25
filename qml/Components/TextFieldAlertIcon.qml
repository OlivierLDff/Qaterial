/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

TextFieldIcon
{
    id: control
    color: MaterialStyle.errorColor
    source: "qrc:/QQuickMaterialHelper/Components/images/alert-circle.svg"
    onVisibleChanged:
    {
        if(visible)
            _anim.start()
    }
    ErrorSequentialAnimation { id: _anim; target: control; } 
}