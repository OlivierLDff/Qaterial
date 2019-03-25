/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

AppBarButton
{
    property TextField textField
    property TextArea textArea
    property ComboBox comboBox
    backgroundImplicitHeight: MaterialStyle.textField.iconWidth
    topInset: 0
    bottomInset: 0
    foregroundColor: !enabled ? (colorReversed ? MaterialStyle.disabledTextColorReversed() : MaterialStyle.disabledTextColor()) :
                colorReversed ? MaterialStyle.secondaryTextColorReversed() : MaterialStyle.secondaryTextColor()

    width: visible ? implicitWidth : 0
}