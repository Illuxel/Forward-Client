#include <QtWidgets/QApplication>
#include <QtQml/QQmlApplicationEngine>

#include <QtGui/QIcon>
#include <QQuickStyle>
#include <QtCore/QTranslator>
#include <QtCore/QSettings>

#include <QDesktopServices>

#include "myhelphandler.hpp"

int main(int argc, char* argv[])
{
    MyHelpHandler* obj = new MyHelpHandler();

	QApplication::setApplicationVersion("0.0.1");
	QApplication::setApplicationName("Forward Desktop");
	QApplication::setOrganizationDomain("forchat.online");
    QApplication::setOrganizationName("Forward Company Ltd.");

	QApplication app(argc, argv);
	
	QApplication::setWindowIcon(QIcon(":/forward/logo.ico"));

    QDesktopServices::setUrlHandler("forward", obj, "showHelp");

	{
		QSettings settings (
			QApplication::organizationName(),
			QApplication::applicationName()
		);

		if (!settings.contains("style"))
			settings.setValue("style", QQuickStyle::name());

		auto style = settings.value("style").toString();
		QQuickStyle::setStyle(style);
	}

	QQmlApplicationEngine engine;

	engine.addImportPath(":/imports");
    engine.load(":/imports/forward/App.qml");

	if (engine.rootObjects().isEmpty())
        return -1;
	
	return app.exec();
}
