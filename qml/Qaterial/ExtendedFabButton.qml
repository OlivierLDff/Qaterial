/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.FabButton
{
  id: _control
  flat: false
  highlighted: true

  leftPadding: Qaterial.Style.fab.padding
  rightPadding: Qaterial.Style.fab.padding

  contentItem: Qaterial.FabIconLabel
  {
    id: _iconLabel
    spacing: _control.spacing
    display: _control.display
    icon: _control.icon
    text: _control.text
    font: _control.font
    color: _control.foregroundColor
  } // FabIconLabel

  property bool extended: (!extendedOnHovered || extendedOnHovered && (hovered || down || visualFocus)) && text != ""

  type: extended ? Qaterial.Style.FabType.Extended : Qaterial.Style.FabType.Default
} // FabButton
