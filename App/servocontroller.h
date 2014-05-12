#ifndef SERVOCONTROLLER_H
#define SERVOCONTROLLER_H

#include <QWidget>

namespace Ui {
class ServoController;
}

class ServoController : public QWidget
{
    Q_OBJECT
    Q_PROPERTY(QString identifier READ getIdentifier WRITE setIdentifier)
    Q_PROPERTY(int value READ getValue WRITE setValue)

signals:
    void servoValueChanged();

public:
    explicit ServoController(QWidget *parent = 0);
    QString getIdentifier();
    void setIdentifier(QString id);
    int getValue();
    QString toString();
    void setValue(int value);
    ~ServoController();

private slots:
    void on_horizontalSlider_sliderMoved(int position);

private:
    Ui::ServoController *ui;
    QString _identifier;
    int _value;
};

#endif // SERVOCONTROLLER_H
