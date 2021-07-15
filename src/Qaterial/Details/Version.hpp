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

#ifndef __QATERIAL_VERSION_HPP__
#define __QATERIAL_VERSION_HPP__

#include <Qaterial/Details/Export.hpp>
#include <Qaterial/Details/Property.hpp>

#include <QtCore/QObject>
#include <QtCore/QString>

namespace qaterial {

class QATERIAL_API_ Version : public QObject
{
    Q_OBJECT
    QATERIAL_SINGLETON_IMPL(Version, version, Version);

    // ──────── CONSTRUCTOR ────────────────
public:
    Version(QObject* parent = nullptr);

    // ──────── ATTRIBUTES ────────────────
private:
    Q_PROPERTY(quint32 major READ major CONSTANT);
    Q_PROPERTY(quint32 minor READ minor CONSTANT);
    Q_PROPERTY(quint32 patch READ patch CONSTANT);
    Q_PROPERTY(quint32 tag READ tag CONSTANT);
    Q_PROPERTY(QString readable READ readable CONSTANT);
    Q_PROPERTY(QString readableWithTag READ readableWithTag CONSTANT);

public:
    static quint32 major();
    static quint32 minor();
    static quint32 patch();
    static quint32 tag();
    static QString readable();
    static QString readableWithTag();
};

}

#endif
