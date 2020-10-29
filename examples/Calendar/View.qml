import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.CalendarView
{
  id: _view

  year: 2000
  month: Qaterial.Calendar.Month.April

  from: new Date(2000, 1, 29)
  to: new Date(2001, 2, 1)

  // Called when user pick a year
  onAccepted: (date) => console.log(`Accepted date ${date}`)
  onMoved: (month, year) => console.log(`Year ${year} And Month ${month}`)
  onYearClicked: () => console.log(`YearButton clicked`)
  onMonthClicked: () => console.log(`MonthButton clicked`)
}
