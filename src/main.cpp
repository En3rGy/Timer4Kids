#include <ctimer4kidsapp.h>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationDisplayName( "Timer4Kids");
    QGuiApplication::setOrganizationName( "paul-family" );
    QGuiApplication::setOrganizationDomain( "paul-family.de");
    QGuiApplication::setApplicationVersion( "0.9" );

    CTimer4KidsApp app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    auto rootObjList = engine.rootObjects();
    if (rootObjList.isEmpty()) {
        // something went wrong
        app.quit();
    }

    auto rootObj = rootObjList.first();

    return app.exec();
}
