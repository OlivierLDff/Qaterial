#ifndef __QATERIAL_TREE_ELEMENT_HPP__
#define __QATERIAL_TREE_ELEMENT_HPP__

// ──── INCLUDE ────

// Library Headers
#include <Qaterial/Export.hpp>
#include <Qaterial/Property.hpp>

// Dependencies Headers
#include <QOlm/QOlm.hpp>
#include <QObject>
#include <QString>

// Standard Header

// ──── DECLARATION ────

namespace qaterial {

// ──── CLASS ────

using TreeModel = qolm::QOlm<class TreeElement>;

class QATERIAL_API_ TreeElement : public TreeModel
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(TreeElement)

public:
    TreeElement(QObject* parent = nullptr) : TreeModel(parent) {}

protected:
    Q_PROPERTY(TreeElement* children READ children CONSTANT);
    QATERIAL_PROPERTY(bool, expanded, Expanded);
    QATERIAL_PROPERTY(QString, text, Text);

public:
    TreeElement* children() { return this; }
};

}

#endif
