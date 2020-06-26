#ifndef __QATERIAL_STEPPER_ELEMENT_HPP__
#define __QATERIAL_STEPPER_ELEMENT_HPP__

// ──── INCLUDE ────

// Library Headers
#include <Qaterial/Export.hpp>
#include <Qaterial/Property.hpp>

// Dependencies Headers
#include <QObject>
#include <QString>

// Standard Header

// ──── DECLARATION ────

namespace qaterial {

// ──── CLASS ────

class StepperElement : public QObject
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(StepperElement)

public:
    StepperElement(QObject* parent = nullptr) : QObject(parent) {}

    QATERIAL_PROPERTY(QString, text, Text);
    QATERIAL_PROPERTY(bool, done, Done);
    QATERIAL_PROPERTY(bool, optional, Optional);
    QATERIAL_PROPERTY(QString, alertMessage, AlertMessage);
    QATERIAL_PROPERTY(QString, supportingText, SupportingText);
};

}

#endif
