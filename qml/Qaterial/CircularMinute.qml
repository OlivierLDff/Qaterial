import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Item
{
    id: root

    property int radius: 100
    property int minute

    property alias labelSize: _minutePath.labelSize

    implicitWidth: _minutePath.implicitWidth
    implicitHeight: _minutePath.implicitHeight

    CircularPathLabel
    {
        id: _minutePath
        anchors.centerIn: parent
        radius: parent.radius
        model: ["00", "05", "10", "15", "20", "25", "30", "35", "40","45", "50", "55"]
        currentIndex: root.minute%5 === 0 ? root.minute/5 : -1
    }
}
