import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.CalendarMonthPickerView
{
  month: Qaterial.Calendar.Month.April

  //Width min : 100; Height min : 35
  width: 200
  height: 150

  //Clip to true for a better esthetic
  clip: true

  // Called when user pick a date
  onAccepted: (month) => console.log(`Accept month ${Qaterial.Calendar.monthToString(month)}`)
}
