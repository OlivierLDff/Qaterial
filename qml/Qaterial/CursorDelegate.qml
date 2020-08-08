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
  id: root

  color: Qaterial.Style.accentColor
  width: Qaterial.Style.textField.cursorWidth
  visible: parent.activeFocus && !parent.readOnly && parent.selectionStart === parent.selectionEnd

  Connections
  {
    target: root.parent
    function onCursorPositionChanged()
    {
      // keep a moving cursor visible
      root.opacity = 1
      _timer.restart()
    }
  } // Connections

  Timer
  {
    id: _timer
    running: root.parent.activeFocus && !root.parent.readOnly
    repeat: true
    interval: Qt.styleHints.cursorFlashTime / 2
    onTriggered: root.opacity = !root.opacity ? 1 : 0
    // force the cursor visible when gaining focus
    onRunningChanged: root.opacity = 1
  } // Timer
} // Rectangle
