import QtQuick 2.12
import QtQuick.Controls 2.12

import Qaterial 1.0 as Qaterial

Grid
{
  id: root

  // ---- SELECTED DAY ----

  property bool enabled: true

  property date from
  property date to

  // Selected date
  property date date
  Binding on date
  {
    when: _selectedDatePressed
    value: root._selectedDate
  }
  property date _selectedDate

  readonly property int _selectedMonth: date.getMonth()
  readonly property int _selectedYear: date.getFullYear()

  readonly property bool _selectedDayIsCurrentMonth: (month === _selectedMonth) && (year === _selectedYear)
  readonly property int _indexSelectedDay: _selectedDayIsCurrentMonth ? _indexFirstDateMonth - 2 + date.getDate() : -1

  property bool _selectedDatePressed

  // ---- TODAY ----

  // Hightlighted day that should be represent as today (nothing to do with date)
  readonly property date today: new Date()
  readonly property int _todayMonth: today.getMonth()
  readonly property int _todayYear: today.getFullYear()

  // Is today a day of the month controlled by 'month' and 'year' set by user
  readonly property bool _todayIsCurrentMonth: (month === _todayMonth) && (year === _todayYear)
  readonly property int _indexToday: _todayIsCurrentMonth ? _indexFirstDateMonth - 2 + today.getDate() : -1

  // ---- CURRENT MONTH / YEAR ----

  // Control the displayed month in the grid
  property int month: _todayMonth
  // Control the displayed year in the grid
  property int year: _todayYear

  // date object of the first day of the month controlled by 'month' and 'year' set by user
  readonly property date _firstDateMonth: new Date(year, month, 1)
  // Offset in the grid of the first day in current month controlled by 'month' and 'year' set by user
  readonly property int _indexFirstDateMonth: _firstDateMonth.getDay() ? _firstDateMonth.getDay() : 7

  // Number of day in month controlled by property 'month' and 'year' set by user
  //warning: add 1 to get the true number of days of the Month
  readonly property int _numberOfDays: new Date(year, month + 1, 0)
    .getDate();

  // Number of day in month previous month controlled by property 'month' and 'year' set by user
  //warning: add 1 to get the true number of days of the Month
  readonly property int _numberOfDaysPreviousMonth: month ? (new Date(year, month, 0))
    .getDate() : (new Date(year - 1, 12, 0))
    .getDate()

  readonly property bool showLastRow: ((_numberOfDays + _indexFirstDateMonth) > 36)

  // ---- SELECTED DAY CHOOSE BY USER ----

  signal accepted(date date)

  function _getPreviousMonthDate(index)
  {
    if(month)
      return new Date(year, month - 1, _numberOfDaysPreviousMonth + index - _indexFirstDateMonth + 2);
    return new Date(year - 1, 11, _numberOfDaysPreviousMonth + index - _indexFirstDateMonth + 2);
  }

  columns: 7

  Repeater
  {
    id: repeater
    model: root.showLastRow ? 42 : 35
    delegate: Qaterial.CalendarDateButton
    {
      id: dateButton

      readonly property date date: dateInTheMonth ? new Date(root.year, root.month, index + 2 - root
        ._indexFirstDateMonth) : root._getPreviousMonthDate(index)
      text: date.getDate()

      readonly property bool dateInTheMonth: ((index + 1) >= root._indexFirstDateMonth) && (index < (root
        ._indexFirstDateMonth + root._numberOfDays - 1))

      enabled: dateInTheMonth && root.enabled && Qaterial.Calendar.isDateValid(root.from, root.to, date)

      checked: root._indexSelectedDay === index
      highlighted: root._indexToday === index

      onClicked: function()
      {
        root._selectedDatePressed = true
        root._selectedDate = date

        root._selectedDatePressed = false
        root.accepted(date)
      }

      //Qaterial.ToolTip
      //{
      //  text: checked ? "Selected date": "Current day"
      //  visible: dateButton.hovered && (dateButton.checked || dateButton.highlighted)
      //}

      ToolTip.text: checked ? "Selected date" : "Current day"
      ToolTip.visible: hovered && (checked || highlighted)
    }
  }
  Component.onCompleted: () => _selectedDate = date
}
