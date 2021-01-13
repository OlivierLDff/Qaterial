#include <Qaterial/Qaterial.hpp>

#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Important to find 'import Qaterial 1.0' in qml
    // Qaterial module is located in qrc:Qaterial/
    engine.addImportPath("qrc:///");

    // Load Qaterial.
    qaterial::loadQmlResources();
    qaterial::registerQmlTypes();

    // Load QaterialHelloWorld
    Q_INIT_RESOURCE(HelloWorld);

    // This path is defined by the prefix in HelloWorld.qrc
    engine.load(QUrl("qrc:/HelloWorld.qml"));
    if(engine.rootObjects().isEmpty())
        return -1;

    // Start event loop
    return QGuiApplication::exec();
}
