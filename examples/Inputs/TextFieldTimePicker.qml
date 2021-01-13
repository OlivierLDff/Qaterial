import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.TextFieldTimePicker
{
  width: 250
  // Default time showed when the TextFieldClockButton is clicked
  hour: 15
  minute: 30

  // Style of the clock, European by default
  styleAm: true
  // If Am/Pm style, time slot of the hour
  am: false // Pm

  // Listen to user changes
  onHourChanged: () => console.log(`Hour Changed : ${hour}`)
  onMinuteChanged: () => console.log(`Minute Changed : ${minute}`)

  onHourAccepted: (hour, minute, am) => console.log(
    `User picked ${hour}:${minute} ${styleAm ? (am ? "AM" : "PM") : ""}`)
}
