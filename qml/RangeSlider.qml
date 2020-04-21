/**
 * Copyright (C) Paul Cales 2020
 * Contact: cales.paul@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0

T.RangeSlider
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            first.implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             first.implicitHandleHeight + topPadding + bottomPadding)

    padding: 6

    property color rippleColor: Style.rippleColorTheme
    property color accentColor: Style.accentColor
    property color foregroundColor: Style.hintTextColor()
    property color disabledColor: Style.disabledTextColor()
    property color backgroundDisabledColor: Style.disabledDividersColor()
    first.handle: SliderHandle
    {
        x: control.leftPadding + (control.horizontal ? control.first.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.first.visualPosition * (control.availableHeight - height))
        value: control.first.value
        handleHasFocus: control.visualFocus
        handlePressed: control.first.pressed
        handleHovered: control.first.hovered
        rippleColor: control.rippleColor
        accentColor: control.accentColor
        disabledColor: control.disabledColor
        enabled: control.enabled
    } // MComponents.SliderHandle

    second.handle: SliderHandle
    {
        x: control.leftPadding + (control.horizontal ? control.second.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.second.visualPosition * (control.availableHeight - height))
        value: control.second.value
        handleHasFocus: control.visualFocus
        handlePressed: control.second.pressed
        handleHovered: control.second.hovered
        rippleColor: control.rippleColor
        accentColor: control.accentColor
        disabledColor: control.disabledColor
        enabled: control.enabled
    } // MComponents.SliderHandle

    property int backgroundImplicitWidth: horizontal ? 200 : 34
    property int backgroundImplicitHeight: horizontal ? 34 : 200

    background: Rectangle
    {
        x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: control.backgroundImplicitWidth
        implicitHeight: control.backgroundImplicitHeight
        width: control.horizontal ? control.availableWidth : 1
        height: control.horizontal ? 1 : control.availableHeight
        color: control.enabled ? control.foregroundColor : control.backgroundDisabledColor
        scale: control.horizontal && control.mirrored ? -1 : 1

        Rectangle
        {
            x: control.horizontal ? control.first.position * parent.width : (parent.width - width) / 2
            y: control.horizontal ? (parent.height - height) / 2 : control.second.visualPosition * parent.height
            width: control.horizontal ? control.second.position * parent.width - control.first.position * parent.width : 3
            height: control.horizontal ? 3 : control.second.position * parent.height - control.first.position * parent.height
            color: control.enabled ? control.accentColor : control.disabledColor
        } // Rectangle
    } // Rectangle
} // RangeSlider
