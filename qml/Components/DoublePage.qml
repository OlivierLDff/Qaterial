/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

// MaterialHelper
import QQuickMaterialHelper.Core 1.12
import QQuickMaterialHelper.Components 1.12
import QQuickMaterialHelper.Style 1.12

Page
{
    id: root

    /// First page fixed width.
    property int firstPageWidth: MaterialStyle.dense ? 250 : 300

    /// Second page minimal width.
    property int secondPageWidth: MaterialStyle.dense ? 500 : 600

    /// Are we on a small screen and we need to use a stack view to hold each page. Or on wide screen and the two*
    /// pages can appear on the side of each one
    readonly property bool useStackView: width < (firstPageWidth + secondPageWidth)
    onUseStackViewChanged: pushOrPop()

    /// Should be bind to the property that say that second page is active
    property bool secondPageActive: false
    onSecondPageActiveChanged: pushOrPop()

    /// Hold the first page component. This component is either full screen or is firstPageWidth
    property var firstPage: null

    /// Component that hold the second page. It's either loaded inside _secondPageLoader or pushed on top of the
    /// first page
    property var secondPage: null

    readonly property bool secondPagePushed: _localStackView.depth > 1

    /// Called when a back shortcut is pressed.
    /// You should call this from your header back app button
    /// return false if the stackView can't be poped more
    function pressBack()
    {
        if(secondPagePushed)
        {
            _localStackView.pop()
            return true
        }
        return false
    }

    /// Push or pop the second page depending on useStackView and secondPageActive
    function pushOrPop()
    {
        if(useStackView && secondPageActive)
        {
            if(!secondPagePushed)
                _localStackView.push(secondPage)
        }
        else if(secondPagePushed)
            _localStackView.pop()
    }

    /// StackView that contain the first page and push the second page if needed
    StackView
    {
        id: _localStackView

        height: parent.height
        width: root.useStackView ? parent.width : root.firstPageWidth

        initialItem: root.firstPage
    } // StackView

    /// Loader that load the second page in wide screen configuration
    Loader
    {
        id: _secondPageLoader

        height: parent.height
        x: root.firstPageWidth
        width: parent.width - root.firstPageWidth

        sourceComponent: root.useStackView ? null : root.secondPage
    } // Loader
} // Page
