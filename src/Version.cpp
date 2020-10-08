// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// Application Header
#include <Qaterial/Version.hpp>

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

using namespace qaterial;

// ─────────────────────────────────────────────────────────────
//                  FUNCTIONS
// ─────────────────────────────────────────────────────────────

Version::Version(QObject* parent) :
    QObject(parent),
    _major(QATERIAL_VERSION_MAJOR),
    _minor(QATERIAL_VERSION_MINOR),
    _patch(QATERIAL_VERSION_PATCH),
    _tag(QATERIAL_VERSION_TAG_HEX),
    _readable(QString::number(_major) + QStringLiteral(".") + QString::number(_minor) + QStringLiteral(".") + QString::number(_patch) +
              QStringLiteral(".0x") + QString::number(_tag, 16).rightJustified(8, QChar('0')))
{
}
