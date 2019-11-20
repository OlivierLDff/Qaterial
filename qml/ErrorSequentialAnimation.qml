/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtGraphicalEffects 1.12

// Qaterial
import Qaterial 1.0

SequentialAnimation
{
    id: root
    property var target
    property double x: 0
    running: false
    NumberAnimation { target: root.target; property: "x"; to: root.x+4; duration: 50 }
    NumberAnimation { target: root.target; property: "x"; to: root.x-4; duration: 50 }
    NumberAnimation { target: root.target; property: "x"; to: root.x; duration: 50 }
}
