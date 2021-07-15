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

#include <Qaterial/Details/Version.hpp>

using namespace qaterial;

Version::Version(QObject* parent)
    : QObject(parent)
{
}

quint32 Version::major()
{
    return QATERIAL_VERSION_MAJOR;
}

quint32 Version::minor()
{
    return QATERIAL_VERSION_MINOR;
}

quint32 Version::patch()
{
    return QATERIAL_VERSION_PATCH;
}

quint32 Version::tag()
{
    return QATERIAL_VERSION_TAG_HEX;
}

QString Version::readable()
{
    return QString::number(major()) + QStringLiteral(".") + QString::number(minor()) + QStringLiteral(".") + QString::number(patch());
}

QString Version::readableWithTag()
{
    return readable() + QStringLiteral(".0x") + QString::number(tag(), 16).rightJustified(8, QChar('0'));
}
