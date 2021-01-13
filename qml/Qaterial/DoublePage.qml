/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Qaterial.Page
{
  id: _root

  /// First page fixed width.
  property int firstPageWidth: Qaterial.Style.dense ? 250 : 300

  /// Second page minimal width.
  property int secondPageWidth: Qaterial.Style.dense ? 500 : 600

  /// Are we on a small screen and we need to use a stack view to hold each page. Or on wide screen and the two*
  /// pages can appear on the side of each one
  readonly property bool useStackView: width < (firstPageWidth + secondPageWidth)
  onUseStackViewChanged: Qt.callLater(pushOrPop)

  /// Should be bind to the property that say that second page is active
  property bool secondPageActive: false
  onSecondPageActiveChanged: Qt.callLater(pushOrPop)

  /// Hold the first page component. This component is either full screen or is firstPageWidth
  property
  var firstPage: null

  /// Component that hold the second page. It's either loaded inside _secondPageLoader or pushed on top of the
  /// first page
  property
  var secondPage: null

  property bool secondPagePushed: false

  /// Called when a back shortcut is pressed.
  /// You should call this from your header back app button
  /// return false if the stackView can't be poped more
  function pressBack()
  {
    if(secondPagePushed)
    {
      secondPagePushed = false
      console.log("Debug (DoublePage.qml) : Pop Second Page")
      _localStackView.pop()
      return true
    }
    return false
  } // function pressBack()

  /// Push or pop the second page depending on useStackView and secondPageActive
  function pushOrPop()
  {
    if(_localStackView.depth === 0)
    {
      console.log("Debug (DoublePage.qml) : Call later push or pop")
      Qt.callLater(pushOrPop)
      return
    }

    if(useStackView && secondPageActive)
    {
      if(!secondPagePushed)
      {
        secondPagePushed = true
        console.log("Debug (DoublePage.qml) : Push Second Page, depth: " + _localStackView.depth)
        _localStackView.push(secondPage)
      }
    }
    else if(secondPagePushed)
    {
      secondPagePushed = false
      console.log("Debug (DoublePage.qml) : Pop Second Page")
      _localStackView.pop()
    }
  } // function pushOrPop()

  /// StackView that contain the first page and push the second page if needed
  Qaterial.StackView
  {
    id: _localStackView

    height: parent.height
    width: _root.useStackView ? parent.width : _root.firstPageWidth

    initialItem: _root.firstPage
  } // StackView

  /// Loader that load the second page in wide screen configuration
  Loader
  {
    id: _secondPageLoader

    height: parent.height
    x: _root.firstPageWidth
    width: parent.width - _root.firstPageWidth

    sourceComponent: _root.useStackView ? null : _root.secondPage
  } // Loader
} // Page
