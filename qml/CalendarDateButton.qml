import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

import Qaterial 1.0 as Qaterial

T.Button
{
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    topInset: Qaterial.Style.fab.flatInset
    bottomInset: Qaterial.Style.fab.flatInset
    leftInset: Qaterial.Style.fab.flatInset
    rightInset: Qaterial.Style.fab.flatInset

    horizontalPadding: Qaterial.Style.roundIcon.size/4

//    Qaterial.DebugRectangle
//    {
//      anchors.fill: parent
//      border.color: "violet"
//    } // DebugRectangle

    contentItem: Qaterial.Label
    {
        text: control.text
        textType: Qaterial.Style.TextType.Button

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        scale: control.hovered ? 1.10 : 1

        Binding on color
        {
            when: control.highlighted && !control.checked
            value: Qaterial.Style.accentColor
        }




//        Qaterial.DebugRectangle
//        {
//          anchors.fill: parent
//          border.color: "red"
//        } // DebugRectangle
    }

    background: Rectangle
    {
//        Qaterial.DebugRectangle
//        {
//          anchors.fill: parent
//        } // DebugRectangle

        readonly property color checkedColor: Qaterial.Style.accentColor
        readonly property color hoveredColor: Qaterial.Style.rippleColor(Qaterial.Style.RippleBackground.AccentLight)

        implicitWidth: Qaterial.Style.roundIcon.size - Qaterial.Style.fab.flatInset*2
        implicitHeight: Qaterial.Style.roundIcon.size - Qaterial.Style.fab.flatInset*2

        radius: height/2
        color: control.checked ? checkedColor :
                                (control.hovered ? hoveredColor : "transparent")
    }
}
