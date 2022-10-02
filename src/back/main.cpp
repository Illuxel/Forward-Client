#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char* argv[])
{
	QApplication::setApplicationName("Messenger Desktop");
	QApplication::setOrganizationName("SIV");

	QApplication app(argc, argv);

	QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/main/pages/qml/main.qml"));
	if (engine.rootObjects().isEmpty())
		return -1;

	return app.exec();
}
