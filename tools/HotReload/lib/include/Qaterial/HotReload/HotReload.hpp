#ifndef __QATERIAL_HOT_RELOAD_HPP__
#define __QATERIAL_HOT_RELOAD_HPP__

// ──── INCLUDE ────

#include <Qaterial/Qaterial.hpp>
#include <spdlog/sinks/base_sink.h>

#include <QQmlEngine>
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

class HotReload : public QObject
{
    Q_OBJECT

public:
    HotReload(QQmlEngine* engine, QObject* parent);

private:
    QQmlEngine* _engine;
    QFileSystemWatcher _watcher;
    static const std::shared_ptr<HotReloadSink> _sink;

public Q_SLOTS:
    void clearCache() const { _engine->clearComponentCache(); }

    void watchFile(const QString& path) { _watcher.addPath(path); }
    void unWatchFile(const QString& path) { _watcher.removePath(path); }
Q_SIGNALS:
    void watchedFileChanged();
    void newLog(QString s);

public:
    static std::shared_ptr<HotReloadSink> sink() { return _sink; }

public:
    static void registerSingleton()
    {
        qmlRegisterSingletonType<qaterial::HotReload>("Qaterial", 1, 0, "HotReload",
            [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject*
            {
                Q_UNUSED(scriptEngine);
                const auto hotReload = new qaterial::HotReload(engine, engine);
                _sink->_hotReload = hotReload;
                return hotReload;
            });
    }
};

}

#endif
