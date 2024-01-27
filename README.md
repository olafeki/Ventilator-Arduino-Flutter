# Arduino-Ventilator
# Final Project - Arduino-Based Mechanical Ventilator

<img align="right" width="450px" src="media/vent1.jpg" alt="ventilator project">

In this project, we decided to build an Arduino-based mechanical ventilator. We used the ESP32 microcontroller alongside other sensors, actuators, and other components listed below to simulate Volume-Control Ventilation. We built a Flutter application to get patient data, and required Breaths Per Minute, and display sensor readings for monitoring purposes. We connected the microcontroller with the Flutter app through Firebase, and used Firebase Real-time Database to store the project's data.


## Used Components
- ESP32 DevKit V1
- Arduino Uno (Optional)
- Ambu Bag
- BMP280 Pressure Sensor
- AHT21B Temperature and Humidity Sensor
- KY039 Heartrate Sensor
- DC Motor 12V/300RPM
- L298N Motor Driver
- 4 x 3.7V Li-ion Battery
- 4-Cell Battery Holder
- LCD 16x2 Display
- 10k Potentiometer

<br clear="right"/>

## Project Details
Our project is divided into two main parts, the hardware components and the flutter app. <br/>
For the hardware, we have three sensors for monitoring purposes. The heartrate and temperature sensors could be placed anywhere. The pressure sensor is placed at the end of the ambu bag to monitor air pressure. The sensors' readings are sent to the Firebase RTDB, and displayed on the LCD at the side of the wooden ventilator frame. The DC motor has a metal rod with a wooden handle attached to it. When the DC motor moves forward, it spins the metal rod, moving the handle forward to squeeze the ambu bag, and the opposite happens with the DC motor moving backwards. When the RTDB receives a new Breath Rate (breath per minute) value, the DC motor starts moving.<br/>
For the flutter app, first, the user has to log in or sign up. Next, they enter their information such as age, weight, etc.. and specify the breath rate used to operate the ventilator. These values are all saved in the RTDB. Then, there's a screen that displays all sensor readings. The user can also see their previeously entered information. The app also has two more features: First, it can measure heart rate using phone camera. Second, it can calculate BMI and display results in a separate screen.

### Flutter App

<div align="center">
    <img src="media/1.png" alt="screen 1" width="230px"/>
    <img src="media/2.png" alt="screen 2" width="230px"/>
    <img src="media/3.png" alt="screen 3" width="230px"/>
    <img src="media/4.png" alt="screen 4" width="230px"/>
    <img src="media/5.png" alt="screen 5" width="230px"/>
    <img src="media/6.png" alt="screen 6" width="230px"/>
    <img src="media/7.png" alt="screen 7" width="230px"/>
    <img src="media/8.png" alt="screen 8" width="230px"/>
    <img src="media/9.png" alt="screen 9" width="230px"/>
    <img src="media/10.png" alt="screen 10" width="230px"/>
    <img src="media/11.png" alt="screen 11" width="230px"/>
</div>


### Hardware Connections

<div align="center">
    <img src="media/vent2.png" width ="90%" alt="ventilator top view">
</div>

<br/>
<img src="media/i2c.png" width="50%" align="right" alt="pressure and tempertature sensors connection">
<br/><br/>
Pressure and Temperature sensors are both I2C sensors, so they are connected to 3.3V, GND, SDA, and SCL pins. The ESP32 has only one SDA and one SCL pin, so we connected each to a node/row, and connected the sensors' SDA and SCL pins to the same node, like this (green is SCL, yellow is SDA):
<br clear="right"/>

<img src="media/ky-039.jpg" width="30%" align="left" alt="heartrate sensor connection">
<br/><br/>
&nbsp;&nbsp;&nbsp;The heartrate sensor is connected as follows, with the signal connected to pin 34:<br/>
&nbsp;&nbsp;&nbsp;[Image by <a href="https://www.thegeekpub.com/wiki/sensor-wiki-ky-039-heartbeat-sensor/">thegeekpub</a>]
<br clear="left"/>

<br/><br/>
<img src="media/motor.png" width="40%" align="right" alt="dc motor and motor driver">
The L298N motor driver is used to control the DC motor. As the DC motor needs a 12V power source, we used 4 3.7V batteries to give a 14.8V output. The motor driver is connected similarly to the image below. We used pins 14, 27, and 26 for the driver's EN1, IN1, and IN2 respectively. <br/>
[Image by <a href="https://www.instructables.com/How-to-Use-L298n-to-Control-Dc-Motor-With-Arduino/">instructables</a>]<br/><br/>
<img src="media/motor_schematic.png" width="55%" alt="motor driver schematic">
<br clear="right"/>

<br/><br/>
To avoid electrical interference, we connected the LCD to the Arduino Uno, and established serial communication between the ESP32 and the Arduino Uno to send data to be displayed on the LCD. The LCD used digital pins 12, 11, 5, 4, 3, 2 in order. To establish serial communication, we must connect each device's TX pin to the other's RX pin, and must have a common ground connection.
<div align="center">
    <img src="media/arduino.png" width="80%" alt="ardiuno uno lcd and serial communication">
</div>
<br/>

## Contributers - Team 10
[Verina Michel](https://github.com/verinak)<br>
[Ola Mamdouh](https://github.com/olamahdi)<br>
[Marly Magdy](https://github.com/marlymagdy)<br>
[Maria Anwar](https://github.com/Maria1516)<br>
[Mariem Nasr](https://github.com/MariemNasr)<br>
[Mirna Tarek](https://github.com/Mirna-tarek)<br>
