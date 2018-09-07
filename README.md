# Xojo-BME280-I2C

Xojo driver module for Bosch Sensortec BME280 temperature, barometer and humidity sensor.

It makes use of WiringPi GPIO Interface library for the Raspberry Pi, which details are availble from [here](http://wiringpi.com).

I have been developing with Xojo 2018r2 on Mac and testing on Raspberry Pi 3B+ hardware with latest Raspbian OS.

![Demo screenshot](https://github.com/shigeru-kawaguchi/Xojo-BME280-I2C/blob/master/media/20180906-ScreenShot.png)

## Background
The driver module was developed referencing the [BME280 datasheet PDF](https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS002-13.pdf) and [WiringPi I2C Library documentation](http://wiringpi.com/reference/i2c-library/).

## Features
This driver provides

* Measurement compensation calculation in 32bit integer for Temperature and Humidity.
* Measurement compensation calculation in 64bit integer for Pressure.
* Returns measurements in ºC, hPa and %RH in Double datatype respectively.
* Forced mode measurement.
* Oversampling and filter coefficient settings.
* Constants in Public scope for configuration parameters.

## ToDo
* Filter coefficient setting to be implemented on demo UI.
* Normal mode implementation.

## Usage
Copy the RasPi\_I2C module into your project and call the RasPi\_I2C.BME280 class in your program. RasPi\_I2C.BME280 is a subclass of RasPi_I2C.I2C.

![RasPi_I2C module](https://github.com/shigeru-kawaguchi/Xojo-BME280-I2C/blob/master/media/ScreenShot2018-09-06T20.20.36.png)

### Constructor

```xojo
Dim sensor As New RasPi_I2C.BME280()
```
The I2C address defaults to &h77 (BME280_I2C_ADDR_SEC). If your sensor is at &h76 (BME280_I2C_ADDR_PRIM), the I2C address needs to be defined in initialising parameter.

```xojo
Dim sensor As New RasPi_I2C.BME280(&h76)
```
or

```xojo
Dim sensor As New RasPi_I2C.BME280(RasPi_I2C.BME280.BME280_I2C_ADDR_PRIM)
```

Sensor will be initialised with all sensors enabled, oversampling of 1x for all sensors, IIR filter disabled in Forced Mode.

### Basics

In order to obtain the sensor reading the measureEnvironment method, then readings become available for fetching.

```xojo
Call sensor.measureEnvironment()
Double sensor.getTemperature() 'Temperature in ºC
Double sensor.getPressure() 'Barometer reading in hPa
Double sensor.getHumidity() 'Humidity in %RH
Xojo.Core.Date sensor.getMeasurementTimestamp() 'Timestamp of measurements
```

## License Information
[https://github.com/shigeru-kawaguchi/Xojo-BME280-I2C/blob/master/LICENSE](https://github.com/shigeru-kawaguchi/Xojo-BME280-I2C/blob/master/LICENSE)

## Author
Shigeru KAWAGUCHI

## Change Log
Initial release: 2018-09-03