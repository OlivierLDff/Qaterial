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

#ifndef __QATERIAL_UTILS_LOGGER_HPP__
#define __QATERIAL_UTILS_LOGGER_HPP__

// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// Library Headers
#include <Export.hpp>
#include <Property.hpp>

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
