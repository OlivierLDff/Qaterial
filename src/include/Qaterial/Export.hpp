#ifndef __QATERIAL_EXPORT_HPP__
#define __QATERIAL_EXPORT_HPP__

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

#ifdef WIN32
    #ifdef QATERIAL_DLL_EXPORT  // Shared build
        #define QATERIAL_API_ __declspec(dllexport)
    #elif QATERIAL_STATIC       // No decoration when building staticlly
        #define QATERIAL_API_
    #else                       // Link to lib
        #define QATERIAL_API_ __declspec(dllimport)
    #endif
#else
    #define QATERIAL_API_
#endif // WIN32

#ifdef QATERIAL_USE_NAMESPACE

    #ifndef QATERIAL_NAMESPACE
        #define QATERIAL_NAMESPACE Qaterial
    #endif // ifndef QATERIAL_NAMESPACE

    #define QATERIAL_NAMESPACE_START namespace QATERIAL_NAMESPACE {
    #define QATERIAL_NAMESPACE_END }
    #define QATERIAL_USING_NAMESPACE using namespace QATERIAL_NAMESPACE;

#else // QATERIAL_USE_NAMESPACE

    #undef QATERIAL_NAMESPACE
    #define QATERIAL_NAMESPACE
    #define QATERIAL_NAMESPACE_START
    #define QATERIAL_NAMESPACE_END
    #define QATERIAL_USING_NAMESPACE

#endif // QATERIAL_USE_NAMESPACE

#endif // __QATERIAL_EXPORT_HPP__
