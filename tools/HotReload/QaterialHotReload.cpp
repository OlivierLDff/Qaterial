// ──── INCLUDE ────

// Oliv Qt
#include <Qaterial/Qaterial.hpp>
#include <SortFilterProxyModel/SortFilterProxyModel.hpp>

// spdlog
#ifdef WIN32
#    include <spdlog/sinks/msvc_sink.h>
#endif
#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/sinks/base_sink.h>

// Qt
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QFileSystemWatcher>

// ──── DECLARATION ────

namespace qaterial {

class HotReloadSink : public spdlog::sinks::base_sink<std::mutex>
{
public:
    class HotReload* _hotReload = nullptr;

    void sink_it_(const spdlog::details::log_msg& msg) override;
    void flush_() override {}
};

const auto hotReloadSink = std::make_shared<HotReloadSink>();

class HotReload : public QObject
{
    Q_OBJECT

public:
    HotReload(QQmlEngine* engine, QObject* parent) : QObject(parent), _engine(engine)
    {
        connect(&_watcher, &QFileSystemWatcher::fileChanged, this, &HotReload::watchedFileChanged);
    }

private:
    QQmlEngine* _engine;
    QFileSystemWatcher _watcher;

public Q_SLOTS:
    void clearCache() const { _engine->clearComponentCache(); }

    void watchFile(const QString& path) { _watcher.addPath(path); }
    void unWatchFile(const QString& path) { _watcher.removePath(path); }
Q_SIGNALS:
    void watchedFileChanged();
    void newLog(QString s);

public:
    static void registerSingleton()
    {
        qmlRegisterSingletonType<qaterial::HotReload>("Qaterial", 1, 0, "HotReload",
            [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject*
            {
                Q_UNUSED(scriptEngine);
                auto hotReload = new qaterial::HotReload(engine, engine);
                hotReloadSink->_hotReload = hotReload;
                return hotReload;
            });
    }
};

void HotReloadSink::sink_it_(const spdlog::details::log_msg& msg)
{
    if(!_hotReload)
        return;

    // log_msg is a struct containing the log entry info like level, timestamp, thread id etc.
    // msg.raw contains pre formatted log

    // If needed (very likely but not mandatory), the sink formats the message before sending it to its final destination:
    spdlog::memory_buf_t formatted;
    base_sink<std::mutex>::formatter_->format(msg, formatted);
    const auto string = fmt::to_string(formatted);
    Q_EMIT _hotReload->newLog(QString::fromStdString(string));
}

}

void qtMsgOutput(QtMsgType type, const QMessageLogContext& context, const QString& msg)
{
    const auto localMsg = msg.toLocal8Bit();
    switch(type)
    {
    case QtDebugMsg:
        qaterial::Logger::QATERIAL->debug(localMsg.constData());
        break;
    case QtInfoMsg:
        qaterial::Logger::QATERIAL->info(localMsg.constData());
        break;
    case QtWarningMsg:
        qaterial::Logger::QATERIAL->warn(localMsg.constData());
        break;
    case QtCriticalMsg:
        qaterial::Logger::QATERIAL->error(localMsg.constData());
        break;
    case QtFatalMsg:
        qaterial::Logger::QATERIAL->error(localMsg.constData());
        abort();
    }
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
    qaterial::Logger::registerSink(qaterial::hotReloadSink);
    stdoutSink->set_level(spdlog::level::debug);
    qaterial::hotReloadSink->set_level(spdlog::level::debug);
    qaterial::Logger::QATERIAL->set_level(spdlog::level::debug);
}

#include "QaterialHotReload.moc"

// ──── FUNCTIONS ────

int main(int argc, char* argv[])
{
    installLoggers();

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // ──── REGISTER APPLICATION ────

    QGuiApplication::setOrganizationName("Oliv");
    QGuiApplication::setApplicationName("Qaterial Hot Reload");
    QGuiApplication::setOrganizationDomain("https://olivierldff.github.io/Qaterial/");
    QGuiApplication::setApplicationVersion(qaterial::Version::version().readable());

    // ──── LOAD AND REGISTER QML ────

    // Important to find 'import Qaterial 1.0'
    engine.addImportPath("qrc:///");

    // Load Qaterial
    qaterial::Utils::loadResources();
    qaterial::Utils::registerTypes();
    qaterial::HotReload::registerSingleton();
    qqsfpm::utils::registerTypes();

    // Load QaterialHotReload
    Q_INIT_RESOURCE(QaterialHotReload);

    // ──── LOAD QML MAIN ────

    engine.load(QUrl("qrc:/QaterialHotReload.qml"));
    if(engine.rootObjects().isEmpty())
        return -1;

    // ──── START EVENT LOOP ────

    return QGuiApplication::exec();
}
