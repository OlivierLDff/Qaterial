#ifndef __QATERIAL_PROPERTY_HPP__
#define __QATERIAL_PROPERTY_HPP__

// ───────────────────────────────────────
//                INCLUDE
// ───────────────────────────────────────

#include <QQmlEngine>

// ───────────────────────────────────────
//              DECLARATION
// ───────────────────────────────────────

#define _QATERIAL_Q_PROPERTY(type, attribute, Attribute)                                                                                   \
protected:                                                                                                                                 \
    Q_PROPERTY(type attribute READ attribute WRITE set##Attribute RESET reset##Attribute NOTIFY attribute##Changed)                        \
private:

#define _QATERIAL_Q_PROPERTY_RO(type, attribute, Attribute)                                                                                \
protected:                                                                                                                                 \
    Q_PROPERTY(type attribute READ attribute NOTIFY attribute##Changed)                                                                    \
private:

#define _QATERIAL_Q_PROPERTY_CONST(type, attribute)                                                                                        \
protected:                                                                                                                                 \
    Q_PROPERTY(type attribute READ attribute CONSTANT)                                                                                     \
private:

#define _QATERIAL_PROPERTY_MEMBER(type, attribute, def)                                                                                    \
private:                                                                                                                                   \
    type _##attribute = def;                                                                                                               \
                                                                                                                                           \
private:

#define _QATERIAL_PROPERTY_MEMBER_NOD(type, attribute)                                                                                     \
private:                                                                                                                                   \
    type _##attribute;                                                                                                                     \
                                                                                                                                           \
private:

#define _QATERIAL_PROPERTY_GETTER(type, attribute, override)                                                                               \
public:                                                                                                                                    \
    type attribute() const override { return _##attribute; }                                                                               \
                                                                                                                                           \
private:

#define _QATERIAL_PROPERTY_GETTER_ABSTRACT(type, attribute)                                                                                \
public:                                                                                                                                    \
    virtual type attribute() const = 0;                                                                                                    \
                                                                                                                                           \
private:

#define _QATERIAL_PROPERTY_SETTER(type, attribute, Attribute, override)                                                                    \
public:                                                                                                                                    \
    virtual bool set##Attribute(const type& value) override                                                                                \
    {                                                                                                                                      \
        if(value != _##attribute)                                                                                                          \
        {                                                                                                                                  \
            _##attribute = value;                                                                                                          \
            Q_EMIT attribute##Changed(value);                                                                                              \
            return true;                                                                                                                   \
        }                                                                                                                                  \
        return false;                                                                                                                      \
    }                                                                                                                                      \
                                                                                                                                           \
private:

#define _QATERIAL_ATTRIBUTE_SETTER(type, attribute, Attribute, override)                                                                   \
public:                                                                                                                                    \
    virtual bool set##Attribute(const type& value) override                                                                                \
    {                                                                                                                                      \
        if(value != _##attribute)                                                                                                          \
        {                                                                                                                                  \
            _##attribute = value;                                                                                                          \
            return true;                                                                                                                   \
        }                                                                                                                                  \
        return false;                                                                                                                      \
    }                                                                                                                                      \
                                                                                                                                           \
private:

#define _QATERIAL_PROPERTY_SETTER_ABSTRACT(type, Attribute)                                                                                \
public:                                                                                                                                    \
    virtual bool set##Attribute(const type& value) = 0;                                                                                    \
                                                                                                                                           \
private:

#define _QATERIAL_PROPERTY_RESET(type, Attribute, def)                                                                                     \
public:                                                                                                                                    \
    void reset##Attribute() { set##Attribute(def); }                                                                                       \
                                                                                                                                           \
private:

#define _QATERIAL_PROPERTY_SIGNAL(type, attribute)                                                                                         \
Q_SIGNALS:                                                                                                                                 \
    void attribute##Changed(type attribute);                                                                                               \
                                                                                                                                           \
private:

#define _QATERIAL_ABSTRACT_PROPERTY_SHARED(type, attribute, Attribute, def)                                                                \
    _QATERIAL_PROPERTY_GETTER_ABSTRACT(type, attribute)                                                                                    \
    _QATERIAL_PROPERTY_SETTER_ABSTRACT(type, Attribute)                                                                                    \
    _QATERIAL_PROPERTY_RESET(type, Attribute, def)                                                                                         \
    _QATERIAL_PROPERTY_SIGNAL(type, attribute)

#define QATERIAL_ABSTRACT_PROPERTY_D(type, attribute, Attribute, def)                                                                      \
    _QATERIAL_Q_PROPERTY(type, attribute, Attribute)                                                                                       \
    _QATERIAL_ABSTRACT_PROPERTY_SHARED(type, attribute, Attribute, def)                                                                    \
private:

#define QATERIAL_ABSTRACT_PROPERTY(type, attribute, Attribute) QATERIAL_ABSTRACT_PROPERTY_D(type, attribute, Attribute, {})

#define QATERIAL_ABSTRACT_PROPERTY_RO_D(type, attribute, Attribute, def)                                                                   \
    _QATERIAL_Q_PROPERTY_RO(type, attribute, Attribute)                                                                                    \
    _QATERIAL_ABSTRACT_PROPERTY_SHARED(type, attribute, Attribute, def)                                                                    \
private:

#define QATERIAL_ABSTRACT_PROPERTY_RO(type, attribute, Attribute) QATERIAL_ABSTRACT_PROPERTY_RO_D(type, attribute, Attribute, {})

#define QATERIAL_IMPL_PROPERTY_D(type, attribute, Attribute, def)                                                                          \
    _QATERIAL_PROPERTY_MEMBER(type, attribute, def)                                                                                        \
    _QATERIAL_PROPERTY_GETTER(type, attribute, override)                                                                                   \
    _QATERIAL_PROPERTY_SETTER(type, attribute, Attribute, override)                                                                        \
private:

#define QATERIAL_IMPL_PROPERTY(type, attribute, Attribute) QATERIAL_IMPL_PROPERTY_D(type, attribute, Attribute, {})

#define _QATERIAL_PROPERTY_SHARED(type, attribute, Attribute, def)                                                                         \
    _QATERIAL_PROPERTY_MEMBER(type, attribute, def)                                                                                        \
    _QATERIAL_PROPERTY_GETTER(type, attribute, )                                                                                           \
    _QATERIAL_PROPERTY_SETTER(type, attribute, Attribute, )                                                                                \
    _QATERIAL_PROPERTY_RESET(type, Attribute, def)                                                                                         \
    _QATERIAL_PROPERTY_SIGNAL(type, attribute)

#define QATERIAL_PROPERTY_D(type, attribute, Attribute, def)                                                                               \
    _QATERIAL_Q_PROPERTY(type, attribute, Attribute)                                                                                       \
    _QATERIAL_PROPERTY_SHARED(type, attribute, Attribute, def)                                                                             \
private:

#define QATERIAL_PROPERTY(type, attribute, Attribute) QATERIAL_PROPERTY_D(type, attribute, Attribute, {})

#define QATERIAL_PROPERTY_RO_D(type, attribute, Attribute, def)                                                                            \
    _QATERIAL_Q_PROPERTY_RO(type, attribute, Attribute)                                                                                    \
    _QATERIAL_PROPERTY_SHARED(type, attribute, Attribute, def)                                                                             \
private:

#define QATERIAL_PROPERTY_RO(type, attribute, Attribute) QATERIAL_PROPERTY_RO_D(type, attribute, Attribute, {})

#define _QATERIAL_ATTRIBUTE_SHARED(type, attribute, Attribute, def)                                                                        \
    _QATERIAL_PROPERTY_MEMBER(type, attribute, def)                                                                                        \
    _QATERIAL_PROPERTY_GETTER(type, attribute, )                                                                                           \
    _QATERIAL_ATTRIBUTE_SETTER(type, attribute, Attribute, )

#define QATERIAL_PROPERTY_CONST_D(type, attribute, Attribute, def)                                                                         \
    _QATERIAL_Q_PROPERTY_CONST(type, attribute)                                                                                            \
    _QATERIAL_ATTRIBUTE_SHARED(type, attribute, Attribute, def)                                                                            \
private:

#define QATERIAL_PROPERTY_CONST(type, attribute, Attribute) QATERIAL_PROPERTY_CONST_D(type, attribute, Attribute, {})

#define QATERIAL_ATTRIBUTE_D(type, attribute, Attribute, def)                                                                              \
    _QATERIAL_ATTRIBUTE_SHARED(type, attribute, Attribute, def)                                                                            \
private:

#define QATERIAL_ATTRIBUTE(type, attribute, Attribute) QATERIAL_ATTRIBUTE_D(type, attribute, Attribute, {})

#define QATERIAL_ABSTRACT_ATTRIBUTE(type, attribute, Attribute)                                                                            \
    _QATERIAL_PROPERTY_GETTER_ABSTRACT(type, attribute)                                                                                    \
    _QATERIAL_PROPERTY_SETTER_ABSTRACT(type, Attribute)

#define QATERIAL_PROXY_IMPL(proxiedType, proxied, proxiedAttribute, ProxiedAttribute, type, attribute, Attribute, def)                     \
public:                                                                                                                                    \
    type attribute() const override final { return type(proxied ? type(proxied->proxiedAttribute()) : type(def)); }                        \
    bool set##Attribute(const type& value) override                                                                                        \
    {                                                                                                                                      \
        if(proxied)                                                                                                                        \
        {                                                                                                                                  \
            if(attribute() != value)                                                                                                       \
            {                                                                                                                              \
                proxied->set##ProxiedAttribute(proxiedType(value));                                                                        \
                Q_EMIT attribute##Changed(value);                                                                                          \
                return true;                                                                                                               \
            }                                                                                                                              \
            return false;                                                                                                                  \
        }                                                                                                                                  \
        return proxied;                                                                                                                    \
    }                                                                                                                                      \
                                                                                                                                           \
private:

#define _QATERIAL_PTR_GETTER(type, attribute, override)                                                                                    \
public:                                                                                                                                    \
    type* attribute() const override { return _##attribute; }

#define _QATERIAL_PTR_CONST_ONLY_GETTER(type, attribute, override)                                                                         \
public:                                                                                                                                    \
    const type* attribute() const override { return &_##attribute; }

#define _QATERIAL_PTR_CONST_GETTER(type, attribute, override)                                                                              \
public:                                                                                                                                    \
    _QATERIAL_PTR_CONST_ONLY_GETTER(type, attribute, override)                                                                             \
    type* attribute() override { return &_##attribute; }

#define _QATERIAL_PTR_SETTER(type, attribute, Attribute, override)                                                                         \
public:                                                                                                                                    \
    virtual bool set##Attribute(type* value) override                                                                                      \
    {                                                                                                                                      \
        if(value != _##attribute)                                                                                                          \
        {                                                                                                                                  \
            _##attribute = value;                                                                                                          \
            Q_EMIT attribute##Changed(value);                                                                                              \
            return true;                                                                                                                   \
        }                                                                                                                                  \
        return false;                                                                                                                      \
    }

#define _QATERIAL_ABSTRACT_PTR_GETTER(type, attribute)                                                                                     \
public:                                                                                                                                    \
    virtual type* attribute() const = 0;

#define _QATERIAL_ABSTRACT_PTR_SETTER(type, Attribute)                                                                                     \
public:                                                                                                                                    \
    virtual bool set##Attribute(type* value) = 0;

#define _QATERIAL_PTR_SIGNAL(type, attribute)                                                                                              \
Q_SIGNALS:                                                                                                                                 \
    void attribute##Changed(type* value);

#define QATERIAL_PTR(type, attribute, Attribute)                                                                                           \
    _QATERIAL_Q_PROPERTY(type*, attribute, Attribute)                                                                                      \
    _QATERIAL_PROPERTY_MEMBER(type*, attribute, nullptr)                                                                                   \
    _QATERIAL_PTR_GETTER(type, attribute, )                                                                                                \
    _QATERIAL_PTR_SETTER(type, attribute, Attribute, )                                                                                     \
    _QATERIAL_PROPERTY_RESET(type, Attribute, nullptr)                                                                                     \
    _QATERIAL_PTR_SIGNAL(type, attribute)                                                                                                  \
private:

#define QATERIAL_PTR_RO(type, attribute, Attribute)                                                                                        \
    _QATERIAL_Q_PROPERTY_RO(type*, attribute, Attribute)                                                                                   \
    _QATERIAL_PROPERTY_MEMBER(type*, attribute, nullptr)                                                                                   \
    _QATERIAL_PTR_GETTER(type, attribute, )                                                                                                \
    _QATERIAL_PTR_SETTER(type, attribute, Attribute, )                                                                                     \
    _QATERIAL_PROPERTY_RESET(type, Attribute, nullptr)                                                                                     \
    _QATERIAL_PTR_SIGNAL(type, attribute)                                                                                                  \
private:

#define QATERIAL_ABSTRACT_PTR(type, attribute, Attribute)                                                                                  \
    _QATERIAL_Q_PROPERTY(type*, attribute, Attribute)                                                                                      \
    _QATERIAL_ABSTRACT_PTR_GETTER(type, attribute)                                                                                         \
    _QATERIAL_ABSTRACT_PTR_SETTER(type, Attribute)                                                                                         \
    _QATERIAL_PROPERTY_RESET(type, Attribute, nullptr)                                                                                     \
    _QATERIAL_PTR_SIGNAL(type, attribute)                                                                                                  \
private:

#define QATERIAL_ABSTRACT_PTR_RO(type, attribute, Attribute)                                                                               \
    _QATERIAL_Q_PROPERTY_RO(type*, attribute, Attribute)                                                                                   \
    _QATERIAL_ABSTRACT_PTR_GETTER(type, attribute)                                                                                         \
    _QATERIAL_ABSTRACT_PTR_SETTER(type, Attribute)                                                                                         \
    _QATERIAL_PROPERTY_RESET(type, Attribute, nullptr)                                                                                     \
    _QATERIAL_PTR_SIGNAL(type, attribute)                                                                                                  \
private:

#define QATERIAL_IMPL_PTR(type, attribute, Attribute)                                                                                      \
    _QATERIAL_PROPERTY_MEMBER(type*, attribute, nullptr)                                                                                   \
    _QATERIAL_PTR_GETTER(type, attribute, override)                                                                                        \
    _QATERIAL_PTR_SETTER(type, attribute, Attribute, override)                                                                             \
    _QATERIAL_PROPERTY_RESET(type, Attribute, nullptr)                                                                                     \
    _QATERIAL_PTR_SIGNAL(type, attribute)                                                                                                  \
private:

#define QATERIAL_CONST_PTR(type, attribute, Attribute)                                                                                     \
    _QATERIAL_Q_PROPERTY_CONST(type*, attribute)                                                                                           \
    _QATERIAL_PROPERTY_MEMBER_NOD(type, attribute)                                                                                         \
    _QATERIAL_PTR_CONST_GETTER(type, attribute, )                                                                                          \
private:

#define QATERIAL_REGISTER_TO_QML(Type)                                                                                                     \
public:                                                                                                                                    \
    static void registerToQml(const char* uri = "Qaterial",                                                                                \
        const int majorVersion = 1,                                                                                                        \
        const int minorVersion = 0,                                                                                                        \
        const char* name = #Type)                                                                                                          \
    {                                                                                                                                      \
        qmlRegisterType<Type>(uri, majorVersion, minorVersion, name);                                                                      \
    }                                                                                                                                      \
                                                                                                                                           \
private:

#define QATERIAL_SINGLETON_IMPL(Class, name, Name)                                                                                         \
public:                                                                                                                                    \
    static Class& name()                                                                                                                   \
    {                                                                                                                                      \
        static Class ret;                                                                                                                  \
        return ret;                                                                                                                        \
    }                                                                                                                                      \
    static QObject* set##Name(QQmlEngine* qmlEngine, QJSEngine* jsEngine)                                                                  \
    {                                                                                                                                      \
        Q_UNUSED(jsEngine)                                                                                                                 \
        Q_UNUSED(qmlEngine)                                                                                                                \
        QObject* ret = &name();                                                                                                            \
        QQmlEngine::setObjectOwnership(ret, QQmlEngine::CppOwnership);                                                                     \
        return ret;                                                                                                                        \
    }                                                                                                                                      \
    static void registerSingleton(const char* uri = "Qaterial",                                                                            \
        const int majorVersion = 1,                                                                                                        \
        const int minorVersion = 0,                                                                                                        \
        const char* n = #Class)                                                                                                            \
    {                                                                                                                                      \
        qmlRegisterSingletonType<Class>(uri, majorVersion, minorVersion, n, &Class::set##Name);                                            \
    }                                                                                                                                      \
                                                                                                                                           \
private:

#endif
