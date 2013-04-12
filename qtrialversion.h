#ifndef QTRIALVERSION_H
#define QTRIALVERSION_H

#include <QObject>
#include <QSystemInfo>
#include <QSystemDeviceInfo>
#include <QDebug>

class QTrialVersion : public QObject
{
    Q_OBJECT
public:
    explicit QTrialVersion(QObject *parent = 0);
    
signals:
    
public slots:
    
};

#endif // QTRIALVERSION_H
