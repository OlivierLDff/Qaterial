import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.TextFieldClockButton
{
  // Default time showed when dialog is opened
  hour: 15
  minute: 30

  // Listen to user changes
  onHourChanged: () => console.log(`Hour Changed : ${hour}`)
  onMinuteChanged: () => console.log(`Minute Changed : ${minute}`)

  onAccepted: (hour, minute) => console.log(`User picked ${hour}:${minute}`)
}