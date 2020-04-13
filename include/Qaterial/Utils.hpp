#ifndef __QATERIAL_UTILS_HPP__
#define __QATERIAL_UTILS_HPP__

// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// C Header

// C++ Header

// Qt Header

// Dependencies Header

// Application Header
#include <Qaterial/Export.hpp>

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

QATERIAL_NAMESPACE_START

// ─────────────────────────────────────────────────────────────
//                  CLASS
// ─────────────────────────────────────────────────────────────

/**
 */
class QATERIAL_API_ Utils
{
public:
    /**
     * Register type to the qml engines
     * Registered types are:
     * -
     */
    static void registerTypes(const char* uri = nullptr, const quint8 major = 1, const quint8 minor = 0);
    static void loadResources();
};

QATERIAL_NAMESPACE_END

#endif // __QATERIAL_UTILS_HPP__
