/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T

import QQuickMaterialHelper.Style 1.12

T.ScrollBar 
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 0
    visible: control.policy !== T.ScrollBar.AlwaysOff
    rightPadding: MaterialStyle.scroll.padding
    leftPadding: MaterialStyle.scroll.padding

    contentItem: Rectangle 
    {
        implicitWidth: control.interactive ? MaterialStyle.scroll.implicitWidth : MaterialStyle.scroll.implicitWidthInactive
        implicitHeight: control.interactive ? MaterialStyle.scroll.implicitWidth : MaterialStyle.scroll.implicitWidthInactive
        radius: MaterialStyle.scroll.radius

        color: control.pressed ? MaterialStyle.secondaryTextColor() :
               control.interactive && control.hovered ? MaterialStyle.helperTextColor() : MaterialStyle.dividersColor()
        opacity: 0.0
    } // Rectangle

    background: Rectangle 
    {
        implicitWidth: control.interactive ? MaterialStyle.scroll.implicitWidthBackground : MaterialStyle.scroll.implicitWidthInactive
        implicitHeight: control.interactive ? MaterialStyle.scroll.implicitWidthBackground : MaterialStyle.scroll.implicitWidthInactive
        color: "#30000000"
        opacity: 0.0
        visible: control.interactive
    } // Rectangle

    states: State 
    {
        name: "active"
        when: control.policy === T.ScrollBar.AlwaysOn || (control.active && control.size < 1.0)
    } // State

    transitions: 
    [
        Transition 
        {
            to: "active"
            NumberAnimation { targets: [contentItem, background]; property: "opacity"; to: 1.0 }
        }, // Transition
        Transition 
        {
            from: "active"
            SequentialAnimation {
                PropertyAction{ targets: [contentItem, background]; property: "opacity"; value: 1.0 }
                PauseAnimation { duration: 2450 }
                NumberAnimation { targets: [contentItem, background]; property: "opacity"; to: 0 }
            }
        } // Transition
    ] // padding
} // ScrollBar
