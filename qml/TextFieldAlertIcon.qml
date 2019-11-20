/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12

import Qaterial 1.0

TextFieldIcon
{
    id: control
    color: MaterialStyle.errorColor
    source: "qrc:/Qaterial/Images/alert-circle.svg"
    onVisibleChanged:
    {
        if(visible)
            _anim.start()
    }
    ErrorSequentialAnimation { id: _anim; target: control; }
}
