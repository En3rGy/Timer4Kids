QT += qml quick

CONFIG += c++17

CONFIG(debug, debug|release) {
  CONFIG  -= debug release
  CONFIG  += debug
  DEFINES += _DEBUG

  TARGET  = Timer4KidsD
}

CONFIG(release) {
  CONFIG -= debug release
  CONFIG += release

  TARGET  = Timer4Kids
}

win32:DEFINES += win32

DESTDIR  = ../bin

unix:target.path = /usr/local/$$TARGET
win32:target.path = ../bin
INSTALLS += target

# Icons
#unix:icon.path = /usr/share/icons/hicolor/
#unix:icon.files = ressources/fleeting-star.xbm
#unix:INSTALLS += icon

#win32:RC_ICONS = ressources/fleeting-star.ico

SOURCES += main.cpp \
    ctimer4kidsapp.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

HEADERS += \
    ctimer4kidsapp.h
