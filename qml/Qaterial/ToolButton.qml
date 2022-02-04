/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qaterial
import Qaterial as Qaterial
import Qaterial.Qt5Compat as Qaterial

Qaterial.SquareButton
{
  highlighted: checked || pressed
  forceRipple: checked
  accentRipple: highlighted
  checkable: true
  useSecondaryColor: true
} // SquareButton
