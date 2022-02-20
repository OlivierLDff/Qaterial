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
    \qmltype BrightnessContrast
    \inqmlmodule QtGraphicalEffects
    \since QtGraphicalEffects 1.0
    \inherits QtQuick2::Item
    \ingroup qtgraphicaleffects-color
    \brief Adjusts brightness and contrast.

    This effect adjusts the source item colors.
    Brightness adjustment changes the perceived luminance of the source item.
    Contrast adjustment increases or decreases the color
    and brightness variations.

    \table
    \header
        \li Source
        \li Effect applied
    \row
        \li \image Original_bug.png
        \li \image BrightnessContrast_bug.png
    \endtable

    \section1 Example

    The following example shows how to apply the effect.
    \snippet BrightnessContrast-example.qml example

*/
Item
{
  id: rootItem

  /*!
      This property defines the source item that provides the source pixels
      for the effect.

      \note It is not supported to let the effect include itself, for
      instance by setting source to the effect's parent.
  */
  property variant source

  /*!
      This property defines how much the source brightness is increased or
      decreased.

      The value ranges from -1.0 to 1.0. By default, the property is set to \c
      0.0 (no change).

      \table
      \header
      \li Output examples with different brightness values
      \li
      \li
      \row
          \li \image BrightnessContrast_brightness1.png
          \li \image BrightnessContrast_brightness2.png
          \li \image BrightnessContrast_brightness3.png
      \row
          \li \b { brightness: -0.25 }
          \li \b { brightness: 0 }
          \li \b { brightness: 0.5 }
      \row
          \li \l contrast: 0
          \li \l contrast: 0
          \li \l contrast: 0
      \endtable

  */
  property real brightness: 0.0

  /*!
      This property defines how much the source contrast is increased or
      decreased. The decrease of the contrast is linear, but the increase is
      applied with a non-linear curve to allow very high contrast adjustment at
      the high end of the value range.

      \table
      \header
          \li Contrast adjustment curve
      \row
          \li \image BrightnessContrast_contrast_graph.png
      \endtable

     The value ranges from -1.0 to 1.0. By default, the property is set to \c 0.0 (no change).

      \table
      \header
      \li Output examples with different contrast values
      \li
      \li
      \row
          \li \image BrightnessContrast_contrast1.png
          \li \image BrightnessContrast_contrast2.png
          \li \image BrightnessContrast_contrast3.png
      \row
          \li \b { contrast: -0.5 }
          \li \b { contrast: 0 }
          \li \b { contrast: 0.5 }
      \row
          \li \l brightness: 0
          \li \l brightness: 0
          \li \l brightness: 0
      \endtable

  */
  property real contrast: 0.0

  /*!
      This property allows the effect output pixels to be cached in order to
      improve the rendering performance.

      Every time the source or effect properties are changed, the pixels in
      the cache must be updated. Memory consumption is increased, because an
      extra buffer of memory is required for storing the effect output.

      It is recommended to disable the cache when the source or the effect
      properties are animated.

      By default, the property is set to \c false.

  */
  property bool cached: false

  SourceProxy
  {
    id: sourceProxy
    input: rootItem.source
    interpolation: input &&
      input.smooth ? SourceProxy.LinearInterpolation : SourceProxy.NearestInterpolation
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
    property real brightness: rootItem.brightness
    property real contrast: rootItem.contrast

    anchors.fill: parent
    blending: !rootItem.cached

    fragmentShader: "shaders_ng/brightnesscontrast.frag.qsb"
  }
}
