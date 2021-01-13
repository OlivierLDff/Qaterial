/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.RawMaterialButton
{
  id: _control
  flat: true
  highlighted: checked
  clipRipple: false

  icon.width: Qaterial.Style.fab.iconWidth
  icon.height: Qaterial.Style.fab.iconWidth

  leftPadding: Qaterial.Style.fab.iconPadding
  rightPadding: Qaterial.Style.fab.iconPadding
  //topPadding: 0
  //bottomPadding: 0

  //topInset: 0
  //bottomInset: 0
  //leftInset: Qaterial.Style.fab.iconPadding
  //rightInset: Qaterial.Style.fab.iconPadding

  backgroundImplicitWidth: Qaterial.Style.toolButton
    .minWidth /*- Math.max(leftInset + rightInset, topInset + bottomInset)*/
  backgroundImplicitHeight: Qaterial.Style.toolButton
    .minHeight /*- Math.max(leftInset + rightInset, topInset + bottomInset)*/

  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  property bool accentColorAuthorized: (onPrimary && Qaterial.Style.preferAccentOnPrimary || !onPrimary)

  foregroundColor:
  {
    if(!enabled)
    {
      if(colorReversed)
        return Qaterial.Style.disabledTextColorReversed()
      return Qaterial.Style.disabledTextColor()
    }
    if(highlighted && accentColorAuthorized)
      return Qaterial.Style.accentColor
    if(!highlighted && !accentColorAuthorized)
      return colorReversed ? Qaterial.Style.secondaryTextColorReversed() : Qaterial.Style.secondaryTextColor()
    return colorReversed ? Qaterial.Style.primaryTextColorReversed() : Qaterial.Style.primaryTextColor()
  }

  property double animationSpeed: 0
  onCheckedChanged: animationSpeed = checked ? 0 : 300

  Behavior on foregroundColor
  {
    ColorAnimation
    {
      easing.type: Easing.InOutQuad
      duration: _control.animationSpeed
    } // ColorAnimation
  } // Behavior

  Behavior on backgroundColor
  {
    ColorAnimation
    {
      easing.type: Easing.InOutQuad
      duration: _control.animationSpeed
    } // ColorAnimation
  } // Behavior
} // RawMaterialButton
