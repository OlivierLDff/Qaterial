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

// Qaterial
import Qaterial 1.0

T.Button
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property bool drawline: Style.debug.drawDebugButton
    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    property alias textType: _iconLabel.textType
    property int elide: Text.ElideNone

    topInset: Style.rawButton.topInset
    bottomInset: Style.rawButton.bottomInset
    leftInset: Style.rawButton.leftInset
    rightInset: Style.rawButton.rightInset

    leftPadding: (icon.source != "" && !mirrored || text == "" ? Style.rawButton.iconPadding : (flat && !outlined) ? Style.rawButton.spacing : Style.rawButton.padding) + leftInset
    rightPadding: (icon.source != "" && mirrored || text == "" ? Style.rawButton.iconPadding : (flat && !outlined) ? Style.rawButton.spacing : Style.rawButton.padding) + rightInset
    topPadding: 0
    bottomPadding: 0
    spacing: Style.rawButton.spacing

    property bool outlined: false

    property color foregroundColor: !enabled ? (flat ? Style.disabledTextColor() : Style.disabledTextColor()) :
        flat && highlighted ? Style.accentColor :
        colorReversed ? Style.primaryTextColorReversed() : Style.primaryTextColor()

    property color backgroundColor: flat ? ((outlined && pressed) ? Style.backgroundColor : "transparent") :
        !enabled ? (Style.buttonDisabledColor) :
       (highlighted ? Style.accentColor : Style.buttonColor )

    readonly property int flatRippleColor: onPrimary ? Style.RippleBackground.Primary : Style.RippleBackground.Background
    readonly property int rawRippleColor: highlighted ? Style.RippleBackground.Accent : Style.RippleBackground.Primary

    property color rippleColor: Style.rippleColor(accentRipple ? Style.RippleBackground.AccentLight : (flat ? flatRippleColor : rawRippleColor))

    property color outlinedColor: outlined ?
        (!enabled ? Style.disabledDividersColor() : pressed ? foregroundColor : Style.dividersColor()) :
        "transparent"

    property bool onPrimary: false
    property bool colorReversed: (flat && onPrimary && Style.shouldReverseForegroundOnPrimary) ||
                                (highlighted && Style.shouldReverseForegroundOnAccent) ||
                                (!flat && !highlighted && Style.shouldReverseForegroundOnPrimary)

    property double radius: Style.rawButton.cornerRadius

    icon.width: Style.rawButton.iconWidth
    icon.height: Style.rawButton.iconWidth
    icon.color: foregroundColor

    property double elevation: flat ? ((control.down || control.hovered) ? Style.rawButton.flatPressedElevation : Style.rawButton.flatElevation)
                         : (control.down ? Style.rawButton.defaultPressedElevation : Style.rawButton.defaultElevation)

    property bool clipRipple: true
    property bool forceRipple: false
    property bool accentRipple: false

    contentItem: IconLabel
    {
        id: _iconLabel
        textType: Style.TextType.Button
        spacing: control.spacing
        display: control.display
        icon: control.icon
        text: control.text
        color: control.foregroundColor

        elide: control.elide
    } // IconLabel

    property double backgroundImplicitWidth: Style.rawButton.minWidth
    property double backgroundImplicitHeight: Style.rawButton.minHeight

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
        border.width: control.outlined ? (control.pressed ? Style.rawButton.outlinedFocusWidth : Style.rawButton.outlinedWidth) : 0
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
            width: parent.width + (control.outlined ? -2 : 0)
            height: parent.height + (control.outlined ? -2 : 0)
            anchors.centerIn: parent
            pressed: control.pressed
            anchor: control
            active: control.down || control.visualFocus || control.hovered || control.forceRipple
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
