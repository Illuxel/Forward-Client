#include <QtWidgets/QApplication>
#include <QtQml/QQmlApplicationEngine>

#include <QtGui/QIcon>

#include <QtCore/QTranslator>
#include <QtCore/QDebug>

int main(int argc, char* argv[])
{
	QApplication app(argc, argv);

	QTranslator translator;
    if (!translator.load(QLocale::system(), "lang", "_", ":/forward/langs"))
		return -1;

    QApplication::installTranslator(&translator);
	QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QApplication::setApplicationVersion("0.0.1");
	QApplication::setApplicationName("Forward Desktop");
	QApplication::setWindowIcon(QIcon(":/forward/logo_64.png"));

	QQmlApplicationEngine engine;

	engine.addImportPath(":/imports");
    engine.load(":/imports/forward/App.qml");
	
	return app.exec();
}
