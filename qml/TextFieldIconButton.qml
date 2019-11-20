/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12

import Qaterial 1.0

AppBarButton
{
    property TextField textField
    property TextArea textArea
    property ComboBox comboBox
    backgroundImplicitHeight: Style.textField.iconWidth
    topInset: 0
    bottomInset: 0
    foregroundColor: !enabled ? (colorReversed ? Style.disabledTextColorReversed() : Style.disabledTextColor()) :
                colorReversed ? Style.secondaryTextColorReversed() : Style.secondaryTextColor()

    width: visible ? implicitWidth : 0
}
