import QtQuick 2.12

import Qaterial 1.0 as Qaterial

Column
{
  id: root

  property int month: _calendar.today.getMonth()
  property int year: _calendar.today.getFullYear()

  property date from: new Date(1900, 0, 1)
  property date to: new Date(2100, 0, 1)
  property date date

  signal yearClicked()
  signal monthClicked()
  signal moved(int month, int year)
  signal accepted(date date)

  Qaterial.CalendarNavigationBar
  {
    month: root.month
    year: root.year

    onPreviousMonth: function()
    {
      if(root.month)
      {
        if(Qaterial.Calendar.isMonthYearValid(from, to, root.month - 1, root.year))
          --root.month
      }
      else
      {
        if(Qaterial.Calendar.isMonthYearValid(from, to, 11, root.year - 1))
        {
          root.month = 11
            --root.year
        }
      }
    }

    onNextMonth: function()
    {
      if(root.month < Qaterial.Calendar.Month.December)
      {
        if(Qaterial.Calendar.isMonthYearValid(from, to, root.month + 1, root.year))
          ++root.month
      }
      else
      {
        if(Qaterial.Calendar.isMonthYearValid(from, to, 0, root.year + 1))
        {
          root.month = 0
            ++root.year
        }
      }
    }

    onYearClicked: () => root.yearClicked()
    onMonthClicked: () => root.monthClicked()
  }

  Qaterial.CalendarDayPickerView
  {
    id: _calendar

    date: root.date
    month: root.month
    year: root.year
    from: root.from
    to: root.to

    Binding on month { value: root.month }
    Binding on year { value: root.year }

    onMoved: function(month, year)
    {
      root.year = year
      root.month = month
      root.moved(month, year)
    }

    onAccepted: function(date)
    {
      root.date = date
      root.accepted(date)
    }
  }
}
