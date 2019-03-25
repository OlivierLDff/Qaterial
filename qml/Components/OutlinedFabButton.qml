/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */
import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12

FlatFabButton
{
	id: control

    backgroundColor: "transparent"
    borderColor: enabled ? (highlighted ? MaterialStyle.accentColor : MaterialStyle.dividersColor()) : MaterialStyle.disabledDividersColor()
    outlined: true

    foregroundColor: !enabled ? MaterialStyle.disabledTextColor() :
        highlighted ? MaterialStyle.accentColor : MaterialStyle.primaryTextColor()
} // FabButton
	