/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

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
