import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.DatePickerDialog
{
  // Default Grid showed when dialog is opened
  month: Qaterial.Calendar.Month.January
  year: 2015

  onMonthChanged: () => console.log(
    `Grid Changed : month :${Qaterial.Calendar.monthToString(month)} & year : ${year}`)
  onYearChanged: () => console.log(`Grid Changed : month :${Qaterial.Calendar.monthToString(month)} & year : ${year}`)

  onAccepted: (date) => console.log(`User picked ${date.toString()}`)
  onRejected: () => console.log(`Rejected`)

  Component.onCompleted: open()
}
