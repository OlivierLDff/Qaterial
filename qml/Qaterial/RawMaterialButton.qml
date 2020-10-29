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

  property bool drawline: Qaterial.Style.debug.drawDebugButton
  Qaterial.DebugRectangle { anchors.fill: parent;
    border.color: "pink";
    visible: _control.drawline } // DebugRectangle

  property int textType: Qaterial.Style.TextType.Button
  property int elide: Text.ElideNone

  topInset: Qaterial.Style.rawButton.topInset
  bottomInset: Qaterial.Style.rawButton.bottomInset
  leftInset: Qaterial.Style.rawButton.leftInset
  rightInset: Qaterial.Style.rawButton.rightInset

  leftPadding:
  {
    if(icon.source != "" && !mirrored || text == "")
      return Qaterial.Style.rawButton.iconPadding + leftInset

    if(flat && !outlined)
      return Qaterial.Style.rawButton.spacing + leftInset
    return Qaterial.Style.rawButton.padding + leftInset
  }
  rightPadding:
  {
    if(icon.source != "" && mirrored || text == "")
      return Qaterial.Style.rawButton.iconPadding + rightInset

    if(flat && !outlined)
      return Qaterial.Style.rawButton.spacing + rightInset
    return Qaterial.Style.rawButton.padding + rightInset
  }

  topPadding: 0
  bottomPadding: 0
  spacing: Qaterial.Style.rawButton.spacing

  property bool outlined: false

  property color foregroundColor:
  {
    if(!enabled)
      return Qaterial.Style.disabledTextColor()
    if(flat && highlighted)
      return Qaterial.Style.accentColor
    return colorReversed ? Qaterial.Style.primaryTextColorReversed() : Qaterial.Style.primaryTextColor()
  }
  property color backgroundColor:
  {
    if(flat)
      return (outlined && pressed) ? Qaterial.Style.backgroundColor : "transparent"
    if(!enabled)
      return Qaterial.Style.buttonDisabledColor
    return highlighted ? Qaterial.Style.accentColor : Qaterial.Style.buttonColor
  }

  readonly property int flatRippleColor: onPrimary ? Qaterial.Style.RippleBackground.Primary : Qaterial.Style
    .RippleBackground.Background
  readonly property int rawRippleColor: highlighted ? Qaterial.Style.RippleBackground.Accent : Qaterial.Style
    .RippleBackground.Primary

  property color rippleColor:
  {
    if(accentRipple)
      return Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.AccentLight)
    return Qaterial.Style.rippleColor(flat ? flatRippleColor : rawRippleColor)
  }

  property color outlinedColor:
  {
    if(!outlined)
      return "transparent"
    if(!enabled)
      return Qaterial.Style.disabledDividersColor()
    if(pressed)
      return foregroundColor
    return Qaterial.Style.dividersColor()
  }

  property bool onPrimary: false
  property bool colorReversed: (flat && onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary) ||
    (highlighted && Qaterial.Style.shouldReverseForegroundOnAccent) ||
    (!flat && !highlighted && Qaterial.Style.shouldReverseForegroundOnPrimary)

  property double radius: Qaterial.Style.rawButton.cornerRadius

  icon.width: Qaterial.Style.rawButton.iconWidth
  icon.height: Qaterial.Style.rawButton.iconWidth
  icon.color: foregroundColor

  property double elevation:
  {
    if(flat)
      return (_control.down || _control.hovered) ? Qaterial.Style.rawButton.flatPressedElevation : Qaterial.Style
      .rawButton.flatElevation
    return _control.down ? Qaterial.Style.rawButton.defaultPressedElevation : Qaterial.Style.rawButton
      .defaultElevation
  }

  property bool clipRipple: true
  property bool forceRipple: false
  property bool accentRipple: false

  contentItem: Qaterial.IconLabel
  {
    textType: _control.textType
    spacing: _control.spacing
    display: _control.display
    icon: _control.icon
    text: _control.text
    color: _control.foregroundColor

    elide: _control.elide
  } // IconLabel

  property double backgroundImplicitWidth: Qaterial.Style.rawButton.minWidth
  property double backgroundImplicitHeight: Qaterial.Style.rawButton.minHeight

  background: Rectangle
  {
    Qaterial.DebugRectangle { anchors.fill: parent;
      border.color: "aquamarine";
      visible: _control.drawline } // DebugRectangle

    implicitWidth: _control.backgroundImplicitWidth
    implicitHeight: _control.backgroundImplicitHeight
    radius: _control.radius
    color: _control.backgroundColor
    border.width:
    {
      if(_control.outlined)
        return _control.pressed ? Qaterial.Style.rawButton.outlinedFocusWidth : Qaterial.Style.rawButton
        .outlinedWidth
      return 0
    }

    border.color: _control.outlinedColor
    // The layer is disabled when the button color is transparent so you can do
    // Material.background: "transparent" and get a proper flat button without needing
    // to set Material.elevation as well
    layer.enabled: _control.enabled && (_control.backgroundColor.a > 0)
    layer.effect: Qaterial.ElevationEffect
    {
      elevation: _control.elevation
    } // ElevationEffect

    Qaterial.Ripple
    {
      id: _ripple

      width: parent.width + (_control.outlined ? -2 : 0)
      height: parent.height + (_control.outlined ? -2 : 0)
      anchors.centerIn: parent

      pressed: _control.pressed
      anchor: _control
      active: _control.down || _control.visualFocus || _control.hovered || _control.forceRipple
      color: _control.rippleColor

      // trick because clipRadius isn't working in ripple private implementation (QTBUG-51894)
      layer.enabled: _control.clipRipple
      layer.effect: OpacityMask
      {
        maskSource: Rectangle
        {
          width: _ripple.width
          height: _ripple.height
          radius: _control.radius
        } // Rectangle
      } // OpacityMask
    } // Ripple
  } // Rectangle
} // Button
