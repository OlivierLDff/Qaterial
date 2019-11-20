// ─────────────────────────────────────────────────────────────
//					INCLUDE
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
//					DECLARATION
// ─────────────────────────────────────────────────────────────

static QATERIAL_NAMESPACE::Version VERSION;

static QObject* registerVersionSingleton(QQmlEngine* engine, QJSEngine* scriptEngine)
{
    Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)
        return &VERSION;
}

// ─────────────────────────────────────────────────────────────
//					FUNCTIONS
// ─────────────────────────────────────────────────────────────

static const char* _defaultUri = "Qaterial.Impl";
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

void Helper::registerTypes(const char* uri)
{
	::registerTypes(uri);
}

void Helper::loadResources()
{
	::loadResources();
}

uint32_t Helper::major()
{
	return QATERIAL_VERSION_MAJOR;
}

uint32_t Helper::minor()
{
	return QATERIAL_VERSION_MINOR;
}

uint32_t Helper::patch()
{
	return QATERIAL_VERSION_PATCH;
}

uint32_t Helper::tag()
{
	return QATERIAL_VERSION_TAG_HEX;
}

QString Helper::version()
{
	return QString::number(major()) + "." +
		QString::number(minor()) + "." +
		QString::number(patch()) + "." +
		QString::number(tag(),16);
}

quint32 Version::major() const
{
    return Helper::major();
}

quint32 Version::minor() const
{
    return Helper::minor();
}

quint32 Version::patch() const
{
    return Helper::patch();
}

quint32 Version::tag() const
{
    return Helper::tag();
}

QString Version::version() const
{
    return Helper::version();
}
