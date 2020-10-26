import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.CalendarYearPickerView
{
  id: _view

  year: 1950
  startYear: 1900
  endYear: 2100

  //Clip to true for a better esthetic
  clip: true

  // Called when user pick a year
  onAccepted: (year) => console.log(`Accept year ${year}`)
}
