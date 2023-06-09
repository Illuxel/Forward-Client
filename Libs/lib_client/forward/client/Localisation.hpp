#pragma once

#include <QtCore/QObject>
#include <QtQml/qqmlregistration.h>

class Localisation : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_ELEMENT

public:
    Q_INVOKABLE static QStringList locales();
    Q_INVOKABLE static QStringList countries();

    Q_INVOKABLE static void changeLocale(const QString& locale);
};