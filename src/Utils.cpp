// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// C Header

// C++ Header

// Qt Header
#include <QCoreApplication> // Call register type at startup when loaded as a dynamic library
#include <QLoggingCategory> // Logging support

// Dependencies Header

// Application Header
#include <Qaterial/Utils.hpp>
#include <Qaterial/Version.hpp>

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

Q_LOGGING_CATEGORY(QATERIAL_UTILS_LOG_CAT, "qaterial.utils")

// ─────────────────────────────────────────────────────────────
//                  FUNCTIONS
// ─────────────────────────────────────────────────────────────

static const char* _defaultUri = "Qaterial";
static const char** _uri = &_defaultUri;
static quint8 _major = 1;
static quint8 _minor = 0;

static void Qaterial_registerTypes()
{
    qCDebug(QATERIAL_UTILS_LOG_CAT, "Register Qaterial v%s", qPrintable(Qaterial::Version::version().readable()));

    qCDebug(QATERIAL_UTILS_LOG_CAT, "Register Singleton %s.Version %d.%d to QML", *_uri, _major, _minor);
    QATERIAL_NAMESPACE::Version::registerSingleton(*_uri, _major, _minor);
}

static void Qaterial_registerTypes(const char* uri, const quint8 major, const quint8 minor)
{
    if(uri)
        _uri = &uri;
    _major = major;
    _minor = minor;
    Qaterial_registerTypes();
}

static void Qaterial_loadResources()
{
    qCDebug(QATERIAL_UTILS_LOG_CAT, "Load Qaterial.qrc v%s", qPrintable(Qaterial::Version::version().readable()));
    Q_INIT_RESOURCE(Qaterial);
}

#ifndef QATERIAL_STATIC
Q_COREAPP_STARTUP_FUNCTION(Qaterial_registerTypes);
Q_COREAPP_STARTUP_FUNCTION(Qaterial_loadResources);
#endif

QATERIAL_USING_NAMESPACE;

void Utils::registerTypes(const char* uri, const quint8 major, const quint8 minor)
{
    ::Qaterial_registerTypes(uri, major, minor);
}

void Utils::loadResources()
{
    ::Qaterial_loadResources();
}
