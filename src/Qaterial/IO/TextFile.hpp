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

#ifndef __QATERIAL_TEXT_FILE_HPP__
#define __QATERIAL_TEXT_FILE_HPP__

#include <Qaterial/Details/Export.hpp>
#include <Qaterial/Details/Property.hpp>

#include <QtCore/QFile>
#include <QtCore/QSaveFile>
#include <QtCore/QObject>
#include <QtCore/QString>

namespace qaterial {

class QATERIAL_API_ TextFile : public QObject
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(TextFile)

    // ──── CONSTRUCTOR ────
public:
    TextFile(QObject* parent = nullptr);

    enum OpenMode
    {
        Read,
        Write,
        ReadWrite,
    };
    Q_ENUM(OpenMode)

    // ──── PROPERTIES ────
public:
    QATERIAL_PROPERTY_RO(QUrl, fileUrl, FileUrl);
    QATERIAL_PROPERTY_RO(bool, isOpen, Open);
    Q_PROPERTY(QString fileName READ fileName NOTIFY fileUrlChanged);
    Q_PROPERTY(QString fileType READ fileType NOTIFY fileUrlChanged);
    QATERIAL_PROPERTY_RO(QString, error, Error);

public:
    QString fileName() const;
    QString fileType() const;

    // ──── API ────
public Q_SLOTS:
    bool open(QUrl url, int mode);
    void close();

    bool write(const QString& string);
    QString readAll();

private:
    QSaveFile* _writeFile = nullptr;
    QFile* _readFile = nullptr;

    QFileDevice* _file() const;

    bool createAndOpenFile(const QString& file, QFileDevice::OpenMode mode);
    void closeAndDeleteFile();
};

}

#endif
