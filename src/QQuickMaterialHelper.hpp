#ifndef __QQUICKMATERIALHELPER_HPP__
#define __QQUICKMATERIALHELPER_HPP__

// ─────────────────────────────────────────────────────────────
//					INCLUDE
// ─────────────────────────────────────────────────────────────

// C Header
#include <stdint.h>

// C++ Header

// Qt Header
#include <QString>

// Dependencies Header

// Application Header

// ─────────────────────────────────────────────────────────────
//					DECLARATION
// ─────────────────────────────────────────────────────────────

#ifdef WIN32
	#ifdef QQUICKMATERIALHELPER_SHARED	// Shared build
		#define QQUICKMATERIALHELPER_API_ __declspec(dllexport)
	#elif QQUICKMATERIALHELPER_STATIC 	// No decoration when building staticlly
		#define QQUICKMATERIALHELPER_API_
	#else 				// Link to lib 
		#define QQUICKMATERIALHELPER_API_ __declspec(dllimport)
	#endif
#else
	#define QQUICKMATERIALHELPER_API_
#endif

#ifdef QQUICKMATERIALHELPER_USE_NAMESPACE
#ifndef QQUICKMATERIALHELPER_NAMESPACE
#define QQUICKMATERIALHELPER_NAMESPACE QQuickMaterialHelper
#endif
#define QQUICKMATERIALHELPER_NAMESPACE_START namespace QQUICKMATERIALHELPER_NAMESPACE {
#define QQUICKMATERIALHELPER_NAMESPACE_END }
#define QQUICKMATERIALHELPER_USING_NAMESPACE using namespace QQUICKMATERIALHELPER_NAMESPACE;
#else
#undef QQUICKMATERIALHELPER_NAMESPACE
#define QQUICKMATERIALHELPER_NAMESPACE
#define QQUICKMATERIALHELPER_NAMESPACE_START
#define QQUICKMATERIALHELPER_NAMESPACE_END
#define QQUICKMATERIALHELPER_USING_NAMESPACE
#endif

QQUICKMATERIALHELPER_NAMESPACE_START

// ─────────────────────────────────────────────────────────────
//					CLASS
// ─────────────────────────────────────────────────────────────

/**
 */
class QQUICKMATERIALHELPER_API_ Helper
{
public:
	static void registerTypes(const char* uri = nullptr);
	static void loadResources();
	/** Library Major Version */
	static uint32_t getMajor();
	/** Library Minor Version */
	static uint32_t getMinor();
	/** Library Patch Version */
	static uint32_t getPatch();
	/** Library Tag Version */
	static uint32_t getTag();
	/** get version in form major.minor.patch.tag */
	static QString getVersion();
};

QQUICKMATERIALHELPER_NAMESPACE_END

#endif
