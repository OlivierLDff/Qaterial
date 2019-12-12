// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// C Header

// C++ Header

// Qt Header

// Dependencies Header
#include <Stringify/VersionRegex.hpp>

// Application Header
#include <Qaterial/Version.hpp>

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

QATERIAL_USING_NAMESPACE

// ─────────────────────────────────────────────────────────────
//                  FUNCTIONS
// ─────────────────────────────────────────────────────────────

Version::Version(QObject* parent): QObject(parent),
    _major(QATERIAL_VERSION_MAJOR),
    _minor(QATERIAL_VERSION_MINOR),
    _patch(QATERIAL_VERSION_PATCH),
    _tag(QATERIAL_VERSION_TAG_HEX),
    _readable(Stringify::VersionRegex::fullVersionToString(_major, _minor, _patch, _tag))
{
}
