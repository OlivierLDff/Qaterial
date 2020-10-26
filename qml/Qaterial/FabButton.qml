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
import Qaterial 1.0 as Qaterial

T.Button
{
  id: _control

  implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    implicitContentWidth + leftPadding + rightPadding)
  implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    implicitContentHeight + topPadding + bottomPadding)

  Behavior on implicitWidth
  {
    NumberAnimation { easing.type: Easing.InOutQuad;
      duration: 200 } // NumberAnimation
  } // Behavior

  Behavior on implicitHeight
  {
    NumberAnimation { easing.type: Easing.InOutQuad;
      duration: 200 } // NumberAnimation
  } // Behavior

  property bool drawline: Qaterial.Style.debug.drawDebugButton

  Qaterial.DebugRectangle
  {
    anchors.fill: parent
    border.color: "pink"
    visible: _control.drawline
  } // DebugRectangle

  topInset: Qaterial.Style.fab.topInset
  bottomInset: Qaterial.Style.fab.bottomInset
  leftInset: Qaterial.Style.fab.leftInset
  rightInset: Qaterial.Style.fab.rightInset

  font.family: Qaterial.Style.textTypeToFontFamily(Qaterial.Style.TextType.Button)
  font.styleName: Qaterial.Style.textTypeToStyleName(Qaterial.Style.TextType.Button)
  font.pixelSize: Qaterial.Style.textTypeToPixelSize(Qaterial.Style.TextType.Button)
  font.capitalization: Qaterial.Style.fontCapitalization(Qaterial.Style.TextType.Button)
  font.letterSpacing: Qaterial.Style.textTypeToLetterSpacing(Qaterial.Style.TextType.Button)

  readonly property bool defaultPadding:
  {
    if(type === Qaterial.Style.FabType.Default)
      return Qaterial.Style.fab.padding
    return (type === Qaterial.Style.FabType.Mini) ? Qaterial.Style.fab.paddingMini : Qaterial.Style.fab.textPadding
  }

  leftPadding:
  {
    if(type === Qaterial.Style.FabType.Extended)
      return (mirrored ? Qaterial.Style.fab.textPadding : Qaterial.Style.fab.iconPadding) + leftInset
    return defaultPadding + leftInset
  }
  rightPadding:
  {
    if(type === Qaterial.Style.FabType.Extended)
      return (mirrored ? Qaterial.Style.fab.iconPadding : Qaterial.Style.fab.textPadding) + rightInset
    return defaultPadding + rightInset
  }

  topPadding: 0
  bottomPadding: 0
  spacing: Qaterial.Style.fab.spacing

  // Qaterial.Style.FabType.Default | Qaterial.Style.FabType.Mini | Qaterial.Style.FabType.Extended
  property int type: (extendedOnHovered && hovered && text != "") ? Qaterial.Style.FabType.Extended : Qaterial.Style
    .FabType.Default

  property color foregroundColor:
  {
    if(!enabled)
      return flat ? Qaterial.Style.disabledTextColor() : Qaterial.Style.disabledTextColor()
    if(flat && highlighted)
      return Qaterial.Style.buttonAccentColor
    return flat ? Qaterial.Style.secondaryTextColor() : Qaterial.Style.buttonTextColor
  }

  property color backgroundColor:
  {
    if(flat)
      return pressed ? Qaterial.Style.backgroundColor : Qaterial.Style.backgroundColor
    if(!enabled)
      return Qaterial.Style.buttonDisabledColor
    return highlighted ? Qaterial.Style.buttonAccentColor : Qaterial.Style.buttonColor
  }

  property color rippleColor:
  {
    if(flat)
      return Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.Background)
    if(highlighted)
      return Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.Accent)
    return Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.Primary)
  }

  property double radius: height / 2

  icon.width: Qaterial.Style.fab.iconWidth
  icon.height: Qaterial.Style.fab.iconWidth
  icon.color: foregroundColor

  highlighted: true
  display: (type === Qaterial.Style.FabType.Extended) ? AbstractButton.TextBesideIcon : AbstractButton.IconOnly

  property double elevation: (down || hovered) ? Qaterial.Style.fab.pressedElevation : Qaterial.Style.fab.elevation

  scale: enabledScale ? (enabled ? 1 : 0.0) : 1
  property double scaleDuration: 200
  Behavior on scale { NumberAnimation { easing.type: Easing.InOutQuad;
      duration: _control.scaleDuration } }

  property bool enabledScale: true
  property bool extendedOnHovered: false

  contentItem: Qaterial.IconLabel
  {
    id: _iconLabel
    spacing: _control.spacing
    display: _control.display
    icon: _control.icon
    text: _control.text
    font: _control.font
    color: _control.foregroundColor
  } // IconLabel

  background: Rectangle
  {
    implicitWidth: (type === Qaterial.Style.FabType.Extended) ? Qaterial.Style.fab.minWidthExtended : ((type ===
      Qaterial.Style.FabType.Mini) ? Qaterial.Style.fab.minWidthMini : Qaterial.Style.fab.minWidth)
    implicitHeight: (type === Qaterial.Style.FabType.Extended) ? Qaterial.Style.fab.minHeightExtended : ((type ===
      Qaterial.Style.FabType.Mini) ? Qaterial.Style.fab.minWidthMini : Qaterial.Style.fab.minWidth)

    Qaterial.DebugRectangle
    {
      anchors.fill: parent
      border.color: "aquamarine"
      visible: _control.drawline
    } // DebugRectangle

    radius: _control.radius
    color: _control.backgroundColor
    // The layer is disabled when the button color is transparent so you can do
    // Material.background: "transparent" and get a proper flat button without needing
    // to set Material.elevation as well
    layer.enabled: _control.enabled && (_control.backgroundColor.a > 0) && _control.elevation > 0
    layer.effect: Qaterial.ElevationEffect
    {
      elevation: _control.elevation
    } // ElevationEffect

    Qaterial.Ripple
    {
      id: ripple
      property bool isActive: _control.down || _control.visualFocus || _control.hovered
      width: parent.width
      height: parent.height
      anchors.centerIn: parent
      pressed: _control.pressed
      anchor: _control
      active: isActive
      color: _control.rippleColor
      layer.enabled: true
      layer.effect: OpacityMask
      {
        maskSource: Rectangle
        {
          width: ripple.width
          height: ripple.height
          radius: _control.radius
        } // Rectangle
      } // OpacityMask
    } // Ripple
  } // Rectangle
} // Button
