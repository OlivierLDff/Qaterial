//
// Copyright (C) Olivier Le Doeuff 2019-2020
// Contact: olivier.ldff@gmail.com
//

//
// Expandable is a lightweight item that display a 'header' and a 'delegate' if 'expanded' is true.
// The 'delegate' is revealed with an animation 'animation'
//
// The width of header & delegate are control by the Expandable's width property
// The height of the Expandable is the height of the loaded 'header' plus loaded 'delegate' (if expanded)
//
// CONTROL
// - expanded
//
// CUSTOMIZATION
// - header
// - delegate
// - animation

// Qt
import QtQuick 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

Item
{
  id: root

  // Control the opening & closing of the delegate
  property bool expanded

  // Header to load
  property Component header

  // Delegate to show when expanded
  property Component delegate

  // Animation use on height of the expanded item
  property Animation animation: NumberAnimation
  {
    duration: root.expanded ? 250 : 200
    easing.type: Easing.OutQuart
  }

  implicitWidth: Qaterial.Style.delegate.implicitWidth
  implicitHeight: _headerLoader.height + _delegateClipper.height

  onExpandedChanged: function()
  {
    // _delegateLoader.sourceComponent should be destroyed after
    // animation finishes
    if(expanded && !_delayDestroyTimer.isRunning)
    {
      _delayDestroyTimer.stop(root.animation.duration)
      _delegateLoader.active = true
    }
    else
    {
      _delayDestroyTimer.start(root.animation.duration)
    }

    // Delay the resize, to be sure that every property binded to expanded are already evaluated
    Qt.callLater(_evaluateDelegateClipperHeight)
  }

  onDelegateChanged: function()
  {
    if(root.expanded && _delegateLoader.item)
      _evaluateDelegateClipperHeight()
  }

  // This function is called once every binding on expanded have been reevaluated.
  // It allow to change the height of the object when for example the animation duration is correctly set
  function _evaluateDelegateClipperHeight()
  {

    // Then resize to trigger the animation
    _delegateClipper.height = (root.expanded && _delegateLoader.item) ? _delegateLoader.item.height : 0
  }

  // Always load the header
  Loader
  {
    id: _headerLoader
    width: root.width
    sourceComponent: root.header
  } // Loader

  // Dummy object used to clip the loaded 'delegate'
  Item
  {
    id: _delegateClipper

    y: _headerLoader.height
    width: root.width
    clip: true

    Behavior on height { animation: root.animation }

    Timer
    {
      id: _delayDestroyTimer
      onTriggered: () => _delegateLoader.active = false
    } // Timer

    // Load the 'delegate'
    Loader
    {
      id: _delegateLoader
      width: _delegateClipper.width
      sourceComponent: root.delegate

      Component.onCompleted: () => active = root.expanded
    } // Loader
  } // Item
} // Rectangle
