// ──── INCLUDE ────

// Oliv Qt
#include <Qaterial/HotReload/HotReload.hpp>

// ──── DECLARATION ────

static void HotReload_loadResources() { Q_INIT_RESOURCE(QaterialHotReload); }

using namespace qaterial;

const std::shared_ptr<HotReloadSink> HotReload::_sink = std::make_shared<HotReloadSink>();

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

HotReload::HotReload(QQmlEngine* engine, QObject* parent) : QObject(parent), _engine(engine)
{
    connect(&_watcher, &QFileSystemWatcher::fileChanged, this, &HotReload::watchedFileChanged);
    HotReload_loadResources();
}

void HotReload::clearCache() const { _engine->clearComponentCache(); }

std::shared_ptr<HotReloadSink> HotReload::sink() { return _sink; }

void HotReload::registerSingleton()
{
    qmlRegisterSingletonType<qaterial::HotReload>("Qaterial",
        1,
        0,
        "HotReload",
        [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject*
        {
            Q_UNUSED(scriptEngine);
            const auto hotReload = new qaterial::HotReload(engine, engine);
            _sink->_hotReload = hotReload;
            hotReload->_defaultImportPaths = engine->importPathList();
            return hotReload;
        });
}

void HotReload::watchFile(const QString& path) { _watcher.addPath(path); }

void HotReload::unWatchFile(const QString& path)
{
    if(!path.isEmpty())
        _watcher.removePath(path);
}
