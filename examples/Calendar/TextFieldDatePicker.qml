import QtQuick 2.0

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.TextFieldDatePicker
{
  id: root
  //Define the interval of dates
  from: new Date(2000, 0, 5)
  to: new Date(2001, 5, 12)

  //select a Date
  date: new Date(2000, 5, 14)
}
