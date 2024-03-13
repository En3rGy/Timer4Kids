#ifndef CTIMER4KIDSAPP_H
#define CTIMER4KIDSAPP_H

#include "qguiapplication.h"
#include <QTimer>

class CTimer4KidsApp : public QGuiApplication
{
    Q_OBJECT
public:
    CTimer4KidsApp(int &argc, char **argv);

protected slots:
    void timeout();

protected:
    QTimer * m_pTimer;
};

#endif // CTIMER4KIDSAPP_H
