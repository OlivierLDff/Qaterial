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

#ifndef __QATERIAL_CLIPBOARD_HPP__
#define __QATERIAL_CLIPBOARD_HPP__

#include <Qaterial/Details/Export.hpp>
#include <Qaterial/Details/Property.hpp>

#include <QtCore/QString>
#include <QtCore/QObject>

QT_FORWARD_DECLARE_CLASS(QClipboard);

namespace qaterial {

// ──── CLASS ────

// The clipboard offers a simple mechanism to copy and paste data between applications.
// This object is a singleton accessible from Qml:
// ``` js
// import Qaterial 1.0 as Qaterial
// Item
// {
//   Component.onCompleted: Qaterial.Clipboard.copy("my text to copy")
// }
// ```
class QATERIAL_API_ Clipboard : public QObject
{
    Q_OBJECT
    QATERIAL_SINGLETON_IMPL(Clipboard, clipboard, Clipboard);

    // ──── CONSTRUCTOR ────
public:
    Clipboard(QObject* parent = nullptr);

    // ──── ATTRIBUTES ────
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged);
    Q_PROPERTY(bool owns READ owns NOTIFY ownsChanged)

    // ──── API ────
public:
    QString text() const;
    void setText(const QString& value);
    bool owns() const;

public Q_SLOTS:
    void clear();

Q_SIGNALS:
    void textChanged();
    void ownsChanged();

private:
    QClipboard* _clipboard = nullptr;
};

}

#endif
