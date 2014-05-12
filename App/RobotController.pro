#-------------------------------------------------
#
# Project created by QtCreator 2014-03-20T00:29:39
#
#-------------------------------------------------

QT       += core gui serialport

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = RobotController
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    servocontroller.cpp

HEADERS  += mainwindow.h \
    servocontroller.h

FORMS    += mainwindow.ui \
    servocontroller.ui
