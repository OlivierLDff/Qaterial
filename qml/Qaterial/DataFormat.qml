/**
 * Copyright (C) Olivier Le Doeuff 2019
 * Contact: olivier.ldff@gmail.com
 */

pragma Singleton

// Qt
import QtQuick 2.12

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
   * const bytes = 581293
   * const formatted = Formatter.Data.formatBytes(butes)
   * console.log("bytes : " + formatted)
   * // "bytes : 58.12 KB"
   *
   * @endcode
   *
   * @param      bytes     The bytes to stringify
   * @param      decimals  The decimals
   *
   * @return     Bytes string in form '12.87 GB'
   */
  function formatBytes(bytes, decimals = 2)
  {
    if(!bytes || isNaN(bytes) || isNaN(decimals) || bytes === 0)
      return '0 Bytes';

    const k = 1024;
    const dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

    const i = Math.floor(Math.log(bytes) / Math.log(k));

    return parseFloat((bytes / Math.pow(k, i))
      .toFixed(dm)) + ' ' + sizes[i];
  }

  function formatBits(bytes, decimals = 2)
  {
    if(!bytes || isNaN(bytes) || isNaN(decimals) || bytes === 0)
      return '0 bits';

    const k = 1024;
    const dm = decimals < 0 ? 0 : decimals;
    const sizes = ['bits', 'Kb', 'Mb', 'Gb', 'Tb', 'Pb', 'Eb', 'Zb', 'Yb'];

    const i = Math.floor(Math.log(bytes) / Math.log(k));

    return parseFloat((bytes / Math.pow(k, i))
      .toFixed(dm)) + ' ' + sizes[i];
  }
}
