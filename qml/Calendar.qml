pragma Singleton
import QtQml 2.12

QtObject
{
    enum Month
    {
        January = 0,
        February,
        March,
        April,
        May,
        June,
        July,
        August,
        September,
        October,
        November,
        December
    }

    property var months: [
        qsTr("January"),
        qsTr("February"),
        qsTr("March"),
        qsTr("April"),
        qsTr("May"),
        qsTr("June"),
        qsTr("July"),
        qsTr("August"),
        qsTr("September"),
        qsTr("October"),
        qsTr("November"),
        qsTr("December")
    ]

    enum Day
    {
        Sunday = 0,
        Monday,
        Tuesday,
        Wednesday,
        Thursday,
        Friday,
        Saturday
    }

    property var days: [
        qsTr("Sunday"),
        qsTr("Monday"),
        qsTr("Tuesday"),
        qsTr("Wednesday"),
        qsTr("Thursday"),
        qsTr("Friday"),
        qsTr("Saturday")
    ]

    function monthToString(month)
    {
        return months[month]
    }

    function dayToString(day)
    {
        return days[day]
    }
}