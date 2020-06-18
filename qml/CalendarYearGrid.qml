import QtQuick 2.12
import QtQuick.Controls 2.12

import Qaterial 1.0 as Qaterial


GridView
{
    id: yearsGrid

    visible: true
    implicitWidth :150
    implicitHeight :160
    cellWidth : implicitWidth/3
    cellHeight : implicitHeight/4

    property int currentYear : (new Date()).getFullYear()
    property int startYear: 1900
    property int endYear : 2020

    property int indexSelectedYear : currentYear - startYear

    function getYears(startYear, endYear)
    {
        var years =new Array()
        for(let i=0; i<=(endYear-startYear);++i)
        {
            var year =startYear+i;
            years[i]=year
            console.log(years[i])
        }
        return years;
    }

    model: getYears(startYear, endYear)

    delegate: CalendarDateButton
    {
        id : yearButton

        width : yearsGrid.cellWidth
        height :yearsGrid.cellHeight
        readonly property int year : yearsGrid.startYear + index

        text: year

        checked: yearsGrid.indexSelectedYear === index
        onClicked: function()
        {
            console.log(`currentIndex : ${yearsGrid.currentIndex}`)
            console.log(`year grid : ${year}`)
            yearsGrid.currentYear = year
        }

        Rectangle
        {
            anchors.fill : parent
            border.color : "red"
            color : "transparent"
        }
        ToolTip.text: "Selected Year"
        ToolTip.visible: hovered && checked
    }

    Rectangle
    {

        anchors.fill : parent
        border.color : "blue"
        color : "transparent"

    }
}