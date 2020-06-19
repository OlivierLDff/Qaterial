import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.TextFieldTimePicker
{
  // Default time showed when the TextFieldClockButton is clicked
  hour: 15
  minute: 30

  // Listen to user changes
  onHourChanged: () => console.log(`Hour Changed : ${hour}`)
  onMinuteChanged: () => console.log(`Minute Changed : ${minute}`)

  onHourAccepted: (hour, minute) => console.log(`User picked ${hour}:${minute}`)
}