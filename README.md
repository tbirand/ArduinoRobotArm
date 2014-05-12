3D Printable Arduino Robot Arm
==============================
By Turgay Birand <tbirand@gmail.com>

The project is organized into three folders:

* App - Contains source code for a reference desktop app developed with the Qt framework.
* Arduino - This folder holds the Arduino source code driving the robot arm with vectors received on the serial port.
* Design - This folder has the OpenSCAD design file of the robot arm parts for 3D printing.

You will need five 9g Micro Servos and probably a Servo shield of some sort to hook up all the servos to your Arduino board.

The design for this robot arm is based on the 3D printable parts created by holgero at http://www.thingiverse.com/thing:65081. You can use either version under the Design folder, the code will work the same for both. The one tagged original is from thingiverse, the other is the same with a few tweaks made for more robust production on some 3D printers.
