#ifndef __QATERIAL_PROPERTY_HPP__
#define __QATERIAL_PROPERTY_HPP__

#include <QQmlEngine>

#define QATERIAL_SINGLETON_IMPL(Class, name, Name)                                                                     \
public:                                                                                                                \
    static Class& name()                                                                                               \
    {                                                                                                                  \
        static Class ret;                                                                                              \
        return ret;                                                                                                    \
    }                                                                                                                  \
    static QObject* set##Name(QQmlEngine* qmlEngine, QJSEngine* jsEngine)                                              \
    {                                                                                                                  \
        Q_UNUSED(jsEngine)                                                                                             \
        Q_UNUSED(qmlEngine)                                                                                            \
        QObject* ret = &name();                                                                                        \
        QQmlEngine::setObjectOwnership(ret, QQmlEngine::CppOwnership);                                                 \
        return ret;                                                                                                    \
    }                                                                                                                  \
    static void registerSingleton(                                                                                     \
        const char* uri = "Qaterial", const int majorVersion = 1, const int minorVersion = 0, const char* n = #Class)  \
    {                                                                                                                  \
        qmlRegisterSingletonType<Class>(uri, majorVersion, minorVersion, n, &Class::set##Name);                        \
    }                                                                                                                  \
                                                                                                                       \
private:

#endif
