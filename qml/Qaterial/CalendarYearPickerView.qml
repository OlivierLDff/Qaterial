import QtQuick 2.12
import QtQuick.Controls 2.12

import Qaterial 1.0 as Qaterial

GridView
{
  id: root

  property int year: new Date()
    .getFullYear()
  property int startYear: 1900
  property int endYear: 2100

  readonly property int indexSelectedYear: year - startYear

  signal accepted(int year)

  function getYears(startYear, endYear)
  {
    var years = new Array()
    for(let i = 0; i <= (endYear - startYear); ++i)
    {
      var year = startYear + i;
      years[i] = year
      //console.log(years[i])
    }
    return years;
  }

  implicitWidth: 280
  implicitHeight: 280

  cellWidth: Math.min(width / (Math.floor(width / 60)), width)
  cellHeight: Math.min(height / (Math.floor(height / 40)), height)

  model: getYears(startYear, endYear)

  currentIndex: indexSelectedYear

  delegate: Item
  {
    implicitWidth: root.cellWidth
    implicitHeight: root.cellHeight

    CalendarDateButton
    {
      id: _yearButton

      width: root.cellWidth
      height: root.cellHeight
      zoomLabelOnHovered: false
      readonly property int year: root.startYear + index

      text: year

      checked: root.indexSelectedYear === index
      onClicked: function()
      {
        //console.log(`currentIndex: ${root.currentIndex}`)
        //console.log(`year grid: ${year}`)
        root.year = year
        root.accepted(year)
      }

      ToolTip.text: "Selected Year"
      ToolTip.visible: hovered && checked
    }
  }
}
