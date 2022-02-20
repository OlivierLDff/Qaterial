:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: Copyright (C) 2020 The Qt Company Ltd.
:: Contact: https://www.qt.io/licensing/
::
:: This file is part of the Qt Graphical Effects module of the Qt Toolkit.
::
:: $QT_BEGIN_LICENSE:BSD$
:: Commercial License Usage
:: Licensees holding valid commercial Qt licenses may use this file in
:: accordance with the commercial license agreement provided with the
:: Software or, alternatively, in accordance with the terms contained in
:: a written agreement between you and The Qt Company. For licensing terms
:: and conditions see https://www.qt.io/terms-conditions. For further
:: information use the contact form at https://www.qt.io/contact-us.
::
:: BSD License Usage
:: Alternatively, you may use this file under the terms of the BSD license
:: as follows:
::
:: "Redistribution and use in source and binary forms, with or without
:: modification, are permitted provided that the following conditions are
:: met:
::   * Redistributions of source code must retain the above copyright
::     notice, this list of conditions and the following disclaimer.
::   * Redistributions in binary form must reproduce the above copyright
::     notice, this list of conditions and the following disclaimer in
::     the documentation and/or other materials provided with the
::     distribution.
::   * Neither the name of The Qt Company Ltd nor the names of its
::     contributors may be used to endorse or promote products derived
::     from this software without specific prior written permission.
::
::
:: THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
:: "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
:: LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
:: A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
:: OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
:: SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
:: LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
:: DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
:: THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
:: (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
:: OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
::
:: $QT_END_LICENSE$
::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::/

:: For HLSL we invoke fxc.exe (-c argument) and store the resulting intermediate format
:: instead of HLSL source, so this needs to be run on Windows from a developer command prompt.

qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o opacitymask.frag.qsb opacitymask.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o opacitymask_invert.frag.qsb opacitymask_invert.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o fastblur.frag.qsb fastblur.frag
qsb -b --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o fastblur_internal.vert.qsb fastblur_internal.vert
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o fastblur_internal.frag.qsb fastblur_internal.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o fastglow.frag.qsb fastglow.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o colorize.frag.qsb colorize.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o brightnesscontrast.frag.qsb brightnesscontrast.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o coloroverlay.frag.qsb coloroverlay.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o desaturate.frag.qsb desaturate.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o displace.frag.qsb displace.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o gammaadjust.frag.qsb gammaadjust.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o huesaturation.frag.qsb huesaturation.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o rectangularglow.frag.qsb rectangularglow.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o thresholdmask.frag.qsb thresholdmask.frag
qsb -b --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o lineargradient.vert.qsb lineargradient.vert
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o lineargradient_nomask.frag.qsb lineargradient_nomask.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o lineargradient_mask.frag.qsb lineargradient_mask.frag
qsb -b --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o radialgradient.vert.qsb radialgradient.vert
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o radialgradient_nomask.frag.qsb radialgradient_nomask.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o radialgradient_mask.frag.qsb radialgradient_mask.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o conicalgradient_nomask.frag.qsb conicalgradient_nomask.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o conicalgradient_mask.frag.qsb conicalgradient_mask.frag
qsb --glsl "150,120,100 es" --hlsl 50 -c --msl 12 -o leveladjust.frag.qsb leveladjust.frag
