/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick
import QtQuick.Controls

// Qaterial
import Qaterial 1.0 as Qaterial
import Qaterial.Qt5Compat 1.0 as Qaterial

Qaterial.FlatFabButton
{
  id: _control

  backgroundColor: "transparent"
  borderColor: enabled ? (highlighted ? Qaterial.Style.accentColor : Qaterial.Style.dividersColor()) : Qaterial.Style
    .disabledDividersColor()
  outlined: true

  foregroundColor: !enabled ? Qaterial.Style.disabledTextColor() : highlighted ? Qaterial.Style.accentColor : Qaterial
    .Style.primaryTextColor()
} // FlatFabButton
