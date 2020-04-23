/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.SquareButton
{
  highlighted: checked || pressed
  forceRipple: checked
  accentRipple: highlighted
  checkable: true
  useSecondaryColor: true
} // SquareButton
