/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T

import QQuickMaterialHelper.Style 1.12 as MStyle
import QQuickMaterialHelper.Core 1.12 as MCore
import QQuickMaterialHelper.Components 1.12 as MComponents

T.Slider
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)

    padding: 6

    property color rippleColor: MStyle.MaterialStyle.rippleColorTheme
    property color accentColor: MStyle.MaterialStyle.accentColor
    property color foregroundColor: MStyle.MaterialStyle.hintTextColor()

    handle: MComponents.SliderHandle
    {
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
        value: control.value
        handleHasFocus: control.visualFocus
        handlePressed: control.pressed
        handleHovered: control.hovered
        rippleColor: control.rippleColor
        accentColor: control.accentColor
    } // MComponents.SliderHandle

    background: Rectangle
    {
        x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: control.horizontal ? 200 : 34
        implicitHeight: control.horizontal ? 34 : 200
        width: control.horizontal ? control.availableWidth : 1
        height: control.horizontal ? 1 : control.availableHeight
        color: control.foregroundColor
        scale: control.horizontal && control.mirrored ? -1 : 1

        Rectangle
        {
            x: control.horizontal ? 0 : (parent.width - width) / 2
            y: control.horizontal ? (parent.height - height) / 2 : control.visualPosition * parent.height
            width: control.horizontal ? control.position * parent.width : 3
            height: control.horizontal ? 3 : control.position * parent.height

            color: control.accentColor
        } // Rectangle
    } // Rectangle
} // Slider
