import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.TimePickerDialog
{
  // Default time showed when dialog is opened
  hour: 15
  minute: 30

  // Display the clock in Am/Pm style, or Eu style
  styleAm: false

  // Listen to user changes
  onHourChanged: () => console.log(`Hour Changed : ${hour}`)
  onMinuteChanged: () => console.log(`Minute Changed : ${minute}`)

  onAccepted: () => console.log(`User picked ${hour}:${minute}`)
  onRejected: () => console.log(`Rejected`)

  Component.onCompleted: open()
}
