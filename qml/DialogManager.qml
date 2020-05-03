/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

pragma Singleton

// Qt
import QtQuick 2.12

QtObject
{
  property var dialogLoader

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
