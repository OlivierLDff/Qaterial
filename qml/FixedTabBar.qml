/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Controls 2.12

import Qaterial.Style 1.12
import Qaterial.Core 1.12
import Qaterial.Components 1.12

TabBar
{
    id: root
    property alias model: _repeater.model
    property int display: AbstractButton.TextUnderIcon
    property bool hintText: false
    property bool useSmallFont: false
    implicitWidth: width

    Repeater
    {
        id: _repeater
        delegate: TabButton
        {
            elide: Text.ElideRight
            width: root.width/model.count
            implicitWidth: width
            display: hintText ? (!checked ? AbstractButton.IconOnly : AbstractButton.TextUnderIcon) : root.display
            text: model.text ? model.text : ""
            icon.source: model.source ? model.source : ""
            onPrimary: root.onPrimary
            enabled: root.enabled
            hintText: root.hintText
            useSmallFont: root.useSmallFont
        }
    }
} // TabBar
