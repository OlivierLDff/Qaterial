#ifndef __QATERIAL_UTILS_HPP__
#define __QATERIAL_UTILS_HPP__

// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// Library Headers
#include <Qaterial/Export.hpp>

// Qt Headers
#include <QtGlobal>

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

namespace qaterial {

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
    Q_DECL_DEPRECATED static void registerTypes(
        const char* uri = nullptr, const quint8 major = 1, const quint8 minor = 0);
    Q_DECL_DEPRECATED static void loadResources();
};

void registerQmlTypes(const char* uri = nullptr, const quint8 major = 1, const quint8 minor = 0);
void loadQmlResources();

}

#endif  // __QATERIAL_UTILS_HPP__
