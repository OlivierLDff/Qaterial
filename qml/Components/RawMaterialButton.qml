/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

 // Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

// Qt Graphical
import QtGraphicalEffects 1.12

// MaterialHelper
import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12

T.Button
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property bool drawline: MaterialStyle.debug.drawDebugButton
    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    property alias textType: _iconLabel.textType

    topInset: MaterialStyle.rawButton.topInset
    bottomInset: MaterialStyle.rawButton.bottomInset
    leftInset: MaterialStyle.rawButton.leftInset
    rightInset: MaterialStyle.rawButton.rightInset

    leftPadding: (icon.source != "" && !mirrored || text == "" ? MaterialStyle.rawButton.iconPadding : (flat && !outlined) ? MaterialStyle.rawButton.spacing : MaterialStyle.rawButton.padding) + leftInset
    rightPadding: (icon.source != "" && mirrored || text == "" ? MaterialStyle.rawButton.iconPadding : (flat && !outlined) ? MaterialStyle.rawButton.spacing : MaterialStyle.rawButton.padding) + rightInset
    topPadding: 0
    bottomPadding: 0
    spacing: MaterialStyle.rawButton.spacing

    property bool outlined: false

    property color foregroundColor: !enabled ? (flat ? MaterialStyle.disabledTextColor() : MaterialStyle.disabledTextColor()) :
        flat && highlighted ? MaterialStyle.accentColor :
        colorReversed ? MaterialStyle.primaryTextColorReversed() : MaterialStyle.primaryTextColor()

    property color backgroundColor: flat ? ((outlined && pressed) ? MaterialStyle.backgroundColor : "transparent") :
        !enabled ? (MaterialStyle.buttonDisabledColor) :
       (highlighted ? MaterialStyle.accentColor : MaterialStyle.buttonColor )

    readonly property int flatRippleColor: onPrimary ? MaterialStyle.RippleBackground.Primary : MaterialStyle.RippleBackground.Background
    readonly property int rawRippleColor: highlighted ? MaterialStyle.RippleBackground.Accent : MaterialStyle.RippleBackground.Primary

    property color rippleColor: MaterialStyle.rippleColor(accentRipple ? MaterialStyle.RippleBackground.AccentLight : (flat ? flatRippleColor : rawRippleColor))

    property color outlinedColor: outlined ?
        (!enabled ? MaterialStyle.disabledDividersColor() : pressed ? foregroundColor : MaterialStyle.dividersColor()) :
        "transparent"

    property bool onPrimary: false
    property bool colorReversed: (flat && onPrimary && MaterialStyle.shouldReverseForegroundOnPrimary) ||
                                (highlighted && MaterialStyle.shouldReverseForegroundOnAccent) ||
                                (!flat && !highlighted && MaterialStyle.shouldReverseForegroundOnPrimary)

    property double radius: MaterialStyle.rawButton.cornerRadius

    icon.width: MaterialStyle.rawButton.iconWidth
    icon.height: MaterialStyle.rawButton.iconWidth
    icon.color: foregroundColor

    property double elevation: flat ? ((control.down || control.hovered) ? MaterialStyle.rawButton.flatPressedElevation : MaterialStyle.rawButton.flatElevation)
                         : (control.down ? MaterialStyle.rawButton.defaultPressedElevation : MaterialStyle.rawButton.defaultElevation)

    property bool clipRipple: true
    property bool forceRipple: false
    property bool accentRipple: false

    contentItem: IconLabel
    {
        id: _iconLabel
        textType: MaterialStyle.TextType.Button
        spacing: control.spacing
        display: control.display
        icon: control.icon
        text: control.text
        color: control.foregroundColor
    } // IconLabel

    property double backgroundImplicitWidth: MaterialStyle.rawButton.minWidth
    property double backgroundImplicitHeight: MaterialStyle.rawButton.minHeight

    background: Rectangle
    {
        DebugRectangle
        {
            anchors.fill: parent
            border.color: "aquamarine"
            visible: control.drawline
        }

        implicitWidth: control.backgroundImplicitWidth
        implicitHeight: control.backgroundImplicitHeight
        radius: control.radius
        color: control.backgroundColor
        border.width: control.outlined ? (control.pressed ? MaterialStyle.rawButton.outlinedFocusWidth : MaterialStyle.rawButton.outlinedWidth) : 0
        border.color: control.outlinedColor
        // The layer is disabled when the button color is transparent so you can do
        // Material.background: "transparent" and get a proper flat button without needing
        // to set Material.elevation as well
        layer.enabled: control.enabled && (control.backgroundColor.a > 0)
        layer.effect: ElevationEffect
        {
            elevation: control.elevation
        }

        Ripple
        {
            id: ripple
            property bool isActive: control.down || control.visualFocus || control.hovered || control.forceRipple
            width: parent.width + (control.outlined ? -2 : 0)
            height: parent.height + (control.outlined ? -2 : 0)
            anchors.centerIn: parent
            pressed: control.pressed
            anchor: control
            active: isActive
            color: control.rippleColor
            // trick because clipRadius isn't working in ripple private implementation (QTBUG-51894)
            layer.enabled: control.clipRipple
            layer.effect: OpacityMask
            {
                maskSource: Rectangle
                {
                    width: ripple.width
                    height: ripple.height
                    radius: control.radius
                }
            } // OpacityMask
        } // Ripple
    } // Rectangle
} // Button
