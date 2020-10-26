import QtQuick 2.12

import Qaterial 1.0 as Qaterial

Item
{
  id: root
  property int month
  property int year

  property bool previousMonthEnabled: true
  property bool nextMonthEnabled: true

  signal monthClicked()
  signal yearClicked()
  signal nextMonth()
  signal previousMonth()

  implicitWidth: 280
  implicitHeight: _previousMonthButton.implicitHeight

  Qaterial.AppBarButton
  {
    id: _previousMonthButton

    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left

    enabled: root.previousMonthEnabled
    icon.source: Qaterial.Icons.chevronLeft

    onClicked: () => root.previousMonth()
  }

  Row
  {
    id: _rowMonthYear
    anchors.centerIn: parent
    Qaterial.FlatButton
    {
      id: _monthButton
      text: `${Calendar.monthToString(root.month)}`
      rightInset: 1
      leftInset: 1
      rightPadding: 0
      leftPadding: 0
      textType: Qaterial.Style.TextType.Body1
      highlighted: false
      backgroundImplicitWidth: 0

      onClicked: () => root.monthClicked()
    }

    Qaterial.FlatButton
    {
      id: _yearButton
      text: `${root.year}`
      rightInset: 1
      leftInset: 1
      rightPadding: 0
      leftPadding: 0
      textType: Qaterial.Style.TextType.Body1
      highlighted: false
      backgroundImplicitWidth: 0

      onClicked: () => root.yearClicked()
    }
  }

  Qaterial.AppBarButton
  {
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right

    enabled: root.nextMonthEnabled
    icon.source: Qaterial.Icons.chevronRight

    onClicked: () => root.nextMonth()
  }
}
