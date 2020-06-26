#ifndef __QATERIAL_UTILS_LOGGER_HPP__
#define __QATERIAL_UTILS_LOGGER_HPP__

// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// Library Headers
#include <Qaterial/Export.hpp>
#include <Qaterial/Property.hpp>

// Dependencies Headers
#include <spdlog/spdlog.h>
#include <spdlog/sinks/sink.h>

// Stl Headers
#include <memory>
#include <set>

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

namespace qaterial {

// ─────────────────────────────────────────────────────────────
//                  CLASS
// ─────────────────────────────────────────────────────────────

/**
 * Define static logger that library use.
 * You need to install sink on them
 */
class QATERIAL_API_ Logger : public QObject
{
    Q_OBJECT
    QATERIAL_SINGLETON_IMPL(Logger, logger, Logger);

public:
    Logger(QObject* parent = nullptr) : QObject(parent) {}

    // ─────── TYPES ─────────
public:
    using Log = spdlog::logger;
    using LogPtr = std::shared_ptr<Log>;
    using LogList = std::set<LogPtr>;
    using Sink = spdlog::sinks::sink;
    using SinkPtr = std::shared_ptr<Sink>;

    // ─────── LOGGERS NAME ─────────
public:
    static const char* const UTILS_NAME;
    static const char* const FILE_NAME;
    static const char* const QATERIAL_NAME;

    // ─────── LOGGERS ─────────
public:
    static const LogPtr UTILS;
    static const LogPtr FILE;
    static const LogPtr QATERIAL;

    // ─────── LIST OF ALL LOGGERS ─────────
public:
    // Loggers
    static const LogList LOGGERS;

    // ─────── API ─────────
public:
    static void registerSink(const SinkPtr& sink);
    static void unRegisterSink(const SinkPtr& sink);

public Q_SLOTS:
    void debug(QString s);
    void info(QString s);
    void warn(QString s);
    void error(QString s);
};

}

#endif
