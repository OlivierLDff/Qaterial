import QtQuick 2.12
import QtQuick.Controls 2.12
import Qaterial 1.0 as Qaterial

Grid
{
    id: root

    // ---- SELECTED DAY ----

    // Selected date
    property date date
    Binding on date
    {
        when: _selectedDatePressed
        value: root._selectedDate
    }
    property date _selectedDate
    /*Binding on _selectedDate
    {
        when: _selectedDatePressed
        value: root._selectedDate
    }*/
    readonly property int _selectedMonth: date.getMonth()
    readonly property int _selectedYear: date.getFullYear()

    readonly property bool _selectedDayIsCurrentMonth: (month === _selectedMonth) && (year === _selectedYear)
    readonly property int _indexSelectedDay : _selectedDayIsCurrentMonth ? _indexFirstDateMonth - 2 + date.getDate() : -1

    property bool _selectedDatePressed

    // ---- TODAY ----

    // Hightlighted day that should be represent as today (nothing to do with date)
    readonly property date today: new Date()
    readonly property int _todayMonth: today.getMonth()
    readonly property int _todayYear: today.getFullYear()

    // Is today a day of the month controlled by 'month' and 'year' set by user
    readonly property bool _todayIsCurrentMonth: (month === _todayMonth) && (year === _todayYear)
    readonly property int _indexToday: _todayIsCurrentMonth ? _indexFirstDateMonth -2 + today.getDate() : -1

    // ---- CURRENT MONTH / YEAR ----

    // Control the displayed month in the grid
    property int month: _todayMonth
    // Control the displayed year in the grid
    property int year: _todayYear

    // Show the day that are in next month in the grid
    property bool showNextMonth

    // Show the day in previous month in the grid
    property bool showPreviousMonth

    // date object of the first day of the month controlled by 'month' and 'year' set by user
    readonly property date _firstDateMonth : new Date(year, month, 1)
    // Offset in the grid of the first day in current month controlled by 'month' and 'year' set by user
    readonly property int _indexFirstDateMonth : _firstDateMonth.getDay() ? _firstDateMonth.getDay() : 7

    // Number of day in month controlled by property 'month' and 'year' set by user
    //warning : add 1 to get the true number of days of the Month
    readonly property int _numberOfDays: new Date(year, month + 1, 0).getDate();

    // Number of day in month previous month controlled by property 'month' and 'year' set by user
    //warning : add 1 to get the true number of days of the Month
    readonly property int _numberOfDaysPreviousMonth: month ? (new Date(year, month, 0)).getDate() : (new Date(year-1, 12, 0)).getDate()

    readonly property bool showLastRow: ((_numberOfDays + _indexFirstDateMonth) > 36)

    // ---- SELECTED DAY CHOOSE BY USER ----

    signal accepted(date date)
    signal nextMonthDayClicked(date date)
    signal previousMonthDayClicked(date date)

    function _getPreviousMonthDate(index)
    {
        if(month)
        {
//            console.log("index : "+ index);
//            console.log("currentMonth "+ currentMonth)
//            console.log("numberOfdays"+ _numberOfDays)
//            console.log("inumber of days previosu month : "+ _numberOfDaysPreviousMonth);
//            console.log("_indexFirstDateMonth" + _indexFirstDateMonth);
//            console.log((new Date(_selectedYear, currentMonth-1, _numberOfDaysPreviousMonth + index - _indexFirstDateMonth + 2).getDate()));
            return new Date(year,month-1 , _numberOfDaysPreviousMonth + index - _indexFirstDateMonth + 2);
        }
        else
        {
//            console.log("index : "+ index);
//            console.log("inumber of days previosu month : "+ _numberOfDaysPreviousMonth);
//            console.log("_indexFirstDateMonth" + _indexFirstDateMonth);
//            console.log((new Date(_selectedYear-1, 11, _numberOfDaysPreviousMonth + index - _indexFirstDateMonth + 2).getDate()));
            return new Date(year-1, 11, _numberOfDaysPreviousMonth + index - _indexFirstDateMonth + 2);
        }
    }

    columns: 7

    Repeater
    {
        id : repeater
        model: root.showLastRow? 42 : 35
        delegate: CalendarDateButton
        {
            id : dateButton

            readonly property date date: enabled ? new Date(root.year, root.month, index + 2 - root._indexFirstDateMonth) : root._getPreviousMonthDate(index)
            text: date.getDate()

            enabled: ((index + 1) >= root._indexFirstDateMonth) && (index < (root._indexFirstDateMonth + root._numberOfDays - 1))
            checked: root._indexSelectedDay === index
            highlighted: root._indexToday === index

            onClicked: function()
            {
                //console.log(`Click on button at index : ${index}`)
                //console.log(`day grid date : ${date}`)
                //console.log(`_indexSelectedDay : ${root._indexSelectedDay} & index : ${index}`)
                //console.log(`_selectedDate : ${root._selectedDate} & Date: ${root.date}`)
                //console.log(`Clicked on date ${date}`)
                root._selectedDatePressed = true
                root._selectedDate = date

                //console.log(`_selectedDayIsCurrentMonth: ${root._selectedDayIsCurrentMonth}`)
                //console.log(`_selectedMonth: ${root._selectedMonth}`)
                //console.log(`_selectedYear: ${root._selectedYear}`)
                //console.log(`_selectedDate : ${root._selectedDate} & Date: ${root.date}`)
                //console.log(`_selectedYear : ${root._selectedYear} & Year ${root.year}`)
                root._selectedDatePressed = false
                root.accepted(date)
                //Qt.callLater(acceptDateLater)

                //console.log(`date : ${date}`)
                //console.log(`_indexSelectedDay : ${_indexSelectedDay}`)
                //console.log(`_selectedDayIsCurrentMonth : ${_selectedDayIsCurrentMonth}`)
                //console.log(`_indexFirstDateMonth : ${_indexFirstDateMonth}`)
                //console.log(`_selectedMonth : ${_selectedMonth}`)
                //console.log(`month : ${month}`)
                //console.log(`_selectedYear : ${_selectedYear}`)
                //console.log(`year : ${year}`)
            }

//            Qaterial.ToolTip
//            {
//                text: checked ? "Selected date" : "Current day"
//                visible: dateButton.hovered && (dateButton.checked || dateButton.highlighted)
//            }

            ToolTip.text: checked ? "Selected date" : "Current day"
            ToolTip.visible: hovered && (checked || highlighted)
        }
    }

    Component.onCompleted:
    {
        //console.log(`date : ${date}`)
        //console.log(`_indexSelectedDay : ${_indexSelectedDay}`)
        //console.log(`_selectedDayIsCurrentMonth : ${_selectedDayIsCurrentMonth}`)
        //console.log(`_indexFirstDateMonth : ${_indexFirstDateMonth}`)
        //console.log(`_selectedMonth : ${_selectedMonth}`)
        //console.log(`month : ${month}`)
        //console.log(`_selectedYear : ${_selectedYear}`)
        //console.log(`year : ${year}`)


        _selectedDate = date
    }
}