/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

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

    Behavior on implicitWidth { NumberAnimation { easing.type: Easing.InOutQuad; duration: 200 } }
    Behavior on implicitHeight { NumberAnimation { easing.type: Easing.InOutQuad; duration: 200 } }

    property bool drawline: Style.debug.drawDebugButton

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    topInset: Style.fab.topInset
    bottomInset: Style.fab.bottomInset
    leftInset: Style.fab.leftInset
    rightInset: Style.fab.rightInset

    font.family: Style.textTypeToFontFamily(Style.TextType.Button)
    font.styleName: Style.textTypeToStyleName(Style.TextType.Button)
    font.pixelSize: Style.textTypeToPixelSize(Style.TextType.Button)
    font.capitalization: Style.fontCapitalization(Style.TextType.Button)
    font.letterSpacing:  Style.textTypeToLetterSpacing(Style.TextType.Button)

    readonly property bool defaultPadding: type === Style.FabType.Default ? Style.fab.padding :
    	(type === Style.FabType.Mini ? Style.fab.paddingMini : Style.fab.textPadding)

    leftPadding: (type === Style.FabType.Extended ? (mirrored ? Style.fab.textPadding : Style.fab.iconPadding ) : defaultPadding) + leftInset
    rightPadding: (type === Style.FabType.Extended ? (mirrored ? Style.fab.iconPadding : Style.fab.textPadding ) : defaultPadding) + rightInset

    topPadding: 0
    bottomPadding: 0
    spacing: Style.fab.spacing

    // Style.FabType.Default | Style.FabType.Mini | Style.FabType.Extended
    property int type: extendedOnHovered && hovered && text != "" ? Style.FabType.Extended : Style.FabType.Default

    property color foregroundColor: !enabled ? (flat ? Style.disabledTextColor() : Style.disabledTextColor()) :
        flat && highlighted ? Style.buttonAccentColor :
        flat ? Style.secondaryTextColor() : Style.buttonTextColor

    property color backgroundColor: flat ? ((pressed) ? Style.backgroundColor : Style.backgroundColor) :
        !enabled ? (Style.buttonDisabledColor) :
       (highlighted ? Style.buttonAccentColor : Style.buttonColor )

    property color rippleColor: Style.rippleColor(flat ? Style.RippleBackground.Background : (highlighted ? Style.RippleBackground.Accent : Style.RippleBackground.Primary ))

    property double radius: height/2

    icon.width: Style.fab.iconWidth
    icon.height: Style.fab.iconWidth
    icon.color: foregroundColor

    highlighted: true
    display: type === Style.FabType.Extended ? AbstractButton.TextBesideIcon : AbstractButton.IconOnly

    property double elevation: (down || hovered) ? Style.fab.pressedElevation : Style.fab.elevation

    scale: enabledScale ? (enabled ? 1 : 0.0) : 1
    property double scaleDuration: 200
    Behavior on scale { NumberAnimation { easing.type: Easing.InOutQuad; duration: control.scaleDuration } }

    property bool enabledScale: true
    property bool extendedOnHovered: false

    contentItem: IconLabel
    {
        id: _iconLabel
        spacing: control.spacing
        display: control.display
        icon: control.icon
        text: control.text
        font: control.font
        color: control.foregroundColor
    } // IconLabel

    background: Rectangle
    {
        implicitWidth: type === Style.FabType.Extended ? Style.fab.minWidthExtended :
                       type === Style.FabType.Mini ? Style.fab.minWidthMini : Style.fab.minWidth
        implicitHeight: type === Style.FabType.Extended ? Style.fab.minHeightExtended :
                       type === Style.FabType.Mini ? Style.fab.minWidthMini : Style.fab.minWidth

        DebugRectangle
        {
            anchors.fill: parent
            border.color: "aquamarine"
            visible: control.drawline
        }

        radius: control.radius
        color: control.backgroundColor
        // The layer is disabled when the button color is transparent so you can do
        // Material.background: "transparent" and get a proper flat button without needing
        // to set Material.elevation as well
        layer.enabled: control.enabled && (control.backgroundColor.a > 0) && control.elevation > 0
        layer.effect: ElevationEffect
        {
            elevation: control.elevation
        }

        Ripple
        {
            id: ripple
            property bool isActive: control.down || control.visualFocus || control.hovered
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            pressed: control.pressed
            anchor: control
            active: isActive
            color: control.rippleColor
            layer.enabled: true
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
