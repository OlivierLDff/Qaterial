import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Column
{
  Qaterial.CalendarDayGrid
  {
    id: _grid

    // Choose displayed month
    month: Qaterial.Calendar.Month.February

    // Choose displayed year
    year: 2008

    // Choose the interval of date for the calendar
    from: new Date(2010, 0, 3)
    to: new Date(2010, 0, 25)

    // Called when user pick a date
    onAccepted: (date) => console.log(`Accept date ${date}`)
  }

  Qaterial.Label { text: `date : ${_grid.date}` }
  Qaterial.Label { text: `month : ${Qaterial.Calendar.monthToString(_grid.month)}` }
  Qaterial.Label { text: `year : ${_grid.year}` }
  Qaterial.Label { text: `from : ${_grid.from}` }
  Qaterial.Label { text: `to : ${_grid.to}` }
}
