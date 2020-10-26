import QtQuick 2.0

import Qaterial 1.0 as Qaterial

Column
{
  Qaterial.CalendarDayPickerView
  {
    id: _view

    // Choose displayed month
    month: Qaterial.Calendar.Month.January

    // Choose displayed year
    year: 2019

    // Choose intervall of dates

    from: new Date(2020, 0, 1)
    to: new Date(2020, 3, 1)

    // Can be required in order to show only current CalendarDayPicker
    clip: true

    // Called when user pick a date
    onAccepted: (date) => console.log(`Accept date ${date}`)

    // Called when user swip the view to go to another month/year
    onMoved: (month, year) => console.log(`Moved to month: ${month}, year: ${year}`)
  }

  Qaterial.Label { text: `date : ${_view.date}` }
  Qaterial.Label { text: `month : ${Qaterial.Calendar.monthToString(_view.month)}` }
  Qaterial.Label { text: `year : ${_view.year}` }
}
