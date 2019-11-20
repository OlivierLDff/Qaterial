/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0

FlatFabButton
{
	id: control

    backgroundColor: "transparent"
    borderColor: enabled ? (highlighted ? Style.accentColor : Style.dividersColor()) : Style.disabledDividersColor()
    outlined: true

    foregroundColor: !enabled ? Style.disabledTextColor() :
        highlighted ? Style.accentColor : Style.primaryTextColor()
} // FabButton
