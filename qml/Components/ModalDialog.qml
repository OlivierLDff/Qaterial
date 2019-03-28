/** Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com */

import QtQuick.Controls 2.12
import QQuickMaterialHelper.Components 1.12

Dialog 
{
	id: root
	modal: true
	focus: true

	x: (parent.width - width) / 2
	y: (parent.height - height) / 2
	parent: Overlay.overlay
	width: parent.width / 3 * 2
}