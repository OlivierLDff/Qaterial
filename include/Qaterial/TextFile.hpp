#ifndef __QATERIAL_TEXT_FILE_HPP__
#define __QATERIAL_TEXT_FILE_HPP__

// ──── INCLUDE ────

// Library Headers
#include <Qaterial/Export.hpp>
#include <Qaterial/Property.hpp>

// Dependencies Headers
#include <QFile>
#include <QSaveFile>
#include <QObject>
#include <QString>

// Standard Header

// ──── DECLARATION ────

namespace qaterial {

// ──── CLASS ────

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
