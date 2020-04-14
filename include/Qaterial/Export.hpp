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

#endif
