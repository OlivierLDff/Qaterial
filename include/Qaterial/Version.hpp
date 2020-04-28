#ifndef __QATERIAL_VERSION_HPP__
#define __QATERIAL_VERSION_HPP__

// ─────────────────────────────────────────────────────────────
//                  INCLUDE
// ─────────────────────────────────────────────────────────────

// Application Header
#include <Qaterial/Export.hpp>

// Qt Header
#include <QObject>
#include <QQmlEngine>

// ─────────────────────────────────────────────────────────────
//                  DECLARATION
// ─────────────────────────────────────────────────────────────

#define QATERIAL_SINGLETON_IMPL(Class, name, Name)                                                 \
public:                                                                                            \
    static Class& name()                                                                           \
    {                                                                                              \
        static Class ret;                                                                          \
        return ret;                                                                                \
    }                                                                                              \
    static QObject* set##Name(QQmlEngine* qmlEngine, QJSEngine* jsEngine)                          \
    {                                                                                              \
        Q_UNUSED(jsEngine)                                                                         \
        Q_UNUSED(qmlEngine)                                                                        \
        QObject* ret = &name();                                                                    \
        QQmlEngine::setObjectOwnership(ret, QQmlEngine::CppOwnership);                             \
        return ret;                                                                                \
    }                                                                                              \
    static void registerSingleton(                                                                 \
        const char* uri, const int majorVersion, const int minorVersion, const char* n = #Class)   \
    {                                                                                              \
        qmlRegisterSingletonType<Class>(uri, majorVersion, minorVersion, n, &Class::set##Name);    \
    }                                                                                              \
                                                                                                   \
private:

namespace qaterial {

class QATERIAL_API_ Version : public QObject
{
    Q_OBJECT
    QATERIAL_SINGLETON_IMPL(Version, version, Version);

    // ──────── CONSTRUCTOR ────────────────
public:
    Version(QObject* parent = nullptr);

    // ──────── ATTRIBUTES ────────────────
private:
    Q_PROPERTY(quint32 major READ major CONSTANT);
    Q_PROPERTY(quint32 minor READ minor CONSTANT);
    Q_PROPERTY(quint32 patch READ patch CONSTANT);
    Q_PROPERTY(quint32 tag READ tag CONSTANT);
    Q_PROPERTY(QString readable READ readable CONSTANT);

private:
    quint32 _major = 0;
    quint32 _minor = 0;
    quint32 _patch = 0;
    quint32 _tag = 0;
    QString _readable;

public:
    quint32 major() const { return _major; }
    quint32 minor() const { return _minor; }
    quint32 patch() const { return _patch; }
    quint32 tag() const { return _tag; }
    QString readable() const { return _readable; }
};

}

#endif
