// ──── INCLUDE ────

// Oliv Qt
#include <Qaterial/Qaterial.hpp>
#include <Qaterial/HotReload/HotReload.hpp>
#include <SortFilterProxyModel/SortFilterProxyModel.hpp>

// spdlog
#ifdef WIN32
#    include <spdlog/sinks/msvc_sink.h>
#endif
#include <spdlog/sinks/stdout_color_sinks.h>

// Qt
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

// ──── DECLARATION ────

void qtMsgOutput(QtMsgType type, const QMessageLogContext& context, const QString& msg)
{
    const auto localMsg = msg.toLocal8Bit();
    switch(type)
    {
    case QtDebugMsg: qaterial::Logger::QATERIAL->debug(localMsg.constData()); break;
    case QtInfoMsg: qaterial::Logger::QATERIAL->info(localMsg.constData()); break;
    case QtWarningMsg: qaterial::Logger::QATERIAL->warn(localMsg.constData()); break;
    case QtCriticalMsg: qaterial::Logger::QATERIAL->error(localMsg.constData()); break;
    case QtFatalMsg: qaterial::Logger::QATERIAL->error(localMsg.constData()); abort();
    }

#if defined(Q_OS_WIN)
    //OutputDebugStringW(reinterpret_cast<const wchar_t*>(msg.utf16()));
#elif defined(Q_OS_ANDROID)
    android_default_message_handler(type, context, msg);
#endif
}

void installLoggers()
{
    qInstallMessageHandler(qtMsgOutput);
#ifdef WIN32
    const auto msvcSink = std::make_shared<spdlog::sinks::msvc_sink_mt>();
    qaterial::Logger::registerSink(msvcSink);
#endif
    const auto stdoutSink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
    qaterial::Logger::registerSink(stdoutSink);
    qaterial::Logger::registerSink(qaterial::HotReload::sink());
    stdoutSink->set_level(spdlog::level::debug);
    qaterial::HotReload::sink()->set_level(spdlog::level::debug);
    qaterial::Logger::QATERIAL->set_level(spdlog::level::debug);
}

// ──── FUNCTIONS ────

int main(int argc, char* argv[])
{
    installLoggers();

    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // ──── REGISTER APPLICATION ────

    QGuiApplication::setOrganizationName("Qaterial");
    QGuiApplication::setApplicationName("Qaterial Hot Reload");
    QGuiApplication::setOrganizationDomain("https://olivierldff.github.io/Qaterial/");
    QGuiApplication::setApplicationVersion(qaterial::Version::version().readable());

    // ──── LOAD AND REGISTER QML ────

    // Important to find 'import Qaterial 1.0'
    engine.addImportPath("qrc:/");

    // Load Qaterial
    qaterial::loadQmlResources();
    qaterial::registerQmlTypes();
    qaterial::HotReload::registerSingleton();
    Q_INIT_RESOURCE(QaterialHotReloadApp);
    qqsfpm::registerQmlTypes();

    // ──── LOAD QML MAIN ────

    engine.load(QUrl("qrc:/Qaterial/HotReload/Main.qml"));
    if(engine.rootObjects().isEmpty())
        return -1;

    // ──── START EVENT LOOP ────

    return QGuiApplication::exec();
}
