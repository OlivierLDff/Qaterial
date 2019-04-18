// ─────────────────────────────────────────────────────────────
//					INCLUDE
// ─────────────────────────────────────────────────────────────

// C Header

// C++ Header

// Qt Header
#include <QCoreApplication>

// Dependancies Header

// Application Header
#include <QQuickMaterialHelper.hpp>

// ─────────────────────────────────────────────────────────────
//					DECLARATION
// ─────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────
//					FUNCTIONS
// ─────────────────────────────────────────────────────────────

static const char* _defaultUri = "QQuickMaterialHelper";
static const char** _uri = &_defaultUri;
static void registerTypes()
{
}

static void registerTypes(const char* uri) { _uri = &uri; registerTypes(); }
static void LoadRessources() 
{ 
	Q_INIT_RESOURCE(QQuickMaterialHelper); 
	Q_INIT_RESOURCE(QQuickMaterialHelperFonts); 
}

Q_COREAPP_STARTUP_FUNCTION(registerTypes)
Q_COREAPP_STARTUP_FUNCTION(LoadRessources)

QQUICKMATERIALHELPER_USING_NAMESPACE;

void Helper::registerTypes(const char* uri)
{
	::registerTypes(uri);
}

void Helper::loadRessources()
{
	::LoadRessources();
}

uint32_t Helper::getMajor()
{
	return QQUICKMATERIALHELPER_VERSION_MAJOR;
}

uint32_t Helper::getMinor()
{
	return QQUICKMATERIALHELPER_VERSION_MINOR;
}

uint32_t Helper::getPatch()
{
	return QQUICKMATERIALHELPER_VERSION_PATCH;
}

uint32_t Helper::getTag()
{
	return QQUICKMATERIALHELPER_VERSION_TAG_HEX;
}

QString Helper::getVersion()
{
	return QString::number(getMajor()) + "." +
		QString::number(getMinor()) + "." +
		QString::number(getTag()) + "." +
		QString::number(getTag(),16);
}
