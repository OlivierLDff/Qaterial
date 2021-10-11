// MIT License
//
// Copyright (c) 2020 Olivier Le Doeuff
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#include <Qaterial/IO/Clipboard.hpp>

#include <QtGui/QGuiApplication>
#include <QtGui/QClipboard>
#include <QtCore/QMimeData>

namespace qaterial {

Clipboard::Clipboard(QObject* parent)
    : QObject(parent)
    , _clipboard(QGuiApplication::clipboard())
{
    // If assert here it mean Clipboard have been instantiated in a non QGuiApplication context
    Q_ASSERT(_clipboard);

    connect(_clipboard,
        &QClipboard::dataChanged,
        this,
        [this]()
        {
            QClipboard* clipboard = QGuiApplication::clipboard();
            if(!clipboard)
                return;

            const auto mimeData = clipboard->mimeData();
            if(!mimeData)
                return;
            if(mimeData->hasText())
            {
                Q_EMIT textChanged();
            }
            Q_EMIT ownsChanged();
        });
}

QString Clipboard::text() const
{
    const auto mimeData = _clipboard->mimeData();
    return mimeData && mimeData->hasText() ? mimeData->text() : "";
}

void Clipboard::setText(const QString& value)
{
    // Don't copy data in clipboard if we already own the data, and data is same
    if(owns() && _clipboard->mimeData() && _clipboard->mimeData()->hasText() && _clipboard->text() == value)
        return;

    auto mimeData = new QMimeData();
    mimeData->setText(value);
    _clipboard->setMimeData(mimeData);
    Q_EMIT ownsChanged();
}

bool Clipboard::owns() const
{
    QClipboard* clipboard = QGuiApplication::clipboard();
    return clipboard->ownsClipboard();
}

void Clipboard::clear()
{
    QClipboard* clipboard = QGuiApplication::clipboard();
    clipboard->clear();
}

}
