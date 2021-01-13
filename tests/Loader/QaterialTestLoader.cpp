// ──── INCLUDE ────

#include <Qaterial/Qaterial.hpp>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QCommandLineParser>

// ──── FUNCTIONS ────

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // ──── REGISTER APPLICATION ────

    QGuiApplication::setOrganizationName("Qaterial");
    QGuiApplication::setApplicationName("Qaterial Tests Loader");
    QGuiApplication::setOrganizationDomain("https://olivierldff.github.io/Qaterial/");
    QGuiApplication::setApplicationVersion(qaterial::Version::version().readable());

    QCommandLineParser parser;
    parser.addPositionalArgument("source", QCoreApplication::translate("main", "Source file to load."));

    // Process the actual command line arguments given by the user
    parser.process(app);

    const QStringList args = parser.positionalArguments();
    if(args.empty())
    {
        qWarning("source is empty");
        return -1;
    }
    const auto& source = args.at(0);
    const auto sourceUrl = QUrl::fromLocalFile(source);

    // ──── LOAD AND REGISTER QML ────

    // Important to find 'import Qaterial 1.0'
    engine.addImportPath("qrc:///");

    // Load Qaterial
    qaterial::loadQmlResources();
    qaterial::registerQmlTypes();

    // ──── LOAD QML MAIN ────

    engine.load(sourceUrl);
    if(engine.rootObjects().isEmpty())
    {
        const QString error = "Fail to load " + source;
        qWarning(error.toUtf8());
        return -1;
    }

    // Success load
    const QString info = "Success load " + source;
    qDebug(info.toUtf8());
    return 0;
}
