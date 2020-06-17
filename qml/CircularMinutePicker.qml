import QtQuick 2.12
import Qaterial 1.0 as Qaterial

Item
{
    id: root

    property int radius: 100
    property int minute: currentMinute
    property int currentMinute: 0

    signal accepted(int minute)

    implicitWidth: _circularMinute.implicitWidth
    implicitHeight: _circularMinute.implicitHeight

    HandClock
    {
        id: handClock
        anchors.centerIn: parent
        radius: root.radius
        color: Qaterial.Style.accentColor  // Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.AccentLight)
        renderDot: root.minute%5
        rotation: 360*(minute%60)/60
    }

    CircularMinute
    {
        id: _circularMinute
        radius: root.radius
        minute: root.minute
    }

    MouseArea
    {
        anchors.fill: parent
        function computeAngle(x, y)
        {
            // Compute mouse angle compared to 12h from mouse.x and mouse.y

            const rad = Math.atan2(x, y)
            let deg = rad*(180/Math.PI)
            if(deg < 0) deg += 360

            // Compute an angle to remove (if your mouse is beetween 1am or 2am HandClock will go on the nearest)

            const angleToRemove = deg%6
            let finalAngle = Math.round(deg - angleToRemove)
            if(angleToRemove > 3) finalAngle += 6
            //console.log(`angleToRemove : ${angleToRemove}, finalAngle : ${finalAngle}`)

            // Deduce Minute from finalAngle and manage every particular cases : "00"

            let finalMinute = finalAngle/6
            if(finalMinute === 60) finalMinute = 0

            root.currentMinute = finalMinute
        }

        function computeMinute(mouse)
        {
            computeAngle(mouse.x/width - 1/2, -(mouse.y/height - 1/2))
            root.accepted(root.currentMinute)
        }

        onPressed:         (mouse) => computeMinute(mouse)
        onPositionChanged: (mouse) => computeMinute(mouse)
    }
}
