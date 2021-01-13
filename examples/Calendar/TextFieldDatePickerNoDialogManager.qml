import QtQuick 2.0

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.TextFieldDate
{
  id: root

  // Select min & max in the picker
  from: new Date(2000, 0, 5)
  to: new Date(2001, 5, 12)

  //select a Date
  date: new Date(2000, 5, 14)

  trailingVisible: true
  trailingInline: true
  trailingContent: Qaterial.TextFieldButtonContainer
  {
    Qaterial.TextFieldIconButton
    {
      icon.source: Qaterial.Icons.calendar
      onClicked: () => dataDialog.open()

      Qaterial.DatePickerDialog
      {
        id: dataDialog

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
      }
    }
  }
}
