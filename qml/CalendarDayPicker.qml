import QtQuick 2.12
import QtQuick.Controls 2.12
import Qaterial 1.0 as Qaterial

Column
{
    id: root

    property alias date: _dayGrid.date
    property alias today: _dayGrid.today
    property alias month: _dayGrid.month
    property alias year: _dayGrid.year

    signal accepted(date date)

    CalendarWeekDayRow { }

    CalendarDayGrid
    {
        id: _dayGrid
        onAccepted: (date) => root.accepted(date)
    }
}
