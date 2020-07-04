#ifndef __QATERIAL_CLIPBOARD_HPP__
#define __QATERIAL_CLIPBOARD_HPP__

// ──── INCLUDE ────

// Library Headers
#include <Qaterial/Export.hpp>
#include <Qaterial/Property.hpp>

// Dependencies Headers
#include <QString>
#include <QObject>

// Standard Header

// ──── DECLARATION ────

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
