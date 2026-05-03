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

#include <Qaterial/Details/Utils.hpp>

#include <QtCore/QDir>
#include <QtCore/QFile>
#include <QtCore/QTemporaryDir>
#include <QtTest/QtTest>

class CollectFontFilesTest : public QObject
{
    Q_OBJECT

private slots:
    void emptyForMissingDirectory();
    void findsTtfAtTopLevel();
    void recursesIntoSubdirectories();
    void filtersByExtension();
    void isCaseInsensitiveOnExtension();

private:
    static void touch(const QString& path)
    {
        QFile file(path);
        const auto opened = file.open(QIODevice::WriteOnly);
        QVERIFY2(opened, qPrintable(QStringLiteral("failed to create %1").arg(path)));
    }
};

void CollectFontFilesTest::emptyForMissingDirectory()
{
    const auto files = qaterial::detail::collectFontFiles(QStringLiteral("/this/does/not/exist"));
    QVERIFY(files.isEmpty());
}

void CollectFontFilesTest::findsTtfAtTopLevel()
{
    QTemporaryDir dir;
    QVERIFY(dir.isValid());
    touch(dir.filePath(QStringLiteral("Roboto-Regular.ttf")));

    const auto files = qaterial::detail::collectFontFiles(dir.path());

    QCOMPARE(files.size(), 1);
    QVERIFY(files.first().endsWith(QStringLiteral("Roboto-Regular.ttf")));
}

void CollectFontFilesTest::recursesIntoSubdirectories()
{
    // This mirrors the nixpkgs `roboto-mono` layout, which nests font files
    // under a `RobotoMono/` subdirectory of `share/fonts/truetype/` rather than
    // placing them directly at the top level (as `roboto` and `lato` do).
    QTemporaryDir dir;
    QVERIFY(dir.isValid());
    QVERIFY(QDir(dir.path()).mkpath(QStringLiteral("RobotoMono")));
    QVERIFY(QDir(dir.path()).mkpath(QStringLiteral("RobotoMono/Italic")));
    touch(dir.filePath(QStringLiteral("RobotoMono/RobotoMono-Regular.ttf")));
    touch(dir.filePath(QStringLiteral("RobotoMono/RobotoMono-Bold.ttf")));
    touch(dir.filePath(QStringLiteral("RobotoMono/Italic/RobotoMono-Italic.ttf")));

    const auto files = qaterial::detail::collectFontFiles(dir.path());

    QCOMPARE(files.size(), 3);
}

void CollectFontFilesTest::filtersByExtension()
{
    QTemporaryDir dir;
    QVERIFY(dir.isValid());
    touch(dir.filePath(QStringLiteral("Roboto-Regular.ttf")));
    touch(dir.filePath(QStringLiteral("Roboto-Light.otf")));
    touch(dir.filePath(QStringLiteral("README.md")));
    touch(dir.filePath(QStringLiteral("preview.png")));
    touch(dir.filePath(QStringLiteral("LICENSE")));

    const auto files = qaterial::detail::collectFontFiles(dir.path());

    QCOMPARE(files.size(), 2);
    for(const auto& path: files)
    {
        const auto lower = path.toLower();
        QVERIFY2(lower.endsWith(QStringLiteral(".ttf")) || lower.endsWith(QStringLiteral(".otf")),
            qPrintable(path));
    }
}

void CollectFontFilesTest::isCaseInsensitiveOnExtension()
{
    QTemporaryDir dir;
    QVERIFY(dir.isValid());
    touch(dir.filePath(QStringLiteral("Roboto-Regular.TTF")));
    touch(dir.filePath(QStringLiteral("Roboto-Light.Otf")));

    const auto files = qaterial::detail::collectFontFiles(dir.path());

    QCOMPARE(files.size(), 2);
}

QTEST_GUILESS_MAIN(CollectFontFilesTest)
#include "CollectFontFilesTest.moc"
