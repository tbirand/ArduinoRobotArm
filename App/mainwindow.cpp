#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QtSerialPort/QSerialPortInfo>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    foreach(const QSerialPortInfo info, QSerialPortInfo::availablePorts()) {
        ui->portSelect->addItem(info.portName());
    }

    lastMove = QDateTime::currentMSecsSinceEpoch();
}

MainWindow::~MainWindow()
{
    delete ui;
    serial.write("d");
    serial.close();
}

void MainWindow::on_pushButton_clicked()
{
    // Activate
    serial.write("a");
    s_log("System Active");
    r_log(QString::fromLocal8Bit(serial.readAll()));
}

void MainWindow::on_pushButton_2_clicked()
{
    // Deactivate
    serial.write("d");
    s_log("System Inactive");
    r_log(QString::fromLocal8Bit(serial.readAll()));
}

void MainWindow::s_log(QString message) {
    ui->Sent->appendPlainText(message);
}

void MainWindow::r_log(QString message) {
    ui->Received->appendPlainText(message);
}

void MainWindow::on_portSelect_currentIndexChanged(const QString &arg1)
{
    if(serial.isOpen())
        serial.close();

    serial.setPortName(arg1);
    if(serial.open(QIODevice::ReadWrite))
    {
        serial.setFlowControl(QSerialPort::NoFlowControl);
        serial.setBaudRate(QSerialPort::Baud115200);
        serial.setDataBits(QSerialPort::Data8);
        serial.setParity(QSerialPort::NoParity);
        serial.setStopBits(QSerialPort::OneStop);
    }
    s_log("Port set to " + arg1);
}

void MainWindow::updateAngles() {
    if(QDateTime::currentMSecsSinceEpoch() - lastMove > 50) {
        QString data = ui->foot->toString() + "," + ui->lift->toString() + "," + ui->larm->toString() + "," + ui->uarm->toString();
        serial.write(data.toLocal8Bit());
        s_log(data);
        lastMove = QDateTime::currentMSecsSinceEpoch();
    }
}

void MainWindow::on_checkBox_toggled(bool checked)
{
    serial.write("g");
    QString status = checked == false ? "open" : "closed";
    s_log("Gripper " + status);
}
