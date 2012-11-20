#ifndef PLATFORMDETAILS_H
#define PLATFORMDETAILS_H

#include <QObject>

class PlatformDetails : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString platform READ platform NOTIFY platformChanged)
    QString m_platform;

public:
    explicit PlatformDetails(QObject *parent = 0);

QString platform() const
{
    return m_platform;
}

signals:

void platformChanged(QString arg);

public slots:
    
};

#endif // PLATFORMDETAILS_H
