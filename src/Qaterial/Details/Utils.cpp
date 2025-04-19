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

#include <Qaterial/Details/Utils.hpp>
#include <Qaterial/Details/Version.hpp>
#include <Qaterial/Theme/Theme.hpp>
#include <Qaterial/Navigation/StepperElement.hpp>
#include <Qaterial/Navigation/TreeElement.hpp>
#include <Qaterial/IO/TextFile.hpp>
#include <Qaterial/IO/Clipboard.hpp>
#include <Qaterial/IO/FolderTreeModel.hpp>
#include <Qaterial/Layout/Layout.hpp>
#include <Qaterial/Display/IconDescription.hpp>
#include <Qaterial/Display/IconLabelPositioner.hpp>
#include <Qaterial/Display/IconLabelImpl.hpp>

#include <QtCore/QDir>
#include <QtCore/QLoggingCategory>

#include <QtGui/QFontDatabase>

#include <QtQuickControls2/QQuickStyle>

Q_LOGGING_CATEGORY(qaterialUtils, "qaterial.utils");

static const char* _defaultUri = "Qaterial";
static const char** _uri = &_defaultUri;
static quint8 _major = 1;
static quint8 _minor = 0;
static bool registeredTypes = false;
static bool registeredRes = false;

static void Qaterial_registerTypes(const char* uri, const quint8 major, const quint8 minor)
{
    if(uri)
        _uri = &uri;
    _major = major;
    _minor = minor;
}

static void Qaterial_loadFonts()
{
    const auto loadFont = [](const QString& fontFolderPath)
    {
        const QDir dir(fontFolderPath);
        for(const auto& file: dir.entryList(QDir::Files))
        {
            const auto fileUrl = fontFolderPath + "/" + file;
            if(QFontDatabase::addApplicationFont(fileUrl) >= 0)
            {
                qCInfo(qaterialUtils) << "Load font" << fileUrl;
            }
            else
            {
                qCWarning(qaterialUtils) << "Fail to load font" << fileUrl;
            }
        }
    };

    const QDir fontsDirectory(":/Qaterial/Fonts");
    for(const auto& fontDir: fontsDirectory.entryList(QDir::Dirs | QDir::NoDotAndDotDot))
    {
        const auto fontDirPath = fontsDirectory.path() + "/" + fontDir;
        loadFont(fontDirPath);
    }
// QATERIAL_FONTS_DIRS is a : separated list of directories to load fonts from
#ifdef QATERIAL_FONTS_DIRS
    const QStringList fontDirs = QString(QATERIAL_FONTS_DIRS).split(":");
    for(const auto& fontDir: fontDirs)
    {
        qCInfo(qaterialUtils) << "Load system font from" << fontDir;
        loadFont(fontDir);
    }
#endif
}

static void Qaterial_loadResources(bool autoRegisterStyle)
{
    if(registeredRes)
        return;

    //qCDebug(qaterialUtils).noquote().nospace() << "Load Qaterial v" << qaterial::Version::version().readable();

    // Load all fonts embedded in QaterialFonts
    Qaterial_loadFonts();

    // By default Qaterial is set as qt quick controls 2 style.
    // It can be disabled for people not using Qaterial as Style, but just using some components.
    if(autoRegisterStyle)
    {
        QQuickStyle::setStyle(QStringLiteral("Qaterial"));
        QQuickStyle::setFallbackStyle(QStringLiteral("Material"));
    }
}

static void Qaterial_loadResources()
{
    if(registeredRes)
        return;

    Qaterial_loadResources(true);
}

namespace qaterial {

void registerQmlTypes(const char* uri, const quint8 major, const quint8 minor)
{
    ::Qaterial_registerTypes(uri, major, minor);
}

void loadQmlResources(bool autoRegisterStyle)
{
    ::Qaterial_loadResources(autoRegisterStyle);
}

std::uint8_t versionMajor()
{
    return QATERIAL_VERSION_MAJOR;
}

std::uint8_t versionMinor()
{
    return QATERIAL_VERSION_MINOR;
}

std::uint8_t versionPatch()
{
    return QATERIAL_VERSION_PATCH;
}

std::uint32_t versionTag()
{
    return QATERIAL_VERSION_TAG_HEX;
}

}
