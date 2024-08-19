/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick

// Qaterial
import Qaterial as Qaterial

Qaterial.OutlinedFabButton
{
  property color color
  backgroundColor: color

  borderWidth: 2
  borderColor: hovered || pressed ? Qaterial.Style.primaryTextColor() : Qaterial.Style.secondaryTextColor()
}
