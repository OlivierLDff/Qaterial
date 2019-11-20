/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0

Rectangle
{
    id: cursor

    color: Style.accentColor
    width: Style.textField.cursorWidth
    visible: parent.activeFocus && !parent.readOnly && parent.selectionStart === parent.selectionEnd

    Connections
    {
        target: cursor.parent
        onCursorPositionChanged:
        {
            // keep a moving cursor visible
            cursor.opacity = 1
            timer.restart()
        }
    } // Connections

    Timer
    {
        id: timer
        running: cursor.parent.activeFocus && !cursor.parent.readOnly
        repeat: true
        interval: Qt.styleHints.cursorFlashTime / 2
        onTriggered: cursor.opacity = !cursor.opacity ? 1 : 0
        // force the cursor visible when gaining focus
        onRunningChanged: cursor.opacity = 1
    } // Timer
} // Rectangle
