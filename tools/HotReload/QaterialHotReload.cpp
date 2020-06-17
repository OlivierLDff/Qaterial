// ──── INCLUDE ────

// Oliv Qt
#include <Qaterial/Qaterial.hpp>

// spdlog
#ifdef WIN32
#    include <spdlog/sinks/msvc_sink.h>
#endif
#include <spdlog/sinks/stdout_color_sinks.h>

// Qt
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QFileSystemWatcher>

// ──── DECLARATION ────

void installLoggers()
{
#ifdef WIN32
    const auto msvcSink = std::make_shared<spdlog::sinks::msvc_sink_mt>();
    qaterial::Logger::registerSink(msvcSink);
#endif
    const auto stdoutSink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
    qaterial::Logger::registerSink(stdoutSink);
}

class QaterialEngine : public QObject
{
    Q_OBJECT
public:
    QaterialEngine(QQmlEngine* engine, QObject* parent = nullptr) : QObject(parent), _engine(engine)
    {
        connect(&_watcher, &QFileSystemWatcher::fileChanged, this, &QaterialEngine::watchedFileChanged);
    }

private:
    QQmlEngine* _engine;
    QFileSystemWatcher _watcher;

public Q_SLOTS:
    void clearCache() const { _engine->clearComponentCache(); }

    void watchFile(const QString& path) { _watcher.addPath(path); }
    void unWatchFile(const QString& path) { _watcher.removePath(path); }
Q_SIGNALS:
    void watchedFileChanged();
};

#include "QaterialHotReload.moc"

// ──── FUNCTIONS ────

int main(int argc, char* argv[])
{
    installLoggers();

    // It's important to set the high dip support before creating the gui app
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // ──── REGISTER APPLICATION ────

    QGuiApplication::setOrganizationName("Oliv");
    QGuiApplication::setApplicationName("Qaterial Hot Reload");
    QGuiApplication::setOrganizationDomain("https://olivierldff.github.io/Qaterial/");
    QGuiApplication::setApplicationVersion(qaterial::Version::version().readable());

    // ──── LOAD AND REGISTER QML ────

    // Important to find 'import Qaterial 1.0'
    engine.addImportPath("qrc:///");

    // Load Qaterial
    qaterial::Utils::loadResources();
    qaterial::Utils::registerTypes();

    // Load QaterialHotReload
    Q_INIT_RESOURCE(QaterialHotReload);

    qmlRegisterSingletonType<QaterialEngine>("QaterialEngine", 1, 0, "QaterialEngine",
        [](QQmlEngine* engine, QJSEngine* scriptEngine) -> QObject*
        {
            Q_UNUSED(scriptEngine);
            return new QaterialEngine(engine, engine);
        });

    // ──── LOAD QML MAIN ────

    engine.load(QUrl("qrc:/QaterialHotReload.qml"));
    if(engine.rootObjects().isEmpty())
        return -1;

    // ──── START EVENT LOOP ────

    return app.exec();
}
