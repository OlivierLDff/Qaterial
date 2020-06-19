/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial
Item
{
  id: root

  property int hour
  property int minute

  signal accepted(int hour, int minute)

  Qaterial.TextFieldIconButton
  {
    icon.source: Qaterial.Icons.clock
    onClicked: Qaterial.DialogManager.openFromComponent(_TimePickerDialog)
  } // TextFieldIconButton

  Component
  {
    id: _TimePickerDialog
    Qaterial.TimePickerDialog
    {
      hour: root.hour
      minute: root.minute
      onAccepted: () => root.accepted(hour, minute)
      Component.onCompleted: open()
    }
  } // Component
}