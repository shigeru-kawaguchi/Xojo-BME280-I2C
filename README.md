# Xojo-BME280-I2C

Xojo driver module for Bosch Sensortec BME280 temperature, barometer and humidity sensor.

It makes use of WiringPi GPIO Interface library for the Raspberry Pi, which details are availble from [here](http://wiringpi.com).

I have been developing with Xojo 2018r2 on Mac and testing on Raspberry Pi 3B+ hardware with latest Raspbian OS at the time of submission.

![Demo screenshot](https://github.com/shigeru-kawaguchi/Xojo-BME280-I2C/blob/master/media/ScreenShot2018-09-08T22.16.19.png)

#### Caution
If you try the timer value too close to the Tmeas, the demo app will crash.

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
* Normal mode implementation. (Currently WiringPi does not offer burst reading of registers in series, i.e. from &hF7 to &hFE in one query. It is not practical to implement Normal mode.) 

## Usage
Copy the RasPi\_I2C module into your project and call the RasPi\_I2C.BME280 class in your program. RasPi\_I2C.BME280 is a subclass of RasPi_I2C.I2C.

![RasPi_I2C module](https://github.com/shigeru-kawaguchi/Xojo-BME280-I2C/blob/master/media/ScreenShot2018-09-06T20.20.36.png)

### Constructor

```xojo
Dim sensor As New RasPi_I2C.BME280()
```
The I2C address defaults to &h77 (BME280\_I2C\_ADDR\_SEC). If your sensor is at &h76 (BME280\_I2C\_ADDR\_PRIM), the I2C address needs to be defined in initialising parameter.

```xojo
Dim sensor As New RasPi_I2C.BME280(&h76)
```
or

```xojo
Dim sensor As New RasPi_I2C.BME280(RasPi_I2C.BME280.BME280_I2C_ADDR_PRIM)
```

Sensor will be initialised with all sensors enabled, oversampling of 1x for all sensors, IIR filter disabled in Forced Mode.

### Basics

In order to obtain the sensor readings the measureEnvironment method needs to be called, then readings become available for fetching.

```xojo
Call sensor.measureEnvironment()
Double sensor.getTemperature() 'Temperature in ºC
Double sensor.getPressure() 'Barometer reading in hPa
Double sensor.getHumidity() 'Humidity in %RH
Xojo.Core.Date sensor.getMeasurementTimestamp() 'Timestamp of measurements in UTC
```

### Oversampling Parameters

Oversampling parameters can be set by supplying actual UInt8 value or the Public Constants listed below;

Constant | Value | Setting
-------- | ----- | -------
BME280\_OVERSAMPLING\_NONE | &h00 | No measurement
BME280\_OVERSAMPLING\_1X | &h01 | 1 x
BME280\_OVERSAMPLING\_2X | &h02 | 2 x
BME280\_OVERSAMPLING\_4X | &h03 | 4 x
BME280\_OVERSAMPLING\_8X | &h04 | 8 x
BME280\_OVERSAMPLING\_16X | &h05 | 16 x

#### Examples:
##### Thermometer

**NOTE**: Since temperature reading is required to execute compensation function, do not set thermometer with &h00 or BME280\_OVERSAMPLING\_NONE.

```xojo
Boolean sensor.setOversampleTemperature(&h01)
```

or

```xojo
Boolean sensor.setOversampleTemperature(RasPi_I2C.BME280.BME280_OVERSAMPLING_1X)
```

##### Barometer

```xojo
Boolean sensor.setOversamplePressure(&h04)
```

or

```xojo
Boolean sensor.setOversamplePressure(RasPi_I2C.BME280.BME280_OVERSAMPLING_8X)
```

##### Humidimeter

```xojo
Boolean sensor.setOversampleHumidity(&h03)
```

or

```xojo
Boolean sensor.setOversampleHumidity(RasPi_I2C.BME280.BME280_OVERSAMPLING_4X)
```
### IIR Filter Coefficient Parameter

Filter Coefficient parameter can be set by supplying actual UInt8 value or the Public Constants listed below;

Constant | Value | Setting
-------- | ----- | -------
BME280\_FILTER\_COEFF\_OFF | &h00 | No filtering
BME280\_FILTER\_COEFF\_2 | &h01 | 2
BME280\_FILTER\_COEFF\_4 | &h02 | 4
BME280\_FILTER\_COEFF\_8 | &h03 | 8
BME280\_FILTER\_COEFF\_16 | &h04 | 16

#### Examples:

```xojo
Boolean sensor.setFilterCoefficient(&h02)
```

or

```xojo
Boolean sensor.setFilterCoefficient(RasPi_I2C.BME280.BME280_FILTER_COEFF_8)
```

## License Information
[https://github.com/shigeru-kawaguchi/Xojo-BME280-I2C/blob/master/LICENSE](https://github.com/shigeru-kawaguchi/Xojo-BME280-I2C/blob/master/LICENSE)

## Author
Shigeru KAWAGUCHI

## Change Log
Initial release: 2018-09-08