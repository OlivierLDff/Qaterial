// ──── INCLUDE ────

// Library Headers
#include <Qaterial/Clipboard.hpp>

// Dependencies Headers

// Qt Headers
#include <QGuiApplication>
#include <QClipboard>
#include <QMimeData>

// Stl Headers

// ──── DECLARATION ────

using namespace qaterial;

// ──── FUNCTIONS ────

Clipboard::Clipboard(QObject* parent) : QObject(parent), _clipboard(QGuiApplication::clipboard())
{
    // If assert here it mean Clipboard have been instantiated in a non QGuiApplication context
    Q_ASSERT(_clipboard);

    connect(_clipboard,
        &QClipboard::dataChanged,
        this,
        [this]()
        {
            QClipboard* clipboard = QGuiApplication::clipboard();
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
