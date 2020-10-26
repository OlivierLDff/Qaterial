pragma Singleton

import QtQml 2.12

QtObject
{
  enum Month
  {
    January = 0,
      February,
      March,
      April,
      May,
      June,
      July,
      August,
      September,
      October,
      November,
      December
  }

  property
  var months: [
    qsTr("January"),
    qsTr("February"),
    qsTr("March"),
    qsTr("April"),
    qsTr("May"),
    qsTr("June"),
    qsTr("July"),
    qsTr("August"),
    qsTr("September"),
    qsTr("October"),
    qsTr("November"),
    qsTr("December")
  ]

  enum Day
  {
    Sunday = 0,
      Monday,
      Tuesday,
      Wednesday,
      Thursday,
      Friday,
      Saturday
  }

  property
  var days: [
    qsTr("Sunday"),
    qsTr("Monday"),
    qsTr("Tuesday"),
    qsTr("Wednesday"),
    qsTr("Thursday"),
    qsTr("Friday"),
    qsTr("Saturday")
  ]

  function isDateValid(from, to, date)
  {
    if(isNaN(from) && isNaN(to))
      return true
    if(isNaN(from))
      return date <= to
    if(isNaN(to))
      return from <= date
    return (from <= date) && (date <= to)
  }

  function isMonthYearValid(from, to, month, year)
  {
    if(isNaN(from) && isNaN(to))
      return true
    if(isNaN(from))
      return new Date(year, month, 1) <= to
    if(isNaN(to))
      return from <= new Date(year, month, new Date(year, month + 1, 0)
        .getDate())
    return (from <= new Date(year, month, new Date(year, month + 1, 0)
      .getDate())) && (new Date(year, month, 1) <= to)
  }

  function monthToString(month)
  {
    return months[month]
  }

  function dayToString(day)
  {
    return days[day]
  }
}
