// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// Application Header
#include <Qaterial/Utils.hpp>
#include <Qaterial/Version.hpp>
#include <Qaterial/Logger.hpp>
#include <Qaterial/StepperElement.hpp>
#include <Qaterial/TreeElement.hpp>
#include <Qaterial/TextFile.hpp>
#include <Qaterial/Clipboard.hpp>
#include <Qaterial/FolderTreeModel.hpp>
#include <Qaterial/Layout.hpp>

// Qt Core
#include <QDir>

// Qt Gui
#include <QGuiApplication>
#include <QFontDatabase>

// Qt Quick Controls 2
#include <QQuickStyle>

#ifdef Q_OS_WIN
#    include <Windows.h>
#endif

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

// clang-format off
#ifdef NDEBUG
# define LOG_DEV_DEBUG(str, ...) do {} while (0)
#else
# define LOG_DEV_DEBUG(str, ...) qaterial::Logger::UTILS->debug( str, ## __VA_ARGS__ )
#endif

#ifdef NDEBUG
# define LOG_DEV_INFO(str, ...)  do {} while (0)
#else
# define LOG_DEV_INFO(str, ...)  qaterial::Logger::UTILS->info(  str, ## __VA_ARGS__ )
#endif

#ifdef NDEBUG
# define LOG_DEV_WARN(str, ...)  do {} while (0)
#else
# define LOG_DEV_WARN(str, ...)  qaterial::Logger::UTILS->warn(  str, ## __VA_ARGS__ )
#endif

#ifdef NDEBUG
# define LOG_DEV_ERR(str, ...)   do {} while (0)
#else
# define LOG_DEV_ERR(str, ...)   qaterial::Logger::UTILS->error( str, ## __VA_ARGS__ )
#endif

#define LOG_DEBUG(str, ...)      qaterial::Logger::UTILS->debug( str, ## __VA_ARGS__ )
#define LOG_INFO(str, ...)       qaterial::Logger::UTILS->info(  str, ## __VA_ARGS__ )
#define LOG_WARN(str, ...)       qaterial::Logger::UTILS->warn(  str, ## __VA_ARGS__ )
#define LOG_ERR(str, ...)        qaterial::Logger::UTILS->error( str, ## __VA_ARGS__ )
// clang-format on

// ─────────────────────────────────────────────────────────────
//                  FUNCTIONS
// ─────────────────────────────────────────────────────────────

static const char* _defaultUri = "Qaterial";
static const char** _uri = &_defaultUri;
static quint8 _major = 1;
static quint8 _minor = 0;

static void Qaterial_registerTypes()
{
    LOG_DEV_INFO("Register Qaterial v{}", qaterial::Version::version().readable().toStdString());

    LOG_DEV_INFO("Register Singleton {}.Version {}.{} to QML", *_uri, _major, _minor);
    qaterial::Version::registerSingleton(*_uri, _major, _minor);

    LOG_DEV_INFO("Register Singleton {}.Logger {}.{} to QML", *_uri, _major, _minor);
    qaterial::Logger::registerSingleton(*_uri, _major, _minor);

    // NAVIGATION

    LOG_DEV_INFO("Register {}.StepperElement {}.{} to QML", *_uri, _major, _minor);
    qaterial::StepperElement::registerToQml(*_uri, _major, _minor);
    LOG_DEV_INFO("Register {}.StepperModel {}.{} to QML", *_uri, _major, _minor);
    qmlRegisterType<qolm::QOlm<qaterial::StepperElement>>(*_uri, _major, _minor, "StepperModel");

    LOG_DEV_INFO("Register {}.TreeElement {}.{} to QML", *_uri, _major, _minor);
    qaterial::TreeElement::registerToQml(*_uri, _major, _minor);
    LOG_DEV_INFO("Register {}.StepperModel {}.{} to QML", *_uri, _major, _minor);
    qmlRegisterType<qaterial::TreeModel>(*_uri, _major, _minor, "TreeModel");

    // IO

    LOG_DEV_INFO("Register {}.TextFile {}.{} to QML", *_uri, _major, _minor);
    qaterial::TextFile::registerToQml(*_uri, _major, _minor);
    LOG_DEV_INFO("Register Singleton {}.Clipboard {}.{} to QML", *_uri, _major, _minor);
    qaterial::Clipboard::registerSingleton(*_uri, _major, _minor);
    LOG_DEV_INFO("Register {}.FolderTreeModel {}.{} to QML", *_uri, _major, _minor);
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
                LOG_INFO("Load font {}", fileUrl.toStdString());
            else
                LOG_ERR("Fail to load font {}", fileUrl.toStdString());
        }
    };

    const QDir fontsDirectory(":/Qaterial/Fonts");
    for(const auto& fontDir: fontsDirectory.entryList(QDir::Dirs | QDir::NoDotAndDotDot))
    {
        const auto fontDirPath = fontsDirectory.path() + "/" + fontDir;
        loadFont(fontDirPath);
    }
}

static void Qaterial_loadResources(bool autoRegisterStyle = true)
{
    LOG_DEV_INFO("Load Qaterial v{}", qPrintable(qaterial::Version::version().readable()));

    // Force load qrc resources
    // This is mandatory when used as a static library
    Q_INIT_RESOURCE(Qaterial);
    Q_INIT_RESOURCE(QaterialFonts);
    Q_INIT_RESOURCE(QaterialIcons);
    Q_INIT_RESOURCE(QaterialIconsImpl);

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
