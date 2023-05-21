#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char* argv[])
{
	QGuiApplication::setApplicationName("Forward Desktop");

	QGuiApplication app(argc, argv);
	QQmlApplicationEngine engine;

    engine.load(":/app/pages/App.qml");

	return app.exec();
}
