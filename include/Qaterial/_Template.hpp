#ifndef __QATERIAL_TEMPLATE_HPP__
#define __QATERIAL_TEMPLATE_HPP__

// ──── INCLUDE ────

// Library Headers
#include <Qaterial/Export.hpp>
#include <Qaterial/Property.hpp>

// Dependencies Headers

// Standard Header

// ──── DECLARATION ────

namespace qaterial {

// ──── CLASS ────

class QATERIAL_API_ _SingletonClass : public QObject
{
    Q_OBJECT
    QATERIAL_SINGLETON_IMPL(_SingletonClass, _singletonClass, _SingletonClass);

    // ──── CONSTRUCTOR ────
public:
    _SingletonClass(QObject* parent = nullptr) : QObject(parent) {}
};

}

#endif
