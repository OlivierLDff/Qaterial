/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

// Qt
import QtQuick 2.12

pragma Singleton

QtObject
{
  /**
   * @brief      Stringify a bytes count with the closest unit.
   * The count is also going to be round with 'decimals'
   *
   * @code
   * import Stringify.Formatter 1.0 as Formatter
   *
   * // ...
   *
   * const ms = 581293
   * const formatted = Formatter.Date.msToString(butes)
   * console.log("time : " + formatted)
   * // "time : 09:41:293"
   *
   * @endcode
   *
   * @param      millis Milliseconds to transform into a timestamp
   *
   * @return     Bytes string in form 'hour:minute:second:millisecond'
   */
  function msToString(millis)
  {
    let ms = millis % 1000;
    let s = (millis - ms) / 1000;
    let secs = s % 60;
    s = (s - secs) / 60;
    let mins = s % 60;
    let hrs = (s - mins) / 60;

    ms = "00" + ms
    secs = "0" + secs
    mins = "0" + mins

    return (hrs ? hrs + ':' : '') + mins.substr(-2) + ':' + secs.substr(-2) + '.' + ms.substr(-3);
  }
}
