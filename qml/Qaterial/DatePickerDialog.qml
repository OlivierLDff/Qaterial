/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.ModalDialog
{
  id: root

  property int month: new Date()
    .getMonth()
  property int year: new Date()
    .getFullYear()

  property date from: new Date(1900, 0, 1)
  property date to: new Date(2099, 11, 31)
  property date date

  property bool monthGridActive: false
  property bool yearGridActive: false
  property bool calendarViewActive: true

  padding: 0

  standardButtons: Dialog.Ok | Dialog.Cancel

  signal accepted(date date)

  header: Qaterial.CalendarDateDisplay
  {
    function printDate()
    {
      var m = Qaterial.Calendar.monthToString(root.date.getMonth())
      var date = root.date.getDate()
      var day = Qaterial.Calendar.dayToString(root.date.getDay())

      var y = root.date.getFullYear()
      var dateString = `${day[0]}${day[1]}${day[2]}, ${m[0]}${m[1]}${m[2]} ${date}, ${y}`

      return dateString
    }
    width: 500

    text: isNaN(root.date) ? `Pick a Date` : printDate()
  } // CalendarDateDisplay

  contentItem: Item
  {
    Loader
    {
      sourceComponent:
      {
        if(root.calendarViewActive)
        {
          return _calendarView
        }
        else if(root.yearGridActive)
        {
          return _calendarYearPicker
        }
        else if(root.monthGridActive)
        {
          return _calendarMonthPicker
        }
      }
    } // Loader
    Component
    {
      id: _calendarYearPicker
      Qaterial.CalendarYearPickerView
      {
        clip: true

        year: root.year
        startYear: root.from.getFullYear()
        endYear: root.to.getFullYear()
        Binding on year
        {
          value: root.year
        }
        onAccepted: function(year)
        {
          if(Qaterial.Calendar.isMonthYearValid(root.from, root.to, month, year))
          {
            root.year = year
          }
          else
          {
            console.warn(`Select a year in the interval : [${root.from.toString()} ; ${root.to.toString()}]`)
          }
          root.calendarViewActive = true
          root.yearGridActive = false
        }
      } // CalendarYearPickerView
    } // Component

    Component
    {
      id: _calendarMonthPicker
      Qaterial.CalendarMonthPickerView
      {
        clip: true

        month: root.month
        Binding on month
        {
          value: root.month
        }
        onAccepted: function(month)
        {
          if(Qaterial.Calendar.isMonthYearValid(root.from, root.to, month, year))
          {
            root.month = month
          }
          else
          {
            console.warn(`Select a month in the interval : [${root.from.toString()} ; ${root.to.toString()}]`)
          }
          root.calendarViewActive = true
          root.monthGridActive = false
        }
      } // CalendarMonthPickerView
    } // Component

    Component
    {
      id: _calendarView
      Qaterial.CalendarView
      {
        visible: root.calendarViewActive
        year: root.year
        from: root.from
        to: root.to

        clip: true
        Binding on year
        {
          value: root.year
        }
        month: root.month
        Binding on month
        {
          value: root.month
        }
        date: root.date

        onMoved: function()
        {
          root.year = year
          root.month = month
        }

        onMonthClicked: function()
        {
          root.monthGridActive = true
          root.calendarViewActive = false
        }

        onYearClicked: function()
        {
          root.yearGridActive = true
          root.calendarViewActive = false
        }

        onAccepted: function(date)
        {
          console.log(`dateView : ${date}`)
          root.date = date
          root.accepted(date)
        }
      } // CalendarView
    } // Component
  } // Item
} // ModalDialog
