// ──── INCLUDE ────

#include <Qaterial/Qaterial.hpp>

#include <QGuiApplication>
#include <QQmlApplicationEngine>

// ──── FUNCTIONS ────

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // ──── REGISTER APPLICATION ────

    QGuiApplication::setOrganizationName("Qaterial");
    QGuiApplication::setApplicationName("Qaterial Hello World");
    QGuiApplication::setOrganizationDomain("https://olivierldff.github.io/Qaterial/");
    QGuiApplication::setApplicationVersion(qaterial::Version::version().readable());

    // ──── LOAD AND REGISTER QML ────

    // Important to find 'import Qaterial 1.0'
    engine.addImportPath("qrc:///");

    // Load Qaterial
    qaterial::Utils::loadResources();
    qaterial::Utils::registerTypes();

    // Load QaterialHelloWorld
    Q_INIT_RESOURCE(HelloWorld);

    // ──── LOAD QML MAIN ────

    engine.load(QUrl("qrc:/Qaterial/HelloWorld/HelloWorld.qml"));
    if(engine.rootObjects().isEmpty())
        return -1;

    // ──── START EVENT LOOP ────

    return QGuiApplication::exec();
}
