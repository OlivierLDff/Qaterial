/****************************************************************************
 **
 ** Copyright (C) 2020 The Qt Company Ltd.
 ** Contact: https://www.qt.io/licensing/
 **
 ** This file is part of the Qt Graphical Effects module of the Qt Toolkit.
 **
 ** $QT_BEGIN_LICENSE:BSD$
 ** Commercial License Usage
 ** Licensees holding valid commercial Qt licenses may use this file in
 ** accordance with the commercial license agreement provided with the
 ** Software or, alternatively, in accordance with the terms contained in
 ** a written agreement between you and The Qt Company. For licensing terms
 ** and conditions see https://www.qt.io/terms-conditions. For further
 ** information use the contact form at https://www.qt.io/contact-us.
 **
 ** BSD License Usage
 ** Alternatively, you may use this file under the terms of the BSD license
 ** as follows:
 **
 ** "Redistribution and use in source and binary forms, with or without
 ** modification, are permitted provided that the following conditions are
 ** met:
 **   * Redistributions of source code must retain the above copyright
 **     notice, this list of conditions and the following disclaimer.
 **   * Redistributions in binary form must reproduce the above copyright
 **     notice, this list of conditions and the following disclaimer in
 **     the documentation and/or other materials provided with the
 **     distribution.
 **   * Neither the name of The Qt Company Ltd nor the names of its
 **     contributors may be used to endorse or promote products derived
 **     from this software without specific prior written permission.
 **
 **
 ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 ** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 ** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 ** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 ** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 ** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 ** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 ** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 ** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 ** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 **
 ** $QT_END_LICENSE$
 **
 ****************************************************************************/

import QtQuick 2.12
import GraphicalEffects

/*!
    \qmltype OpacityMask
    \inqmlmodule QtGraphicalEffects
    \since QtGraphicalEffects 1.0
    \inherits QtQuick2::Item
    \ingroup qtgraphicaleffects-mask
    \brief Masks the source item with another item.

    \table
    \header
        \li Source
        \li MaskSource
        \li Effect applied
    \row
        \li \image Original_bug.png
        \li \image OpacityMask_mask.png
        \li \image OpacityMask_bug.png
    \endtable

    \section1 Example

    The following example shows how to apply the effect.
    \snippet OpacityMask-example.qml example

*/
Item
{
  id: rootItem

  /*!
      This property defines the source item that is going to be masked.

      \note It is not supported to let the effect include itself, for
      instance by setting source to the effect's parent.
  */
  property variant source

  /*!
      This property defines the item that is going to be used as the mask. The
      mask item gets rendered into an intermediate pixel buffer and the alpha
      values from the result are used to determine the source item's pixels
      visibility in the display.

      \table
      \header
          \li Original
          \li Mask
          \li Effect applied
      \row
          \li \image Original_bug.png
          \li \image OpacityMask_mask.png
          \li \image OpacityMask_bug.png
      \endtable
  */
  property variant maskSource

  /*!
      This property allows the effect output pixels to be cached in order to
      improve the rendering performance.

      Every time the source or effect properties are changed, the pixels in
      the cache must be updated. Memory consumption is increased, because an
      extra buffer of memory is required for storing the effect output.

      It is recommended to disable the cache when the source or the effect
      properties are animated.

      By default, the property is set to \c false.

      \note It is not supported to let the effect include itself, for
      instance by setting maskSource to the effect's parent.
  */
  property bool cached: false

  /*!
      This property controls how the alpha values of the sourceMask will behave.

      If this property is \c false, the resulting opacity is the source alpha
      multiplied with the mask alpha, \c{As * Am}.

      If this property is \c true, the resulting opacity is the source alpha
      multiplied with the inverse of the mask alpha, \c{As * (1 - Am)}.

      The default is \c false.

      \since 5.7
  */
  property bool invert: false

  SourceProxy
  {
    id: sourceProxy
    input: rootItem.source
  }

  SourceProxy
  {
    id: maskSourceProxy
    input: rootItem.maskSource
  }

  ShaderEffectSource
  {
    id: cacheItem
    anchors.fill: parent
    visible: rootItem.cached
    smooth: true
    sourceItem: shaderItem
    live: true
    hideSource: visible
  }

  ShaderEffect
  {
    id: shaderItem
    property variant source: sourceProxy.output
    property variant maskSource: maskSourceProxy.output

    anchors.fill: parent

    fragmentShader: invert ? "shaders_ng/opacitymask_invert.frag.qsb" : "shaders_ng/opacitymask.frag.qsb"
  }
}
