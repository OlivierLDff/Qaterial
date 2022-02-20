/****************************************************************************
**
** Copyright (C) 2016 Jolla Ltd, author: <gunnar.sletta@jollamobile.com>
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

#include "qgfxsourceproxy_p.h"

#include <private/qquickimage_p.h>
#include <private/qquickitem_p.h>
#include <private/qquickshadereffectsource_p.h>

QT_BEGIN_NAMESPACE

QGfxSourceProxy::QGfxSourceProxy(QQuickItem *item) : QQuickItem(item), m_input(0), m_output(0), m_proxy(0), m_interpolation(AnyInterpolation)
{
}

QGfxSourceProxy::~QGfxSourceProxy()
{
    delete m_proxy;
}

void QGfxSourceProxy::setInput(QQuickItem *input)
{
    if (m_input == input)
        return;

    if (m_input != nullptr)
        m_input->disconnect(this);
    m_input = input;
    polish();
    if (m_input != nullptr)
    {
        if (QQuickImage *image = qobject_cast<QQuickImage *>(m_input))
        {
            connect(image, &QQuickImage::sourceSizeChanged, this, &QGfxSourceProxy::repolish);
            connect(image, &QQuickImage::fillModeChanged, this, &QGfxSourceProxy::repolish);
        }
        connect(m_input, &QQuickItem::childrenChanged, this, &QGfxSourceProxy::repolish);
    }
    emit inputChanged();
}

void QGfxSourceProxy::setOutput(QQuickItem *output)
{
    if (m_output == output)
        return;
    m_output = output;
    emit activeChanged();
    emit outputChanged();
}

void QGfxSourceProxy::setSourceRect(const QRectF &sourceRect)
{
    if (m_sourceRect == sourceRect)
        return;
    m_sourceRect = sourceRect;
    polish();
    emit sourceRectChanged();
}

void QGfxSourceProxy::setInterpolation(Interpolation i)
{
    if (m_interpolation == i)
        return;
    m_interpolation = i;
    polish();
    emit interpolationChanged();
}

void QGfxSourceProxy::useProxy()
{
    if (!m_proxy)
        m_proxy = new QQuickShaderEffectSource(this);
    m_proxy->setSourceRect(m_sourceRect);
    m_proxy->setSourceItem(m_input);
    m_proxy->setSmooth(m_interpolation != NearestInterpolation);
    setOutput(m_proxy);
}

void QGfxSourceProxy::repolish()
{
    polish();
}

QObject *QGfxSourceProxy::findLayer(QQuickItem *item)
{
    if (!item)
        return 0;
    QQuickItemPrivate *d = QQuickItemPrivate::get(item);
    if (d->extra.isAllocated() && d->extra->layer)
    {
        QObject *layer = qvariant_cast<QObject *>(item->property("layer"));
        if (layer && layer->property("enabled").toBool())
            return layer;
    }
    return 0;
}

void QGfxSourceProxy::updatePolish()
{
    if (m_input == 0)
    {
        setOutput(0);
        return;
    }

    QQuickImage *image = qobject_cast<QQuickImage *>(m_input);
    QQuickShaderEffectSource *shaderSource = qobject_cast<QQuickShaderEffectSource *>(m_input);
    bool childless = m_input->childItems().size() == 0;
    bool interpOk = m_interpolation == AnyInterpolation || (m_interpolation == LinearInterpolation && m_input->smooth() == true) ||
                    (m_interpolation == NearestInterpolation && m_input->smooth() == false);

    // Layers can be used in two different ways. Option 1 is when the item is
    // used as input to a separate ShaderEffect component. In this case,
    // m_input will be the item itself.
    QObject *layer = findLayer(m_input);
    if (!layer && shaderSource)
    {
        // Alternatively, the effect is applied via layer.effect, and the
        // input to the effect will be the layer's internal ShaderEffectSource
        // item. In this case, we need to backtrack and find the item that has
        // the layer and configure it accordingly.
        layer = findLayer(shaderSource->sourceItem());
    }

    // A bit crude test, but we're only using source rect for
    // blurring+transparent edge, so this is good enough.
    bool padded = m_sourceRect.x() < 0 || m_sourceRect.y() < 0;

    bool direct = false;

    if (layer)
    {
        // Auto-configure the layer so interpolation and padding works as
        // expected without allocating additional FBOs. In edgecases, where
        // this feature is undesiered, the user can simply use
        // ShaderEffectSource rather than layer.
        layer->setProperty("sourceRect", m_sourceRect);
        layer->setProperty("smooth", m_interpolation != NearestInterpolation);
        direct = true;
    }
    else if (childless && interpOk)
    {

        if (shaderSource)
        {
            if (shaderSource->sourceRect() == m_sourceRect || m_sourceRect.isEmpty())
                direct = true;
        }
        else if (!padded && ((image && image->fillMode() == QQuickImage::Stretch && !image->sourceSize().isNull()) || (!image && m_input->isTextureProvider())))
        {
            direct = true;
        }
    }

    if (direct)
    {
        setOutput(m_input);
    }
    else
    {
        useProxy();
    }

    // Remove the proxy if it is not in use..
    if (m_proxy && m_output == m_input)
    {
        delete m_proxy;
        m_proxy = 0;
    }
}

QT_END_NAMESPACE
