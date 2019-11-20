/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T

// Qaterial
import Qaterial 1.0

T.Slider
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)

    padding: 6

    property color rippleColor: MaterialStyle.rippleColorTheme
    property color accentColor: MaterialStyle.accentColor
    property color foregroundColor: MaterialStyle.hintTextColor()
    property color disabledColor: MaterialStyle.disabledTextColor()
    property color backgroundDisabledColor: MaterialStyle.disabledDividersColor()
    handle: SliderHandle
    {
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
        value: control.value
        handleHasFocus: control.visualFocus
        handlePressed: control.pressed
        handleHovered: control.hovered
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
            x: control.horizontal ? 0 : (parent.width - width) / 2
            y: control.horizontal ? (parent.height - height) / 2 : control.visualPosition * parent.height
            width: control.horizontal ? control.position * parent.width : 3
            height: control.horizontal ? 3 : control.position * parent.height

            color: control.enabled ? control.accentColor : control.disabledColor
        } // Rectangle
    } // Rectangle
} // Slider
