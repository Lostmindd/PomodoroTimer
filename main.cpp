#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setOrganizationName("LostMindd");
    app.setOrganizationDomain("github.com/Lostmindd");
    app.setApplicationName("PomodoroTimer");

    QGuiApplication::setWindowIcon(QIcon(":/icons/resources/icon.svg"));

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("PomodoroTimer", "Main");    

    return app.exec();
}
