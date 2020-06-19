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

  signal hourAccepted(int hour, int minute)

  function pad(num, size)
  {
    let s = num+"";
    while (s.length < size) s = "0" + s;
    return s;
  }

  title: "Time"
  placeholderText: "_ _ : _ _"
  validator: RegExpValidator { regExp: /([01]?[0-9]|2[0-3]):[0-5][0-9]/ }
  errorText: "Invalid Time Format"

  trailingVisible: true
  trailingInline: true
  trailingContent: Qaterial.TextFieldClockButton
  {
    hour: root.hour
    minute: root.minute

    onAccepted: function(hour, minute)
    {
      root.hour = hour
      root.minute = minute
      root.hourAccepted(hour, minute)
      root.text = `${root.pad(hour, 2)}:${root.pad(minute, 2)}`
    }
  } // trailingContent : TextFieldClockButton

  onTextEdited: function()
  {
    if(text !== "" && text !== "_:_ _" && text !== `_ _:_ `)
    {
      // Extract current digit
      const numbers = text.match(/\d+/g).map(Number);
      const characters = text.match(/\d+/g).map(String);

      // Format new text and place cursor
      if(numbers.length === 1)
      {
        const firstCharIsZero = characters[0][0] === '0' && characters[0].length > 1
        if(numbers[0] >= 9 || firstCharIsZero)
        {
          if(firstCharIsZero)
            text = `0${numbers[0]}:_ _`
          else
            text = `${numbers[0]}:_ _`
          cursorPosition = 3
        }
        else
        {
          text = `${numbers[0]}_:_ _`
          cursorPosition = 1
        }
      }
      else if(numbers.length === 2)
      {
        const firstCharIsZero = characters[1][0] === '0' && characters[1].length > 1
        if(numbers[1] >= 9 || firstCharIsZero)
        {
          if(firstCharIsZero)
            text = `${characters[0]}:0${numbers[1]}`
          else
            text = `${characters[0]}:${numbers[1]}`
          cursorPosition = 5
        }
        else
        {
          text = `${characters[0]}:${characters[1]} _`
          cursorPosition = 4
        }
      }

      // Update global hour if syntax is correct
      if(acceptableInput)
      {
        hour = numbers[0]
        minute = numbers[1]
        hourAccepted(hour, minute)
      }
    }
    else
    {
      text = `_ _:_ _`
    }
  } // onTextEdited Signal
} // TextField