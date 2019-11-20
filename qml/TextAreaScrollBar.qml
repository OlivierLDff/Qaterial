/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T

import Qaterial 1.0

ScrollBar
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 2
    policy: ScrollBar.AlwaysOn

    background: Rectangle
    {
        implicitWidth: control.interactive ? MaterialStyle.scroll.implicitWidthBackground : MaterialStyle.scroll.implicitWidthInactive
        implicitHeight: control.interactive ? MaterialStyle.scroll.implicitWidthBackground : MaterialStyle.scroll.implicitWidthInactive
        color: "transparent"
    } // Rectangle

    contentItem: Rectangle
    {
        implicitWidth: 4
        implicitHeight: 4
        radius: 2

        color: MaterialStyle.hintTextColor()
        visible: control.size < 1.0
        opacity: 0.5

        states: State
        {
            name: "active"
            when: control.active
            PropertyChanges { target: control.contentItem; opacity: 0.75 }
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
                    NumberAnimation { targets: [contentItem, background]; property: "opacity"; to: 0.5 }
                }
            } // Transition
        ] // padding
    } // Rectangle
} // ScrollBar
