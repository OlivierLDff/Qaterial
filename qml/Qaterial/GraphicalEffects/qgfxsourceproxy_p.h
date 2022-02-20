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

#ifndef QGFXSOURCEPROXY_P_H
#define QGFXSOURCEPROXY_P_H

#include <QQuickItem>

QT_BEGIN_NAMESPACE

class QQuickShaderEffectSource;

class QGfxSourceProxy : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(QQuickItem *input READ input WRITE setInput NOTIFY inputChanged RESET resetInput)
    Q_PROPERTY(QQuickItem *output READ output NOTIFY outputChanged)
    Q_PROPERTY(QRectF sourceRect READ sourceRect WRITE setSourceRect NOTIFY sourceRectChanged)

    Q_PROPERTY(bool active READ isActive NOTIFY activeChanged)
    Q_PROPERTY(Interpolation interpolation READ interpolation WRITE setInterpolation NOTIFY interpolationChanged)

    Q_ENUMS(Interpolation)

  public:
    enum Interpolation
    {
        AnyInterpolation,
        NearestInterpolation,
        LinearInterpolation
    };

    QGfxSourceProxy(QQuickItem *item = 0);
    ~QGfxSourceProxy();

    QQuickItem *input() const
    {
        return m_input;
    }
    void setInput(QQuickItem *input);
    void resetInput()
    {
        setInput(0);
    }

    QQuickItem *output() const
    {
        return m_output;
    }

    QRectF sourceRect() const
    {
        return m_sourceRect;
    }
    void setSourceRect(const QRectF &sourceRect);

    bool isActive() const
    {
        return m_output && m_output != m_input;
    }

    void setInterpolation(Interpolation i);
    Interpolation interpolation() const
    {
        return m_interpolation;
    }

  protected:
    void updatePolish() override;

  signals:
    void inputChanged();
    void outputChanged();
    void sourceRectChanged();
    void activeChanged();
    void interpolationChanged();

  private slots:
    void repolish();

  private:
    void setOutput(QQuickItem *output);
    void useProxy();
    static QObject *findLayer(QQuickItem *);

    QRectF m_sourceRect;
    QQuickItem *m_input;
    QQuickItem *m_output;
    QQuickShaderEffectSource *m_proxy;

    Interpolation m_interpolation;
};

QT_END_NAMESPACE

#endif // QGFXSOURCEPROXY_P_H
