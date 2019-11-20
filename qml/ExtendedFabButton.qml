/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qaterial
import Qaterial 1.0

FabButton
{
	id: control
    flat: false
    highlighted: true

    leftPadding: MaterialStyle.fab.padding
    rightPadding: MaterialStyle.fab.padding

    contentItem: FabIconLabel
    {
        id: _iconLabel
        spacing: control.spacing
        display: control.display
        icon: control.icon
        text: control.text
        font: control.font
        color: control.foregroundColor
    } // FabIconLabel

    property bool extended: (!extendedOnHovered || extendedOnHovered && (hovered || down || visualFocus)) && text != ""

    type: extended ? MaterialStyle.FabType.Extended : MaterialStyle.FabType.Default
} // RawMaterialButton
