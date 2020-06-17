import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Item
{
    id: root

    property int radius: 100
    property int hour: 0
    property alias labelSize: _amHour.labelSize

    implicitWidth:_amHour.implicitWidth
    implicitHeight: _amHour.implicitHeight

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
}
