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
static void RegisterTypes()
{
}

static void RegisterTypes(const char* uri) { _uri = &uri; RegisterTypes(); }
static void LoadRessources() 
{ 
	Q_INIT_RESOURCE(QQuickMaterialHelper); 
	Q_INIT_RESOURCE(QQuickMaterialHelperFonts); 
}

Q_COREAPP_STARTUP_FUNCTION(RegisterTypes)
Q_COREAPP_STARTUP_FUNCTION(LoadRessources)

QQUICKMATERIALHELPER_USING_NAMESPACE;

void Helper::RegisterTypes(const char* uri)
{
	::RegisterTypes(uri);
}

void Helper::LoadRessources()
{
	::LoadRessources();
}

uint32_t Helper::GetMajor()
{
	return QQUICKMATERIALHELPER_VERSION_MAJOR;
}

uint32_t Helper::GetMinor()
{
	return QQUICKMATERIALHELPER_VERSION_MINOR;
}

uint32_t Helper::GetPatch()
{
	return QQUICKMATERIALHELPER_VERSION_PATCH;
}

uint32_t Helper::GetTag()
{
	return QQUICKMATERIALHELPER_VERSION_TAG_HEX;
}

QString Helper::GetVersion()
{
	return QString::number(GetMajor()) + "." +
		QString::number(GetMinor()) + "." +
		QString::number(GetTag()) + "." +
		QString::number(GetTag(),16);
}
