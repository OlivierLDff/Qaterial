/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

TabBar 
{
    id: root
    property alias model: _repeater.model
    property int display: AbstractButton.TextBesideIcon
    width: implicitWidth

    Repeater
    {
        id: _repeater
        delegate: TabButton
        {
            display: root.display
            text: model.text ? model.text : ""
            icon.source: model.source ? model.source : ""
            onPrimary: root.onPrimary
            enabled: root.enabled
        }
    }
} // TabBar
