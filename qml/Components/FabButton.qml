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

T.Button
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    Behavior on implicitWidth { NumberAnimation { easing.type: Easing.InOutQuad; duration: 200 } }
    Behavior on implicitHeight { NumberAnimation { easing.type: Easing.InOutQuad; duration: 200 } }

    property bool drawline: MaterialStyle.debug.drawDebugButton

    DebugRectangle
    {
        anchors.fill: parent
        border.color: "pink"
        visible: control.drawline
    }

    topInset: MaterialStyle.fab.topInset
    bottomInset: MaterialStyle.fab.bottomInset
    leftInset: MaterialStyle.fab.leftInset
    rightInset: MaterialStyle.fab.rightInset

    font.family: MaterialStyle.fab.fontFamily
    font.pointSize: MaterialStyle.fab.fontPointSize
    font.capitalization: MaterialStyle.fab.fontCapitalisation
    font.styleName: MaterialStyle.fab.fontStyleName

    readonly property bool defaultPadding: type === MaterialStyle.FabType.Default ? MaterialStyle.fab.padding : 
    	(type === MaterialStyle.FabType.Mini ? MaterialStyle.fab.paddingMini : MaterialStyle.fab.textPadding)

    leftPadding: (type === MaterialStyle.FabType.Extended ? (mirrored ? MaterialStyle.fab.textPadding : MaterialStyle.fab.iconPadding ) : defaultPadding) + leftInset
    rightPadding: (type === MaterialStyle.FabType.Extended ? (mirrored ? MaterialStyle.fab.iconPadding : MaterialStyle.fab.textPadding ) : defaultPadding) + rightInset

    topPadding: 0
    bottomPadding: 0
    spacing: MaterialStyle.fab.spacing

    // MaterialStyle.FabType.Default | MaterialStyle.FabType.Mini | MaterialStyle.FabType.Extended
    property int type: extendedOnHovered && hovered && text != "" ? MaterialStyle.FabType.Extended : MaterialStyle.FabType.Default

    property color foregroundColor: !enabled ? (flat ? MaterialStyle.disabledTextColor() : MaterialStyle.disabledTextColor()) :
        flat && highlighted ? MaterialStyle.buttonAccentColor : 
        flat ? MaterialStyle.secondaryTextColor() : MaterialStyle.buttonTextColor

    property color backgroundColor: flat ? ((pressed) ? MaterialStyle.backgroundColor : MaterialStyle.backgroundColor) : 
        !enabled ? (MaterialStyle.buttonDisabledColor) :
       (highlighted ? MaterialStyle.buttonAccentColor : MaterialStyle.buttonColor )

    property color rippleColor: MaterialStyle.rippleColor(flat ? MaterialStyle.RippleBackground.Background : (highlighted ? MaterialStyle.RippleBackground.Accent : MaterialStyle.RippleBackground.Primary ))

    property double radius: height/2

    icon.width: MaterialStyle.fab.iconWidth
    icon.height: MaterialStyle.fab.iconWidth
    icon.color: foregroundColor

    highlighted: true
    display: type === MaterialStyle.FabType.Extended ? AbstractButton.TextBesideIcon : AbstractButton.IconOnly

    property double elevation: (down || hovered) ? MaterialStyle.fab.pressedElevation : MaterialStyle.fab.elevation

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
        implicitWidth: type === MaterialStyle.FabType.Extended ? MaterialStyle.fab.minWidthExtended : 
                       type === MaterialStyle.FabType.Mini ? MaterialStyle.fab.minWidthMini : MaterialStyle.fab.minWidth
        implicitHeight: type === MaterialStyle.FabType.Extended ? MaterialStyle.fab.minHeightExtended : 
                       type === MaterialStyle.FabType.Mini ? MaterialStyle.fab.minWidthMini : MaterialStyle.fab.minWidth

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
