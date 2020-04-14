// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// Library Headers
#include <Qaterial/Logger.hpp>

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

using namespace Qaterial;

template<typename... Args>
static Logger::LogPtr makeLog(Args&&... args) { return std::make_shared<Logger::Log>(std::forward<Args>(args)...); }

const char* const Logger::UTILS_NAME = "qaterial.utils";

const Logger::LogPtr Logger::UTILS = makeLog(UTILS_NAME);

const Logger::LogList Logger::LOGGERS =
{
    UTILS
};

// ─────────────────────────────────────────────────────────────
//                  FUNCTIONS
// ─────────────────────────────────────────────────────────────

void Logger::registerSink(const SinkPtr& sink)
{
    for(const auto& it : LOGGERS)
        it->sinks().emplace_back(sink);
}

void Logger::unRegisterSink(const SinkPtr& sink)
{
    for (const auto& it : LOGGERS)
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
