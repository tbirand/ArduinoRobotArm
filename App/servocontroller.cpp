#include "servocontroller.h"
#include "ui_servocontroller.h"

ServoController::ServoController(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::ServoController)
{
    ui->setupUi(this);

    connect(this, SIGNAL(servoValueChanged()), this->topLevelWidget(), SLOT(updateAngles()));
}

ServoController::~ServoController()
{
    delete ui;
}

QString ServoController::getIdentifier() {
    return this->_identifier;
}

void ServoController::setIdentifier(QString id) {
    this->_identifier = id;
    this->ui->label->setText(id + " " + QString::number(getValue()));
}

void ServoController::setValue(int value) {
    this->_value = value;
    this->ui->label->setText(getIdentifier() + " " + QString::number(value));
    this->ui->horizontalSlider->setValue(value);
}

int ServoController::getValue() {
    return this->_value;
}

QString ServoController::toString() {
    return QString::number(this->_value);
}

void ServoController::on_horizontalSlider_sliderMoved(int position)
{
    setValue(position);
    emit servoValueChanged();
}
