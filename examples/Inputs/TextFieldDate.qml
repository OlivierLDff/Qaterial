import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.TextFieldDate
{
  //choose a date Interval

  from: new Date(2001, 0, 2)
  to: new Date(2001, 11, 2)

  //Choose a predefined date
  date: new Date(2001, 5, 4)

  onAccepted: () => console.log(`Date Accepted : ${date}`)
}
