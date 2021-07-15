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

// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// Application Header
#include <Qaterial/Utils.hpp>
#include <Qaterial/Version.hpp>
#include <Qaterial/Theme.hpp>
#include <Qaterial/StepperElement.hpp>
#include <Qaterial/TreeElement.hpp>
#include <Qaterial/TextFile.hpp>
#include <Qaterial/Clipboard.hpp>
#include <Qaterial/FolderTreeModel.hpp>
#include <Qaterial/Layout.hpp>
#include <Qaterial/IconDescription.hpp>
#include <Qaterial/IconLabelPositioner.hpp>
#include <Qaterial/IconLabelImpl.hpp>

// Qt Core
#include <QDir>
#include <QLoggingCategory>

// Qt Gui
#include <QGuiApplication>
#include <QFontDatabase>

// Qt Quick Controls 2
#include <QQuickStyle>

#ifdef Q_OS_WIN
#    include <Windows.h>
#endif

Q_LOGGING_CATEGORY(qaterialUtils, "qaterial.utils");

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

// ─────────────────────────────────────────────────────────────
//                  FUNCTIONS
// ─────────────────────────────────────────────────────────────

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
                qCWarning(qaterialUtils) << "Fail to load font " << fileUrl;
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
    qCDebug(qaterialUtils) << "Load Qaterial v" << qaterial::Version::version().readable();

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

static void Qaterial_loadResources() { Qaterial_loadResources(true); }

#ifndef QATERIAL_STATIC
Q_COREAPP_STARTUP_FUNCTION(Qaterial_registerTypes);
Q_COREAPP_STARTUP_FUNCTION(Qaterial_loadResources);
#endif

using namespace qaterial;

void Utils::registerTypes(const char* uri, const quint8 major, const quint8 minor) { ::Qaterial_registerTypes(uri, major, minor); }

void Utils::loadResources() { ::Qaterial_loadResources(); }

void qaterial::registerQmlTypes(const char* uri, const quint8 major, const quint8 minor) { ::Qaterial_registerTypes(uri, major, minor); }

void qaterial::loadQmlResources(bool autoRegisterStyle) { ::Qaterial_loadResources(autoRegisterStyle); }

// Fix dpi at application startup
class HighDpiFix
{
    HighDpiFix()
    {
#ifdef Q_OS_WIN
#    if _WIN32_WINNT >= 0x0600
        ::SetProcessDPIAware();
#    endif
#endif // Q_OS_WIN
        QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    }
    static HighDpiFix singleton;
};

HighDpiFix HighDpiFix::singleton;
