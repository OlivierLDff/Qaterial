import QtQuick 2.0
import Qaterial 1.0 as Qaterial

Qaterial.TextFieldClockButton
{
  // Default time showed when dialog is opened
  hour: 15
  minute: 30

  // Style of the clock, European by default
  styleAm: true
  // If Am/Pm style, time slot of the hour
  am: false // Pm

  // Listen to user changes
  onHourAccepted: (hour, minute, am) => console.log(
    `User picked ${hour}:${minute} ${styleAm ? (am ? "AM" : "PM") : ""}`)
}
