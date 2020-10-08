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
    QStringList _defaultImportPaths;

    Q_PROPERTY(QStringList importPaths READ importPaths WRITE setImportPaths RESET resetImportPaths NOTIFY importPathsChanged)

public:
    QStringList importPaths() const { return _engine->importPathList(); }
    void setImportPaths(const QStringList& paths)
    {
        _engine->setImportPathList(paths);
        Q_EMIT importPathsChanged();
    }
    void resetImportPaths() { setImportPaths(_defaultImportPaths); }

Q_SIGNALS:
    void importPathsChanged();

public Q_SLOTS:
    void clearCache() const;

    void watchFile(const QString& path);
    void unWatchFile(const QString& path);
Q_SIGNALS:
    void watchedFileChanged();
    void newLog(QString s);

public:
    static std::shared_ptr<HotReloadSink> sink();

public:
    static void registerSingleton();
};

}

#endif
