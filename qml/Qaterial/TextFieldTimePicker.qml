/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.0

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.TextField
{
  id: root

  property int hour: 0
  property int minute: 0
  property bool styleAm: true
  property bool am: true

  signal hourAccepted(int hour, int minute, bool am)

  function pad(num, size)
  {
    let s = num + "";
    while(s.length < size) s = "0" + s;
    return s;
  }

  implicitWidth: 150

  title: "Time"
  placeholderText: "_ _ : _ _"
  validator: RegExpValidator
  {
    regExp: root.styleAm ? /(0[1-9]|1[0-2]):[0-5][0-9]/ : /([01]?[0-9]|2[0-3]):[0-5][0-9]/
  }
  errorText: "Invalid Time Format"

  trailingVisible: true
  trailingInline: true
  trailingContent: Qaterial.TextFieldButtonContainer
  {
    Qaterial.TextFieldIconButton
    {
      visible: root.styleAm
      text: root.am ? "AM" : "PM"
      textType: Qaterial.Style.TextType.Button
      onClicked: root.am = !root.am
    }

    Qaterial.TextFieldClockButton
    {
      hour: root.hour
      minute: root.minute
      styleAm: root.styleAm
      am: root.am

      onHourAccepted: function(hour, minute, am)
      {
        root.hour = hour
        root.minute = minute
        root.hourAccepted(hour, minute, am)
        root.text = `${root.pad(hour, 2)}:${root.pad(minute, 2)}`
        if(styleAm) root.am = am
      }
    } // TextFieldClockButton
  } // trailingContent : TextFieldButtonContainer

  onTextEdited: function()
  {
    // Extract current digit
    const match = text.match(/\d+/g)

    // If no digit : do nothing
    if(match === null)
    {
      text = `_ _:_ _`
      cursorPosition = 0
      return
    }
    const characters = match.map(String);

    // Format new text and place cursor

    // Only Hour entered
    if(characters.length === 1)
    {
      // Only first hour char entered
      if(characters[0].length === 1)
      {
        text = `${characters[0]}_:_ _`
        cursorPosition = 1
      }
      // Hour fully entered
      else if(characters[0].length === 2)
      {
        text = `${characters[0]}:_ _`
        // cursor poition still before ":" so the user can use backspace on hour
        cursorPosition = 2
      }
      // Hour entered and first char of minute
      else if(characters[0].length === 3)
      {
        text = `${characters[0][0]}${characters[0][1]}:${characters[0][2]}_`
        cursorPosition = 4
      }
    }
    // Hour already entered
    else if(characters.length === 2)
    {
      // Only first minute char entered
      if(characters[1].length === 1)
      {
        text = `${characters[0]}:${characters[1]}_`
        cursorPosition = 4
      }
      // Minute fully entered
      else if(characters[1].length === 2)
      {
        text = `${characters[0]}:${characters[1]}`
        cursorPosition = 5
      }
      // User trying to put more char in the text field : display only the 2 first minute char
      else
      {
        text = `${characters[0]}:${characters[1][0]}${characters[1][1]}`
        cursorPosition = 5
      }

      // If the user manually moves his cursor, check length of hour and adapt text
      if(characters[0].length === 1)
      {
        if(characters[1].length === 1)
        {
          text = `0${characters[0][0]}:${characters[1]}_`
          cursorPosition = 4
        }
        else if(characters[1].length === 2)
        {
          text = `0${characters[0][0]}:${characters[1]}`
          cursorPosition = 5
        }
      }
    }

    // Update global hour if syntax is correct
    if(acceptableInput)
    {
      hour = characters[0]
      minute = characters[1]
      hourAccepted(hour, minute, am)
    }
  } // onTextEdited Signal
} // TextField
