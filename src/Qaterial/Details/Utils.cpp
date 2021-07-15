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

void __Qaterial_registerIconsSingleton();

static void Qaterial_registerTypes()
{
    qaterial::Version::registerSingleton(*_uri, _major, _minor);

    // THEME
    qaterial::TextTheme::registerToQml(*_uri, _major, _minor);
    qaterial::ColorTheme::registerToQml(*_uri, _major, _minor);
    qaterial::Theme::registerToQml(*_uri, _major, _minor);
    qaterial::ThemeAttached::registerToQml(*_uri, _major, _minor);

    __Qaterial_registerIconsSingleton();

    // DISPLAY

    qaterial::IconDescription::registerToQml(*_uri, _major, _minor);
    qaterial::IconLabelPositioner::registerToQml(*_uri, _major, _minor);
    qaterial::IconLabelImpl::registerToQml(*_uri, _major, _minor);

    // NAVIGATION

    qaterial::StepperElement::registerToQml(*_uri, _major, _minor);
    qmlRegisterType<qolm::QOlm<qaterial::StepperElement>>(*_uri, _major, _minor, "StepperModel");

    qaterial::TreeElement::registerToQml(*_uri, _major, _minor);
    qmlRegisterType<qaterial::TreeModel>(*_uri, _major, _minor, "TreeModel");

    // IO

    qaterial::TextFile::registerToQml(*_uri, _major, _minor);
    qaterial::Clipboard::registerSingleton(*_uri, _major, _minor);
    qaterial::FolderTreeModel::registerToQml(*_uri, _major, _minor);

    qmlRegisterAnonymousType<qaterial::LayoutAttached>(*_uri, _major);
    qaterial::Layout::registerToQml();
}

static void Qaterial_registerTypes(const char* uri, const quint8 major, const quint8 minor)
{
    if(uri)
        _uri = &uri;
    _major = major;
    _minor = minor;
    Qaterial_registerTypes();
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
}

static void Qaterial_loadResources(bool autoRegisterStyle)
{
    qCDebug(qaterialUtils).noquote().nospace() << "Load Qaterial v" << qaterial::Version::version().readable();

    // Force load qrc resources
    // This is mandatory when used as a static library
    Q_INIT_RESOURCE(Qaterial);
    Q_INIT_RESOURCE(QaterialFonts);
    Q_INIT_RESOURCE(QaterialIcons);

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
    Qaterial_loadResources(true);
}

#ifndef QATERIAL_STATIC
Q_COREAPP_STARTUP_FUNCTION(Qaterial_registerTypes);
Q_COREAPP_STARTUP_FUNCTION(Qaterial_loadResources);
#endif

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
