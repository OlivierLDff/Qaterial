/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

pragma Singleton

// Qt
import QtQuick 2.12

QtObject
{
  property
  var snackBarLoader

  function show(config)
  {
    if(typeof config === 'string')
      config = { text: config }
    if(snackBarLoader)
      snackBarLoader.show(config)
  }

  function popSnackBar()
  {
    if(snackBarLoader)
      snackBarLoader.popSnackBar()
  }
}
