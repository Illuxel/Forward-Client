#pragma once

#include <QtCore/QObject>
#include <QtQml/qqmlregistration.h>

class Style : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_ELEMENT

public:
    Q_INVOKABLE void changeStyle(const QString& name);
};