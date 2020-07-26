---
layout: default
title: 💬 Logger
---

# 💬 Logger

![Logger](https://user-images.githubusercontent.com/17255804/85429934-bc216280-b57f-11ea-9e1c-6ef8ad257722.gif)

Qaterial use [spdlog](https://github.com/gabime/spdlog) as a logging backend. The singleton `Logger` provide an easy api to user spdlog. The logging category will be `qaterial`.

## Qml Usage

* `Logger.debug(string)` : print a string with `debug` level
* `Logger.info(string)` : print a string with `info` level
* `Logger.warn(string)` : print a string with `warning` level
* `Logger.error(string)` : print a string with `error` level

```js
import QtQml 2.0
import Qaterial 1.0 as Qaterial

QtObject
{
    function logExample()
    {
        Qaterial.Logger.debug(`This is a debug message`)
        Qaterial.Logger.info(`This is a info message`)
        Qaterial.Logger.warn(`This is a warning message`)
        Qaterial.Logger.error(`This is a error message`)
    }
}
```

## C++ Setup

* Create one or more sinks, how to in [sinks](https://github.com/gabime/spdlog/wiki/4.-Sinks) documentation.
* Register sinks with `qaterial::Logger::registerSink(sink)`

The following example demonstrate how to register stdout as sink.

```cpp
#include <Qaterial/Qaterial.hpp>
#include <spdlog/sinks/stdout_color_sinks.h>

int main(int argc, char* argv[])
{
    // Create a stdout sink
    const auto stdoutSink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
    // Redirect qaterial to stdout
    qaterial::Logger::registerSink(stdoutSink);

    // optionnal: Enable debug level
    stdoutSink->set_level(spdlog::level::debug);
    qaterial::Logger::QATERIAL->set_level(spdlog::level::debug);

    // ...
}
```

> Note: It's important to register sink at program startup, to avoid multithreading issues.