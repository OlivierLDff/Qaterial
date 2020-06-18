import QtQuick 2.12
import QtQuick.Controls 2.12

import Qaterial 1.0 as Qaterial

GridView
{
    id: root

    visible: true
    implicitWidth : 300
    implicitHeight : 160
    cellHeight : implicitHeight/4
    cellWidth : implicitWidth/3

    property int currentMonth : new Date().getMonth()
    model: Qaterial.Calendar.months

    delegate: CalendarDateButton
    {
        id : _monthbutton

        width: root.cellWidth
        height: root.cellHeight

        readonly property int month : index

        text: root.months[index]

        checked: currentMonth === index
        onClicked: function()
        {
            //console.log(`currentIndex : ${root.currentIndex}`)
            //console.log(`month grid : ${month}`)
            root.currentMonth = month
        }

       Rectangle
        {
            anchors.fill : parent
            border.color : "red"
            color : "transparent"
        }
        ToolTip.text: "Selected Month"
        ToolTip.visible: hovered && checked
    }

    Rectangle
    {

        anchors.fill : parent
        border.color : "blue"
        color : "transparent"

    }
}