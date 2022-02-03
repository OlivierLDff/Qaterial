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

// Library Headers
#include <Qaterial/Logger.hpp>

// Qt Headers
#include <QString>

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

using namespace qaterial;

template<typename... Args>
static Logger::LogPtr makeLog(Args&&... args)
{
    return std::make_shared<Logger::Log>(std::forward<Args>(args)...);
}

const char* const Logger::UTILS_NAME = "qaterial.utils";
const char* const Logger::FILE_NAME = "qaterial.file";
const char* const Logger::QATERIAL_NAME = "qaterial";

const Logger::LogPtr Logger::UTILS = makeLog(UTILS_NAME);
const Logger::LogPtr Logger::FILE = makeLog(FILE_NAME);
const Logger::LogPtr Logger::QATERIAL = makeLog(QATERIAL_NAME);

const Logger::LogList Logger::LOGGERS = {UTILS, FILE, QATERIAL};

// ─────────────────────────────────────────────────────────────
//                  FUNCTIONS
// ─────────────────────────────────────────────────────────────

void Logger::registerSink(const SinkPtr& sink)
{
    for(const auto& it: LOGGERS) it->sinks().emplace_back(sink);
}

void Logger::unRegisterSink(const SinkPtr& sink)
{
    for(const auto& it: LOGGERS)
    {
        auto& sinks = it->sinks();

        auto sinkIt = sinks.begin();
        while(sinkIt != sinks.end())
        {
            const auto& s = *sinkIt;
            if(s == sink)
            {
                sinks.erase(sinkIt);
                break;
            }
        }
    }
}

void Logger::debug(QString s) { QATERIAL->debug(s.toStdString()); }

void Logger::info(QString s) { QATERIAL->info(s.toStdString()); }

void Logger::warn(QString s) { QATERIAL->warn(s.toStdString()); }

void Logger::error(QString s) { QATERIAL->error(s.toStdString()); }
