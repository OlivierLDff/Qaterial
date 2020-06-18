import QtQuick 2.12
import QtQuick.Controls 2.12

import Qaterial 1.0 as Qaterial

Column
{
  id: root

  property alias date: _view.date

  property int month
  property int year

  // Lower pickable date in the calendar
  property alias from: _view.from

  // Higher pickable date in the calendar
  property alias to: _view.to

  Item
  {
    id : _rowMenu

    width: parent.width
    height: _previousMonthButton.height
    anchors.horizontalCenter : parent.horizontalCenter

    Qaterial.AppBarButton
    {
      id: _previousMonthButton

      anchors.verticalCenter : parent.verticalCenter
      anchors.left: parent.left

      icon.source: Qaterial.Icons.chevronLeft

      onClicked: () => --_view.currentIndex
    }

    Row
    {
      anchors.centerIn: parent
      Qaterial.FlatButton
      {
        id : _monthButton
        text: `${Calendar.monthToString(_view.getMonthFromIndex(_view.currentIndex))}`
        rightInset: 1
        leftInset: 1
        rightPadding: 0
        leftPadding: 0
        textType: Qaterial.Style.TextType.Body1
        highlighted: false
        backgroundImplicitWidth: 0
      }

      Qaterial.FlatButton
      {
        text: `${_view.getYearFromIndex(_view.currentIndex)}`
        rightInset: 1
        leftInset: 1
        rightPadding: 0
        leftPadding: 0
        textType: Qaterial.Style.TextType.Body1
        highlighted: false
        backgroundImplicitWidth: 0
      }
    }

    Qaterial.AppBarButton
    {
      anchors.verticalCenter : parent.verticalCenter
      anchors.right: parent.right

      icon.source: Qaterial.Icons.chevronRight

      onClicked: () => ++_view.currentIndex
    }
  }

  ListView
  {
    id: _view

    readonly property date today: new Date()
    property date currentDate: today
    property date date

    property date from : new Date(1900, 0, 1)
    property date to : new Date(2100, 0, 1)
    readonly property int indexYear : to.getFullYear()-from.getFullYear()
    readonly property int indexMonth : date.getMonth()

    implicitWidth: 280
    implicitHeight: 280
    orientation : ListView.Horizontal
    snapMode: ListView.SnapToItem
    model: monthSinceDate(from, to)
    spacing: 16
    currentIndex: monthSinceDate(from, currentDate)
    highlightMoveDuration : 50
    highlightRangeMode: ListView.StrictlyEnforceRange

    // Return currentIndex of 'date' based of 'from' date
    function monthSinceDate(from, to)
    {
        const yearDelta = to.getFullYear() - from.getFullYear()
        const monthDelta = to.getMonth() - from.getMonth()
        const indexModel = yearDelta*12 + monthDelta

        return indexModel
    }

    function getMonthFromIndex(index)
    {
        return ((index - Math.floor(index/12)*12) + from.getMonth())%12
    }

    function getYearFromIndex(index)
    {
        return from.getFullYear() + Math.floor((index + from.getMonth())/12)
    }

    delegate: CalendarDayPicker
    {
      date: _view.currentDate
      month: _view.getMonthFromIndex(index)
      year: _view.getYearFromIndex(index)
      onAccepted: function(date)
      {
       //console.log(`accepted date ${date.toString()}`)
       _view.currentDate = date
      }
    } // CalendarDayPicker

    move: Transition
    {
      NumberAnimation { properties: "x,y"; duration: 200 }
    } // Transition
  } // ListView
}

/*TEST FONCTIONS*/

//console.log(monthfromIndex(new Date(1900,5,1), 47) + " == 4")
//console.log(monthfromIndex(new Date(1900,0,1), 15) + "== 3 ")
//console.log(monthfromIndex(new Date(1900,5,1), 15) + "== 8 ")

//console.log(yearFromIndex(new Date(1900,5,1), 47) + " == 1904")
//console.log(yearFromIndex(new Date(1900,0,1), 15) + "== 1901 ")
//console.log(yearFromIndex(new Date(1900,5,1), 15) + "== 1901 ")
//console.log(yearFromIndex(new Date(1900,0,1), 160) + "== 1913 ")
//console.log(yearFromIndex(new Date(1900,5,1), 160) + "== 1913 ")
//console.log(yearFromIndex(new Date(1900,6,1), 160) + "== 1913 ")
//console.log(yearFromIndex(new Date(1900,7,1), 160) + "== 1913 ")
//console.log(yearFromIndex(new Date(1900,8,1), 160) + "== 1914 ")
