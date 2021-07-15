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

#ifndef __QATERIAL_TREE_ELEMENT_HPP__
#define __QATERIAL_TREE_ELEMENT_HPP__

#include <Qaterial/Details/Export.hpp>
#include <Qaterial/Details/Property.hpp>

#include <QOlm/QOlm.hpp>
#include <QtCore/QObject>
#include <QtCore/QString>

namespace qaterial {

using TreeModel = qolm::QOlm<class TreeElement>;

class QATERIAL_API_ TreeElement : public TreeModel
{
    Q_OBJECT
    QATERIAL_REGISTER_TO_QML(TreeElement)

public:
    TreeElement(QObject* parent = nullptr);

protected:
    Q_PROPERTY(TreeElement* children READ children CONSTANT);
    QATERIAL_PROPERTY(bool, expanded, Expanded);
    QATERIAL_PROPERTY(QString, text, Text);

public:
    TreeElement* children();
};

}

#endif
