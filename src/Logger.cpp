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
