// MIT License
//
// Copyright (c) 2020 Olivier Le Doeuff
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#ifndef __QATERIAL_UTILS_HPP__
#define __QATERIAL_UTILS_HPP__

// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// Library Headers
#include <Export.hpp>

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

void QATERIAL_API_ registerQmlTypes(const char* uri = nullptr, const quint8 major = 1, const quint8 minor = 0);

/**
 * @brief      Load qrc content in qrc:/Qaterial/
 *
 * @param[in]  autoRegisterStyle  Register Qaterial as default QQuickStyle.
 * When true, every Controls from QtQuick.Controls will be Qaterial Control's.
 * If you are not using Qaterial as your main qt quick control style. Set autoRegisterStyle to false.
 * It is true by default to be as plug and play as possible to use Qaterial.
 */
void QATERIAL_API_ loadQmlResources(bool autoRegisterStyle = true);

}

#endif // __QATERIAL_UTILS_HPP__
