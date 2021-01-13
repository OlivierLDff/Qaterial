/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

/**
 * This item is a delegate container that contain a normal and a checked Delegate
 * This object needs to be inside a CheckableListView
 */
Item
{
  id: _root

  implicitHeight:
  {
    if(_root.ListView.view.checkBoxEnabled)
      return checkLoader.item ? checkLoader.item.implicitHeight : 0
    return defaultLoader.item ? defaultLoader.item.implicitHeight : 0
  }

  signal clicked()

  /** If the delegate is checked */
  property bool checked: false
  property alias defaultDelegate: defaultLoader.sourceComponent
  property alias checkDelegate: checkLoader.sourceComponent

  Component.onCompleted: updateCheckFromList()

  /** Enable the checkbox into the checkableListView */
  function enableCheckBox()
  {
    ListView.view.checkBoxEnabled = true
    ListView.view.checkItem(index)
  } // function enableCheckBox()

  function updateCheckFromList()
  {
    if(_root.ListView.view.checkBoxEnabled)
    {
      var newChecked = _root.ListView.view.isChecked(index)
      if(newChecked !== _root.checked)
        _root.checked = newChecked
    }
  } // function updateCheckFromList()

  /** Uncheck to be sure next time it is checked it will be uncheck or check */
  Connections
  {
    target: _root.ListView.view
    function onCheckBoxEnabledChanged()
    {
      if(!_root.ListView.view.checkBoxEnabled && _root.checked)
        _root.checked = false
    }

    onCheckedItemCounterChanged: updateCheckFromList()
  } // Connections

  Loader
  {
    id: defaultLoader
    anchors.fill: parent
    visible: !_root.ListView.view.checkBoxEnabled
  } // Loader

  Loader
  {
    id: checkLoader
    anchors.fill: parent
    visible: _root.ListView.view.checkBoxEnabled
  } // Loader
} // Item
