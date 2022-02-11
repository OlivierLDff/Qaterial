/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

pragma Singleton

// Qt
import QtQuick

QtObject
{
  property Item dialogLoader

  // New API

  function showDialog(settings)
  {
    if(dialogLoader)
      dialogLoader.showDialog(settings)
  }

  function showSaveFileDialog(settings)
  {
    if(dialogLoader)
      dialogLoader.showSaveFileDialog(settings)
  }

  function showOpenFileDialog(settings)
  {
    if(dialogLoader)
      dialogLoader.showOpenFileDialog(settings)
  }

  function showOpenFilesDialog(settings)
  {
    if(dialogLoader)
      dialogLoader.showOpenFileDialog(settings)
  }

  function showFolderDialog(settings)
  {
    if(dialogLoader)
      dialogLoader.showFolderDialog(settings)
  }

  function showTextFieldDialog(settings)
  {
    if(dialogLoader)
      dialogLoader.showTextFieldDialog(settings)
  }

  // Deprecated API

  function closeIfAlreadyOpened()
  {
    if(dialogLoader)
      dialogLoader.closeIfAlreadyOpened()
  }

  function openWithSettings(dialogManagerSettings)
  {
    if(dialogLoader)
      dialogLoader.openWithSettings(dialogManagerSettings)
  }

  function openTextField(textFieldDialogSettings)
  {
    if(dialogLoader)
      dialogLoader.openTextField(textFieldDialogSettings)
  }

  function openBusyIndicator(busyIndicatorDialogSettings)
  {
    if(dialogLoader)
      dialogLoader.openBusyIndicator(busyIndicatorDialogSettings)
  }

  function closeBusyIndicator()
  {
    if(dialogLoader)
      dialogLoader.closeBusyIndicator()
  }

  function openRadioListView(radioListViewDialogSettings)
  {
    if(dialogLoader)
      dialogLoader.openRadioListView(radioListViewDialogSettings)
  }

  function openFromComponent(component)
  {
    if(dialogLoader)
      dialogLoader.openFromComponent(component)
  }

  function close()
  {
    if(dialogLoader)
      dialogLoader.close()
  }

}
