import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml 2.15

import Qaterial 1.0 as Qaterial

ListView
{
  id: root
  readonly property date today: new Date()
  property date currentDate
  property date date: currentDate

  property date from: new Date(1900, 0, 1)
  property date to: new Date(2100, 0, 1)
  property int month: today.getMonth()
  property int year: today.getFullYear()

  signal accepted(date date)
  signal moved(int month, int year)

  property bool _monthAndYearPendingEvaluate

  onCurrentIndexChanged: function()
  {
    _monthAndYearPendingEvaluate = true
    month = getMonthFromIndex(currentIndex)
    year = getYearFromIndex(currentIndex)
    _monthAndYearPendingEvaluate = false
    root.moved(month, year)
  }

  implicitWidth: 280
  implicitHeight: 280
  orientation: ListView.Horizontal
  snapMode: ListView.SnapToItem
  model: monthSinceDate(from, to)
  spacing: 16
  Binding on currentIndex
  {
    when: !_monthAndYearPendingEvaluate
    value: indexFromMonthYear(from, to, month, year)
    restoreMode: Binding.RestoreBinding
  }
  highlightMoveDuration: 5
  highlightRangeMode: ListView.StrictlyEnforceRange

  // Return currentIndex of 'date' based of 'from' date
  function monthSinceDate(from, to)
  {
    const yearDelta = to.getFullYear() - from.getFullYear()
    const monthDelta = to.getMonth()+1 - from.getMonth()

    if((yearDelta*12 + monthDelta)>0)
    {
      return yearDelta*12 + monthDelta
    }
    else
    {
      console.warn(`Date from ${from} greater than date to ${to}.`)
      return 0
    }
  }

  function indexFromMonthYear(from, to, month, year)
  {
    const yearDelta = year - from.getFullYear()
    const monthDelta = month - from.getMonth()

    if(Qaterial.Calendar.isMonthYearValid(from, to, month, year))
    {
      return yearDelta*12 + monthDelta
    }
    else
    {
      console.warn(`Year ${year} and Month ${month} not in the interval [${from}, ${to}]. Make sure 'month' & 'year' are in between 'from' and 'to'. Or increase 'from' and 'to' to match your needs`)
      month = from.getMonth()
      year = from.getFullYear()

      console.log(`year ${year}`)
      console.log(`from.getFullYear( ${from.getFullYear()}`)

      yearDelta = year - from.getFullYear()
      monthDelta = month - from.getMonth()

      return yearDelta*12 + monthDelta
    }
  }

  function getMonthFromIndex(index)
  {
    return ((index - Math.floor(index/12)*12) + from.getMonth())%12
  }

  function getYearFromIndex(index)
  {
    return from.getFullYear() + Math.floor((index + from.getMonth())/12)
  }

  delegate: Qaterial.CalendarDayPicker
  {
    date: root.date
    month: root.getMonthFromIndex(index)
    year: root.getYearFromIndex(index)
    from: root.from
    to: root.to

    onAccepted: function(date)
    {
      root.currentDate = date
      root.accepted(date)
      //console.log(`date = ${date}`)
    }
  } // CalendarDayPicker
} // ListView

/*TEST FONCTIONS*/

//console.log(monthfromIndex(new Date(1900,5,1), 47) + " == 4")
//console.log(monthfromIndex(new Date(1900,0,1), 15) + "== 3 ")
//console.log(monthfromIndex(new Date(1900,5,1), 15) + "== 8 ")

//console.log(yearFromIndex(new Date(1900,5,1), 47) + " == 1904")
//console.log(yearFromIndex(new Date(1900,0,1), 15) + "== 1901 ")
//console.log(yearFromIndex(new Date(1900,5,1), 15) + "== 1901 ")
//console.log(yearFromIndex(new Date(1900,0,1), 160) + "== 1913 ")
//console.log(yearFromIndex(new Date(1900,5,1), 160) + "== 1913 ")
//console.log(yearFromIndex(new Date(1900,6,1), 160) + "== 1913 ")
//console.log(yearFromIndex(new Date(1900,7,1), 160) + "== 1913 ")
//console.log(yearFromIndex(new Date(1900,8,1), 160) + "== 1914 ")
