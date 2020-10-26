/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12
import QtQuick.Controls 2.12

// Qaterial
import Qaterial 1.0 as Qaterial

/**
 * @brief Manager that creates snack bar dynamically
 */
Item
{
  id: _root
  // Use to force the display off of the snackbar bar
  property bool displaySnackbar: false
  // If the snackbar can be kill before the end of it's lifetime
  property bool canBeKilled: (settings && (settings.canBeKilled !== undefined)) ? settings.canBeKilled : true

  z: Infinity

  width: parent ? parent.width : 200
  anchors.top: parent ? parent.top : undefined
  anchors.bottomMargin: Qaterial.Style.card.horizontalPadding
  anchors.bottom: parent ? parent.bottom : undefined

  // Snackbar component that is instantiated
  Component
  {
    id: _snackbarComp

    Qaterial.Snackbar
    {
      id: _snackbar

      opacity: 0

      // The actual time we are using that can be override by the user
      property real snackbarTimeout: _root.settings.timeout === undefined ? Qaterial.Style.snackbar.shortDisplayTime :
        _root.settings.timeout
      // Used to call the onAccept callback or the onClose.
      property bool actionCalled
      // Indicate that the snackbar is about to be destroyed (and fade out animation is playing)
      property bool pendingDestroy

      text: _root.settings && _root.settings.text ? _root.settings.text : ""
      action: _root.settings && _root.settings.action ? _root.settings.action : ""

      onActionPressed:
      {
        if(_root.settings && _root.settings.onAccept)
        {
          _root.settings.onAccept()
          actionCalled = true
          goToPendingDestroy()
        }
      }

      /** Call to play fade out */
      function goToPendingDestroy()
      {
        pendingDestroy = true
        fadeDuration = displaySnackbar ? outFadeDuration : inFadeDuration
        opacity = 0
        _timer.interval = fadeDuration
        _timer.start()
      } // function goToPendingDestroy()

      /** Called after fading out, this will pop the next snackbar */
      function destroySnackbar()
      {
        _snackbarLoader.sourceComponent = null

        if(!actionCalled && _root.settings && _root.settings.onClose)
          _root.settings.onClose()

        _root.popSnackBar() // to know if other snack bar is required
      } // function destroySnackbar()

      /** The Manager will kill the current snackbar with an animation by using this boolean property */
      Connections
      {
        target: _root
        function onDisplaySnackbarChanged()
        {
          if(!_root.displaySnackbar && !pendingDestroy)
            goToPendingDestroy()
        }
      } // Connections

      /** Timer used to manage the lifetime of the snackbar */
      Timer
      {
        id: _timer
        interval: snackbarTimeout
        running: true
        onTriggered:
        {
          if(pendingDestroy)
            destroySnackbar()
          else
            goToPendingDestroy()
        }
      } // Timer

      readonly property real inFadeDuration: 100
      readonly property real outFadeDuration: 300
      property real fadeDuration

      /** Animation on opacity */
      Behavior on opacity
      {
        NumberAnimation
        {
          duration: fadeDuration
          easing.type: Easing.OutQuad
        } // NumberAnimation
      } // Behavior

      /** Force to play fade in animation */
      Component.onCompleted:
      {
        fadeDuration = inFadeDuration
        opacity = 1
      } // Component
    } // SnackBar
  } // Component

  /** Load the current snackbar component that use */
  Loader
  {
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    id: _snackbarLoader
  } // Loader

  property
  var settings: null
  property
  var settingsQueue: []

  /**
   * Show a snackbar immediatly or after the current snackbar.
   * The settings object have multiple optionnal field
   * - text: Text that will be displayed in the snackbar
   * - action: Action button text, if not specified, no action button will appear
   * - timeout: Time to display the snackbar in milliseconds. Default is 2000 ms.
   * - onAccept: Callback function called when the action button is pressed
   * - onClose: Callback function called when the snackbar disapear on no action button have been pressed
   * - canBeKilled: If true, the snackbar is immediately replaced by a new one on next call of show. By default true.
   */
  function show(config)
  {
    if(_snackbarLoader.sourceComponent)
    {
      if(canBeKilled)
      {
        displaySnackbar = false
        if(settingsQueue.length)
          settingsQueue.length = 0
      } // if
      settingsQueue.push(config)
    } // if
    else
    {
      settings = config
      displaySnackbar = true
      _snackbarLoader.sourceComponent = _snackbarComp
    } // else
  } // function show(config)

  /**
   * Try to load the next available snackbar in the queue.
   * This function is called when the current snackbar get destroyed
   */
  function popSnackBar()
  {
    var nextSnackbarSetting = settingsQueue.shift()
    if(nextSnackbarSetting)
      show(nextSnackbarSetting)
  } // function popSnackBar()
} // Item
