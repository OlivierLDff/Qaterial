import QtQuick 2.0
import Qaterial 1.0 as Qaterial

/*Qaterial.Label
{
    anchors.centerIn: parent
    text: `parent ${parent}\n parent.width: ${parent.width}\n parent.height: ${parent.height}`
}*/

Row
{
    Qaterial.Button
    {
        text: "aazuodhazd"
        Binding on text
        {
            when: slider.pressed
            value: `slider ${slider.value.toFixed(2)}`
        }
    }

    Qaterial.Slider
    {
        id: slider
    }

    Qaterial.Label
    {
        text: `slider ${slider.value.toFixed(2)}`
    }
}