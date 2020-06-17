import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Item
{
    id: root

    property int radius: 100
    property int hour: 0

    property alias labelSize: _amHour.labelSize
    readonly property int pmHourOffset: labelSize

    implicitWidth: Math.max(_amHour.implicitWidth, _pmHour.implicitWidth)
    implicitHeight: Math.max(_amHour.implicitHeight, _pmHour.implicitHeight)

    CircularPathLabel
    {
        id: _amHour
        anchors.centerIn: parent
        radius: parent.radius
        model: ["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
        currentIndex:
        {
            if(root.hour === 12)
                return 0
            if(root.hour >= 1 && root.hour <= 11)
                return root.hour
            return -1
        }
    }

    CircularPathLabel
    {
        id: _pmHour
        anchors.centerIn: parent
        radius: parent.radius - root.pmHourOffset
        textType: Qaterial.Style.TextType.Caption
        model: ["00", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
        currentIndex:
        {
            if(root.hour === 24 || root.hour === 0)
                return 0
            if(root.hour >= 13 && root.hour <= 23)
                return root.hour - 12
            return -1
        }
        labelSize: _amHour.labelSize
    }
}
