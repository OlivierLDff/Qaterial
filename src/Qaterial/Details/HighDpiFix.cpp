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

#include <QtGui/QGuiApplication>
#ifdef Q_OS_WIN
#    include <Windows.h>
#endif

namespace qaterial {

// Fix dpi at application startup
class HighDpiFix
{
    HighDpiFix()
    {
#ifdef Q_OS_WIN
#    if _WIN32_WINNT >= 0x0600
        ::SetProcessDPIAware();
#    endif
#endif // Q_OS_WIN

#if QT_VERSION_MAJOR < 6 // AA_EnableHighDpiScaling is enabled by default on qt6
        QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    }
    static HighDpiFix singleton;
};

HighDpiFix HighDpiFix::singleton;

}
