// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// C Header

// C++ Header

// Qt Header
#include <QCoreApplication>
#include <QQmlEngine>

// Dependencies Header

// Application Header
#include <Qaterial.hpp>

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

static QATERIAL_NAMESPACE::Version VERSION;

static QObject* registerVersionSingleton(QQmlEngine* engine, QJSEngine* scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)
    return &VERSION;
}

// ─────────────────────────────────────────────────────────────
//                  FUNCTIONS
// ─────────────────────────────────────────────────────────────

static const char* _defaultUri = "Qaterial";
static const char** _uri = &_defaultUri;
static void registerTypes()
{
    qmlRegisterSingletonType<QATERIAL_NAMESPACE::Version>(*_uri, 1, 0, "Version", registerVersionSingleton);
}

static void registerTypes(const char* uri) { _uri = &uri; registerTypes(); }
static void loadResources()
{
    Q_INIT_RESOURCE(Qaterial);
}

Q_COREAPP_STARTUP_FUNCTION(registerTypes)
Q_COREAPP_STARTUP_FUNCTION(loadResources)

QATERIAL_USING_NAMESPACE;

void Utils::registerTypes(const char* uri)
{
    ::registerTypes(uri);
}

void Utils::loadResources()
{
    ::loadResources();
}

uint32_t Utils::major()
{
    return QATERIAL_VERSION_MAJOR;
}

uint32_t Utils::minor()
{
    return QATERIAL_VERSION_MINOR;
}

uint32_t Utils::patch()
{
    return QATERIAL_VERSION_PATCH;
}

uint32_t Utils::tag()
{
    return QATERIAL_VERSION_TAG_HEX;
}

QString Utils::version()
{
    return QString::number(major()) + "." +
        QString::number(minor()) + "." +
        QString::number(patch()) + "." +
        QString::number(tag(),16);
}

quint32 Version::major() const
{
    return Utils::major();
}

quint32 Version::minor() const
{
    return Utils::minor();
}

quint32 Version::patch() const
{
    return Utils::patch();
}

quint32 Version::tag() const
{
    return Utils::tag();
}

QString Version::version() const
{
    return Utils::version();
}
