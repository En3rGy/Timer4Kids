#include "ctimer4kidsapp.h"
#include <iostream>

CTimer4KidsApp::CTimer4KidsApp(int &argc, char **argv)
    : QGuiApplication(argc, argv)
{
    m_pTimer = new QTimer();

    connect(m_pTimer, SIGNAL(timeout()), this, SLOT(timeout()));
    m_pTimer->start(1000);
}

void CTimer4KidsApp::timeout()
{
    //std::cout << "Ping" << std::endl;
}
