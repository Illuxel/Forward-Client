#include "Localisation.hpp"

#include <QGuiApplication>
#include <QLibraryInfo>
#include <QLocale>

QStringList Localisation::locales()
{
    return QStringList();
}
QStringList Localisation::countries()
{
    QStringList temp;
    QList<QLocale> locales = QLocale::matchingLocales(QLocale::AnyLanguage, QLocale::AnyScript, QLocale::AnyCountry);

    for (const auto& locale : locales)
    {
        temp.append(locale.countryToString(locale.country()));
    }

    return temp;
}

void Localisation::changeLocale(const QString& locale)
{
    auto app = QGuiApplication::instance();


}