import QtQuick 2.12
import QtQuick.Controls 2.12

import Qaterial 1.0 as Qaterial

GridView
{
  id: root

  // Current selected month
  property int month: new Date()
    .getMonth()

  // Emitted when a month is clicked
  signal accepted(int month)

  implicitWidth: 280
  implicitHeight: 330

  cellHeight: Math.min(height / (Math.floor(height / 35)), height)
  cellWidth: Math.min(width / (Math.floor(width / 100)), width)

  model: Qaterial.Calendar.months

  delegate: Item
  {
    implicitWidth: root.cellWidth
    implicitHeight: root.cellHeight

    Qaterial.CalendarDateButton
    {
      id: _monthbutton

      anchors.fill: parent

      zoomLabelOnHovered: false
      horizontalPadding: Qaterial.Style.roundIcon.size / 3

      readonly property int month: index

      text: root.model[index]

      checked: root.month === index
      onClicked: function()
      {
        root.month = month
        root.accepted(month)
      }

      ToolTip.text: qsTr("Selected Month")
      ToolTip.visible: hovered && checked
    }
  }
}
