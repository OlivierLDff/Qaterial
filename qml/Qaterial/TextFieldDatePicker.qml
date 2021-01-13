import QtQuick 2.0

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.TextFieldDate
{
  id: root

  trailingVisible: true
  trailingInline: true
  trailingContent: Qaterial.TextFieldButtonContainer
  {
    Qaterial.TextFieldIconButton
    {
      icon.source: Qaterial.Icons.calendar
      onClicked: Qaterial.DialogManager.openFromComponent(_datePickerDialogComponent)

      Component
      {
        id: _datePickerDialogComponent
        Qaterial.DatePickerDialog
        {
          date: root.date
          month: isNaN(date) ? new Date()
            .getMonth() : root.date.getMonth()
          year: isNaN(date) ? new Date()
            .getFullYear() : root.date.getFullYear()

          from: root.from
          to: root.to

          onAccepted: function()
          {
            root.date = date
            root.accepted(date)
          }
          Component.onCompleted: open()
        }
      }
    }
  }
}
