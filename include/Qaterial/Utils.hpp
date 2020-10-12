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
    Q_DECL_DEPRECATED static void registerTypes(const char* uri = nullptr, const quint8 major = 1, const quint8 minor = 0);
    Q_DECL_DEPRECATED static void loadResources();
};

void registerQmlTypes(const char* uri = nullptr, const quint8 major = 1, const quint8 minor = 0);

/**
 * @brief      Load qrc content in qrc:/Qaterial/
 *
 * @param[in]  autoRegisterStyle  Register Qaterial as default QQuickStyle.
 * When true, every Controls from QtQuick.Controls will be Qaterial Control's.
 * If you are not using Qaterial as your main qt quick control style. Set autoRegisterStyle to false.
 * It is true by default to be as plug and play as possible to use Qaterial.
 */
void loadQmlResources(bool autoRegisterStyle = true);

}

#endif // __QATERIAL_UTILS_HPP__
