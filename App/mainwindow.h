#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtSerialPort/QtSerialPort>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    void r_log(QString message);
    void s_log(QString message);

private slots:
    void on_pushButton_clicked();
    void on_pushButton_2_clicked();
    void on_portSelect_currentIndexChanged(const QString &arg1);
    void updateAngles();

    void on_checkBox_toggled(bool checked);

private:
    Ui::MainWindow *ui;
    QSerialPort serial;
    QVector<int> angles;
    qint64 lastMove;
};

#endif // MAINWINDOW_H
