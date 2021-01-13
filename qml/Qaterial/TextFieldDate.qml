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

  cursorVisible: true

  property date date

  property date from: new Date(1900, 0, 1)
  property date to: new Date(2100, 0, 1)

  signal accepted(date date)

  implicitWidth: 150

  title: "Date"
  validator: RegExpValidator { regExp: /([1-9]|0[1-9]|[12][0-9]|3[01])[/](0[1-9]|[1-9]|1[0-2])[/]\d{4}/ }
  errorText: dateOutOfBound ? "Date is Out of Bound" : "Invalid Date Format"
  readonly property bool dateOutOfBound: !Qaterial.Calendar.isDateValid(from, to, date)
  error: !acceptableInput || dateOutOfBound

  //AJOUT D'UNE FONCTION onCursorPositionChanged()

  onTextEdited: function()
  {
    // Extract current date
    const match = text.match(/\d+/g)

    // If no date : do nothing
    if(match === null)
    {
      text = `__/__/____`
      cursorPosition = 0
      return
    }
    const characters = match.map(String);

    if(characters.length === 1)
    {
      if(characters[0].length === 1)
      {
        text = `${characters[0]}_/__/____`
        cursorPosition = 1
      }
      else if(characters[0].length === 2)
      {
        text = `${characters[0]}/__/____`
        cursorPosition = 2
      }
      else if(characters[0].length === 3)
      {
        text = `${characters[0][0]}${characters[0][1]}/${characters[0][2]}_/____`
        cursorPosition = 4
      }
    }
    else if(characters.length === 2)
    {
      if(characters[1].length === 1)
      {
        text = `${characters[0]}/${characters[1]}_/____`
        cursorPosition = 4
      }
      else if(characters[1].length === 2)
      {
        text = `${characters[0]}/${characters[1]}/____`
        cursorPosition = 5
      }

      else if(characters[1].length === 3)
      {
        text = `${characters[0]}/${characters[1][0]}${characters[1][1]}/${characters[1][2]}___`
        cursorPosition = 7
      }
      else if(characters[1].length === 4)
      {
        text = `${characters[0]}/${characters[1][0]}${characters[1][1]}/${characters[1][2]}${characters[1][3]}__`
        cursorPosition = 8
      }
      else if(characters[1].length === 5)
      {
        text =
          `${characters[0]}/${characters[1][0]}${characters[1][1]}/${characters[1][2]}${characters[1][3]}${characters[1][4]}_`
        cursorPosition = 9
      }
      else
      {
        text = `${characters[0]}/${characters[1][0]}${characters[1][1]}/____`
        cursorPosition = 6
      }

      if(characters[0].length === 1)
      {
        if(characters[1].length === 1)
        {
          text = `0${characters[0][0]}/${characters[1]}_/____`
          cursorPosition = 4
        }
        else if(characters[1].length === 2)
        {
          text = `0${characters[0][0]}/${characters[1]}/____`
          cursorPosition = 6
        }
      }
    }
    else if(characters.length === 3)
    {
      if(characters[2].length === 1)
      {
        text = `${characters[0]}/${characters[1]}/${characters[2]}___`
        cursorPosition = 7
        if(characters[1].length === 1)
        {
          text = `${characters[0]}/${characters[1]}/${characters[2]}___`
          cursorPosition = 6
        }
      }
      else if(characters[2].length === 2)
      {
        text = `${characters[0]}/${characters[1]}/${characters[2][0]}${characters[2][1]}__`
        cursorPosition = 8
        if(characters[1].length === 1)
        {
          text = `${characters[0]}/${characters[1]}/${characters[2]}__`
          cursorPosition = 7
        }
      }
      else if(characters[2].length === 3)
      {
        text = `${characters[0]}/${characters[1]}/${characters[2][0]}${characters[2][1]}${characters[2][2]}_`
        cursorPosition = 9
        if(characters[1].length === 1)
        {
          text = `${characters[0]}/${characters[1]}/${characters[2]}_`
          cursorPosition = 8
        }
      }
      else if(characters[2].length === 4)
      {
        text = `${characters[0]}/${characters[1]}/${characters[2]}`
        cursorPosition = 10
        if(characters[1].length === 1)
        {
          text = `${characters[0]}/${characters[1]}/${characters[2]}`
          cursorPosition = 9
        }
      }
      if(characters[0].length === 1)
      {
        if(characters[1].length === 1)
        {
          text = `0${characters[0][0]}/${characters[1]}_`
          cursorPosition = 4
        }
        else if(characters[1].length === 2)
        {
          text = `0${characters[0][0]}/${characters[1]}`
          cursorPosition = 5
        }
      }

    }
    if(acceptableInput && !dateOutOfBound)
    {
      date = new Date(characters[2], characters[1] - 1, characters[0])
      accepted(date)
    }

  }

  function writeDateToText()
  {
    text = isNaN(date) ? `__/__/____` : `${date.getDate()}/${date.getMonth()+1}/${date.getFullYear()}`
  }

  onDateChanged: () => writeDateToText()

  Component.onCompleted: () => writeDateToText()
}
