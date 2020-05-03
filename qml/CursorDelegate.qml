/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Rectangle
{
  id: _cursor

  color: Qaterial.Style.accentColor
  width: Qaterial.Style.textField._cursorWidth
  visible: parent.activeFocus && !parent.readOnly && parent.selectionStart === parent.selectionEnd

  Connections
  {
    target: _cursor.parent
    function onCursorPositionChanged()
    {
      // keep a moving cursor visible
      _cursor.opacity = 1
      _timer.restart()
    }
  } // Connections

  Timer
  {
    id: _timer
    running: _cursor.parent.activeFocus && !_cursor.parent.readOnly
    repeat: true
    interval: Qt.styleHints._cursorFlashTime / 2
    onTriggered: _cursor.opacity = !_cursor.opacity ? 1 : 0
    // force the cursor visible when gaining focus
    onRunningChanged: _cursor.opacity = 1
  } // Timer
} // Rectangle
