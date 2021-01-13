import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.CalendarNavigationBar
{
  month: Qaterial.Calendar.Month.February
  year: 2015

  onNextMonth: () => console.log(`Next Clicked`)
  onPreviousMonth: () => console.log(`Previous Clicked`)
  onMonthClicked: () => console.log(`Month Clicked`)
  onYearClicked: () => console.log(`Year Clicked`)
}
