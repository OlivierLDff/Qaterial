/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.Pane
{
  id: _control
  padding: 0
  property bool onPrimary: false
  property bool colorReversed: onPrimary && Qaterial.Style.shouldReverseForegroundOnPrimary

  radius: Qaterial.Style.card.radius

  property alias backgroundColor: _control.palette.base
  //property color backgroundColor: onPrimary ? Qaterial.Style.primaryColor : Qaterial.Style.cardColor
  property color borderColor: enabled ? Qaterial.Style.dividersColor() : Qaterial.Style.disabledDividersColor()
  property bool outlined: false

  property double elevation:
  {
    if(isActive)
      return Qaterial.Style.card.activeElevation
    return outlined ? 0 : Qaterial.Style.card.defaultElevation
  }

  property bool isActive: (elevationOnHovered && hovered) || pressed || visualFocus

  property string headerText
  property string subHeaderText
  property string supportingText
  property string media
  property string thumbnail

  property bool pressed: false
  property bool elevationOnHovered: false

  palette.base: Qaterial.Style.colorTheme.background8

  background: Qaterial.CardBackground
  {
    id: _cardBackground
    isActive: _control.isActive
    onPrimary: _control.onPrimary
    enabled: _control.enabled
    radius: _control.radius
    color: _control.backgroundColor
    borderColor: _control.borderColor
    outlined: _control.outlined
    elevation: _control.elevation
  } // CardBackground
} // Pane
