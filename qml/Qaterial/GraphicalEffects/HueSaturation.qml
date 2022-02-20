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
    \qmltype HueSaturation
    \inqmlmodule QtGraphicalEffects
    \since QtGraphicalEffects 1.0
    \inherits QtQuick2::Item
    \ingroup qtgraphicaleffects-color
    \brief Alters the source item colors in the HSL color space.

    HueSaturation is similar to the \l{QtGraphicalEffects::Colorize}{Colorize}
    effect, but the hue and saturation property values are handled differently.
    The HueSaturation effect always shifts the hue, saturation, and lightness
    from the original, instead of setting them.

    \table
    \header
        \li Source
        \li Effect applied
    \row
        \li \image Original_bug.png
        \li \image HueSaturation_bug.png
    \endtable

    \section1 Example

    The following example shows how to apply the effect.
    \snippet HueSaturation-example.qml example

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
  property variant source: 0

  /*!
      This property defines the hue value which is added to the source hue
      value.

      The value ranges from -1.0 (decrease) to 1.0 (increase). By default, the
      property is set to \c 0.0 (no change).

      \table
      \header
      \li Output examples with different hue values
      \li
      \li
      \row
          \li \image HueSaturation_hue1.png
          \li \image HueSaturation_hue2.png
          \li \image HueSaturation_hue3.png
      \row
          \li \b { hue: -0.3 }
          \li \b { hue: 0.0 }
          \li \b { hue: 0.3 }
      \row
          \li \l saturation: 0
          \li \l saturation: 0
          \li \l saturation: 0
      \row
          \li \l lightness: 0
          \li \l lightness: 0
          \li \l lightness: 0
      \endtable

  */
  property real hue: 0.0

  /*!
      This property defines the saturation value value which is added to the
      source saturation value.

      The value ranges from -1.0 (decrease) to 1.0 (increase). By default, the
      property is set to \c 0.0 (no change).

      \table
      \header
      \li Output examples with different saturation values
      \li
      \li
      \row
          \li \image HueSaturation_saturation1.png
          \li \image HueSaturation_saturation2.png
          \li \image HueSaturation_saturation3.png
      \row
          \li \b { saturation: -0.8 }
          \li \b { saturation: 0.0 }
          \li \b { saturation: 1.0 }
      \row
          \li \l hue: 0
          \li \l hue: 0
          \li \l hue: 0
      \row
          \li \l lightness: 0
          \li \l lightness: 0
          \li \l lightness: 0
      \endtable

  */
  property real saturation: 0.0

  /*!
      This property defines the lightness value which is added to the source
      saturation value.

      The value ranges from -1.0 (decrease) to 1.0 (increase). By default, the
      property is set to \c 0.0 (no change).

      \table
      \header
      \li Output examples with different lightness values
      \li
      \li
      \row
          \li \image HueSaturation_lightness1.png
          \li \image HueSaturation_lightness2.png
          \li \image HueSaturation_lightness3.png
      \row
          \li \b { lightness: -0.5 }
          \li \b { lightness: 0.0 }
          \li \b { lightness: 0.5 }
      \row
          \li \l hue: 0
          \li \l hue: 0
          \li \l hue: 0
      \row
          \li \l saturation: 0
          \li \l saturation: 0
          \li \l saturation: 0
      \endtable

  */
  property real lightness: 0.0

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
    interpolation: input && input.smooth ? SourceProxy.LinearInterpolation : SourceProxy.NearestInterpolation
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
    property variant hsl: Qt.vector3d(rootItem.hue, rootItem.saturation, rootItem.lightness)

    anchors.fill: parent

    fragmentShader: "shaders_ng/huesaturation.frag.qsb"
  }
}
