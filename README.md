# Xojo-BME280-I2C

Xojo driver module for Bosch Sensortec BME280 temperature, barometer and humidity sensor.

It makes use of WiringPi GPIO Interface library for the Raspberry Pi, which details are availble from [here](http://wiringpi.com).

I have been developing with Xojo 2018r2 on Mac and testing on Raspberry Pi 3B+ hardware with latest Raspbian OS.

![Demo screenshot](https://github.com/shigeru-kawaguchi/Xojo-BME280-I2C/blob/master/media/screenshot.png)

## Background
The driver module was developed referencing the [BME280 datasheet PDF](https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS002-13.pdf) and [WiringPi I2C Library documentation](http://wiringpi.com/reference/i2c-library/).

## Features
This driver provides

* Measurement compensation calculation in 32bit integer for Temperature and Humidity.
* Measurement compensation calculation in 64bit integer for Pressure.
* Returns measurements in ºC, hPa and %RH in Double datatype respectively.
* Forced mode measurement.
* API for oversampling and filter coefficient settings.
* Constants in Public scope for configuration parameters.

## ToDo
* Oversample settings to be implemented on demo UI.
* Filter coefficient setting to be implemented on demo UI.
* Normal mode implementation for driver.

## License Information
[https://github.com/shigeru-kawaguchi/Xojo-BME280-I2C/blob/master/LICENSE](https://github.com/shigeru-kawaguchi/Xojo-BME280-I2C/blob/master/LICENSE)

## Author
Shigeru KAWAGUCHI

## Change Log
Initial release: 2018-09-03