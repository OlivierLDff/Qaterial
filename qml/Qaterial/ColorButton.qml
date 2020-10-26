/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.OutlinedFabButton
{
  property color color
  backgroundColor: color

  borderWidth: 2
  borderColor: hovered || pressed ? Qaterial.Style.primaryTextColor() : Qaterial.Style.secondaryTextColor()
}
