/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qaterial
import Qaterial as Qaterial

Qaterial.OutlinedFabButton
{
  rippleClip: true
  scaleDuration: 100
  property bool isActive: hovered || down || visualFocus
  scale: isActive ? 1.0 : 0.9
} // OutlinedFabButton
