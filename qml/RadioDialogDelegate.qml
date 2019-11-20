/** Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

RadioDelegate
{
    onClicked: ListView.view.currentIndex = index
    checked: ListView.isCurrentItem
    backgroundColor: MaterialStyle.dialogColor
    indicatorSpacing: MaterialStyle.dialog.indicatorSpacing
    alignTextRight: true
    LayoutMirroring.enabled: true
    width: parent.width // Not sure if this should be here ?
}
