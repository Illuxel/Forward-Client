#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QIcon>
#include <QQuickStyle>

int main(int argc, char* argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QGuiApplication app(argc, argv);

	app.setApplicationName("Forward Desktop");
	
	// QQuickStyle::setFallbackStyle("Material");
	// QQuickStyle::setStyle("Material");

	QQmlApplicationEngine engine;

    engine.load(":/forward/pages/App.qml");

	return app.exec();
}
