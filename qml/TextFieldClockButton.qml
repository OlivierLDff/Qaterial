/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.TextFieldIconButton
{
  id: root

  property int hour
  property int minute
  property bool styleAm
  property bool am

  signal accepted(int hour, int minute, bool am)

  icon.source: Qaterial.Icons.clock
  onClicked: Qaterial.DialogManager.openFromComponent(_TimePickerDialog)

  Component
  {
    id: _TimePickerDialog
    Qaterial.TimePickerDialog
    {
      hour: root.hour
      minute: root.minute
      styleAm: root.styleAm
      am: root.am
      onAccepted: () => root.accepted(hour, minute, am)
      Component.onCompleted: open()
    }
  } // Component
} // TextFieldIconButton