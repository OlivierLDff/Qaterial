/** 
 * Copyright (C) Olivier Le Doeuff 2019 
 * Contact: olivier.ldff@gmail.com 
 */

import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12

import QQuickMaterialHelper.Style 1.12
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12

T.ScrollView 
{
    id: view

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    property double implicitTopPadding
    property double implicitBottomPadding

    ScrollBar.vertical: TextAreaScrollBar 
    {
        parent: view
        x: view.mirrored ? 0 : view.width - width
        y: view.topPadding + view.implicitTopPadding
        height: view.availableHeight - view.implicitBottomPadding - view.implicitTopPadding
        active: view.ScrollBar.horizontal.active
    }

    ScrollBar.horizontal: TextAreaScrollBar 
    {
        parent: view
        x: view.leftPadding
        y: view.height - height
        width: view.availableWidth
        active: view.ScrollBar.vertical.active
    }
}