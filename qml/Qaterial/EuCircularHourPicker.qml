/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  property int radius: 100
  property int hour: currentHour
  property int currentHour: 0
  property alias labelSize: _circularHour.labelSize

  signal accepted(int hour)

  implicitWidth: _circularHour.implicitWidth
  implicitHeight: _circularHour.implicitHeight

  HandClock
  {
    id: handClock
    anchors.centerIn: parent
    radius: root.radius - ((root.hour === 0 || root.hour > 12) ? root.labelSize : 0)
    color: Qaterial.Style.accentColor
    renderDot: false
    rotation: 360 * (hour % 12) / 12
  }

  EuCircularHour
  {
    id: _circularHour
    radius: root.radius
    hour: root.hour
  }

  MouseArea
  {
    anchors.fill: parent

    function computeAngle(x, y)
    {
      // Compute mouse angle compared to 12h from mouse.x and mouse.y

      const rad = Math.atan2(x, y)
      let deg = rad * (180 / Math.PI)
      if(deg < 0) deg += 360

      // Compute an angle to remove (if your mouse is beetween 1am or 2am HandClock will go on the nearest)

      const angleToRemove = deg % 30
      let finalAngle = Math.round(deg - angleToRemove)
      if(angleToRemove > 15) finalAngle += 30

      // Deduce Hour from finalAngle and manage every particular cases (midnight and midday)
      // Also compute radius of internal circle (PM hour) with vector2d length

      let finalHour = finalAngle / 30
      let vect = Qt.vector2d(x, y);
      const onAmHour = vect.length() > ((root.radius - root.labelSize) / root.radius) / 2

      if(!onAmHour)
      {
        finalHour += 12
        if(finalHour === 12 || finalHour === 24) finalHour = 0
      }
      else if(finalHour === 0) finalHour = 12

      root.currentHour = finalHour
    }

    function computeHour(mouse)
    {
      computeAngle(mouse.x / width - 1 / 2, -(mouse.y / height - 1 / 2))
      root.accepted(root.currentHour)
    }

    onPressed: (mouse) => computeHour(mouse)
    onPositionChanged: (mouse) => computeHour(mouse)
  }
}
