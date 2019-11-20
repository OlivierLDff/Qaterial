/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

Label
{
    id: control
    property bool separatorVisible: false
    ToolSeparator
    {
        id: _separator
        width: parent.width
        y: Math.floor(MaterialStyle.card.horizontalPadding/2)
        verticalPadding: 0
        orientation: Qt.Horizontal
        visible: control.separatorVisible
    }
    padding: MaterialStyle.card.horizontalPadding
    bottomPadding: MaterialStyle.card.verticalPadding
    topPadding: _separator.visible ? MaterialStyle.card.horizontalPadding : MaterialStyle.card.verticalPadding
    textType: MaterialStyle.TextType.Overline
    elide: Text.ElideRight
}
