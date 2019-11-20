/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0

T.GroupBox
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: Style.card.spacing
    horizontalPadding: Style.card.horizontalPadding
    verticalPadding: Style.card.verticalPadding

    topPadding: verticalPadding + (inlineTitle ? (implicitLabelWidth > 0 ? implicitLabelHeight/2 + spacing : 0) : (implicitLabelWidth > 0 ? implicitLabelHeight + spacing : 0))

    property bool onPrimary: false
    property bool colorReversed: onPrimary && Style.shouldReverseForegroundOnPrimary

    property color color: onPrimary ? Style.primaryColor : Style.backgroundColor
    property color borderColor: enabled ? Style.dividersColor() : Style.disabledDividersColor()
    property alias radius: _rect.radius

    property int textType: Style.TextType.Overline

    property bool inlineTitle: false

    label: Label
    {
        id: _label
        x: control.leftPadding + (control.inlineTitle ? (control.verticalPadding) : 0 )
        width: control.availableWidth - x

        text: control.title
        textType: control.textType
        onPrimary: control.onPrimary
        colorReversed: control.colorReversed
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter

        property bool drawline: Style.debug.drawDebugIconLabel
    }

    background: Rectangle
    {
        id: _rect
        y: control.inlineTitle ? label.implicitHeight/2 : (control.topPadding - control.bottomPadding)
        implicitWidth: 200
        width: parent.width
        height: parent.height + (control.inlineTitle ? (-label.implicitHeight/2) : (-control.topPadding + control.bottomPadding))
        radius: Style.card.radius
        color: control.inlineTitle ? "transparent" : control.color
        border.color: control.borderColor
        border.width: 1
        layer.enabled: control.inlineTitle && control.implicitLabelWidth
        layer.effect: OpacityMask
        {
            invert: true
            maskSource: Rectangle
            {
                color: "transparent"
                width: _rect.width
                height: _rect.height
                Rectangle
                {
                    width: label.contentWidth + control.verticalPadding*2
                    height: label.implicitHeight
                    x: control.leftPadding
                    y: -height/2
                } // Rectangle
            } // Rectangle
        } // OpacityMask
    } // Rectangle
} // Frame
