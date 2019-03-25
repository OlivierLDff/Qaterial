/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */
 
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

import QtGraphicalEffects 1.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12

T.TabBar 
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: 1

    property color backgroundColor: onPrimary ? MaterialStyle.primaryColor : MaterialStyle.backgroundColor
    property color accentColor: !enabled ? (colorReversed ? MaterialStyle.disabledTextColorReversed() : MaterialStyle.disabledTextColor()) : 
                                highlighted ? MaterialStyle.accentColor : 
                                colorReversed ? MaterialStyle.primaryTextColorReversed() : 
                                                MaterialStyle.primaryTextColor()

    property bool highlighted: onPrimary ? MaterialStyle.preferAccentOnPrimary : true

    property bool onPrimary: false
    property bool colorReversed: onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary

    property double elevation: position === TabBar.Footer ? MaterialStyle.tabBar.elevation : 0

    contentItem: ListView 
    {
        model: control.contentModel
        currentIndex: control.currentIndex

        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.AutoFlickIfNeeded
        snapMode: ListView.SnapToItem

        highlightMoveDuration: 250
        highlightResizeDuration: 0
        highlightFollowsCurrentItem: true
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: 48
        preferredHighlightEnd: width - 48

        highlight: Item 
        {
            z: 2
            Rectangle 
            {
                height: MaterialStyle.tabBar.highlightHeight
                width: parent.width
                y: control.position === TabBar.Footer ? 0 : parent.height - height
                color: control.accentColor
                visible: control.enabled
            } // Rectangle
        } // Item
    } // ListView

    background: Rectangle 
    {
        color: control.backgroundColor

        layer.enabled: control.elevation > 0
        layer.effect: ElevationEffect 
        {
            elevation: control.elevation
            fullWidth: true
        } // ElevationEffect
    } // Rectangle
} // TabBar
