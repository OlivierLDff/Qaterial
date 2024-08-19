import QtQuick
import Qaterial as Qaterial

Qaterial.CalendarNavigationBar
{
  month: Qaterial.Calendar.Month.February
  year: 2015

  onNextMonth: () => console.log(`Next Clicked`)
  onPreviousMonth: () => console.log(`Previous Clicked`)
  onMonthClicked: () => console.log(`Month Clicked`)
  onYearClicked: () => console.log(`Year Clicked`)
}
