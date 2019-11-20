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
    property int display: AbstractButton.TextOnly
    property double minWidth: Style.tabBar.minTabWidth
    property double maxWidth: Style.tabBar.maxTabWidth
    property int maxElement: 5
    implicitWidth: width

    leftPadding: !mirrored ? Style.tabBar.minLeftWidth : 0
    rightPadding: mirrored ? Style.tabBar.minLeftWidth : 0

    Repeater
    {
        id: _repeater
        delegate: TabButton
        {
            elide: Text.ElideRight
            width: Math.max(root.minWidth, Math.min(root.width / root.maxElement, root.maxWidth))
            implicitWidth: width
            display: root.display
            text: model.text ? model.text : ""
            icon.source: model.source ? model.source : ""
            onPrimary: root.onPrimary
            enabled: root.enabled
        }
    }
} // TabBar
