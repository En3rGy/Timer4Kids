#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication::setApplicationDisplayName( "Timer4Kids");
    QGuiApplication::setOrganizationName( "paul-family" );
    QGuiApplication::setOrganizationDomain( "paul-family.de");
    QGuiApplication::setApplicationVersion( "0.7" );

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
