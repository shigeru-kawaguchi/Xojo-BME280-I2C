#tag Class
Protected Class BME280
Inherits RasPi_I2C.I2C
	#tag Method, Flags = &h1
		Protected Function checkReady() As Boolean
		  Try
		    Dim deviceStatus As UInt8
		    deviceStatus = Super.ReadReg8(self.BME280_STATUS_ADDR)
		    If deviceStatus = &h00 Then
		      Return True
		    Else
		      Return False
		    End If
		  Catch e As RuntimeException
		    MsgBox(e.Message)
		    Return False
		  End Try
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function compensateHumidity() As UInt32
		  Dim var1 As Int32
		  Dim var2 As Int32
		  Dim var3 As Int32
		  Dim var4 As Int32
		  Dim var5 As Int32
		  Dim humidity As UInt32
		  
		  var1 = self.t_fine - CType(76800, Int32)
		  var2 = Bitwise.ShiftLeft(CType(self.adc_H, Int32), 14)
		  var3 = Bitwise.ShiftLeft(CType(CType(self.dig_H4, Int32), Int32), 20)
		  var4 = CType(self.dig_H5, Int32) * var1
		  var5 = Bitwise.ShiftRight(((var2 - var3 - var4) + CType(16384, Int32)), 15)
		  var2 = Bitwise.ShiftRight((var1 * CType(self.dig_H6, Int32)), 10)
		  var3 = Bitwise.ShiftRight((var1 * CType(self.dig_H3, Int32)), 11)
		  var4 = Bitwise.ShiftRight((var2 * (var3 + CType(32768, Int32))), 10) + CType(2097152, Int32)
		  var2 = Bitwise.ShiftRight(((var4 * (CType(self.dig_H2, Int32))) + 8192), 14)
		  var3 = var5 * var2
		  var4 = Bitwise.ShiftRight((Bitwise.ShiftRight(var3, 15) * Bitwise.ShiftRight(var3, 15)), 7)
		  var5 = var3 - Bitwise.ShiftRight((var4 * (CType(self.dig_H1, Int32))), 4)
		  
		  humidity = CType(Bitwise.ShiftRight(var5, 12), UInt32)
		  
		  Return humidity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function compensatePressure() As UInt32
		  Dim var1 As Int64
		  Dim var2 As Int64
		  Dim pressure As Int64
		  Dim pressure_min As Int64 = 768000000
		  
		  var1 = CType(self.t_fine, Int64) - 128000
		  var2 = var1 * var1 * CType(self.dig_P6, Int64)
		  var2 = var2 + Bitwise.ShiftLeft((var1 * CType(self.dig_P5, Int64)), 17)
		  var2 = var2 + Bitwise.ShiftLeft(CType(self.dig_P4, Int64), 35)
		  var1 = Bitwise.ShiftRight((var1 * var1 * CType(self.dig_P3, Int64)), 8) + Bitwise.ShiftLeft((var1 * CType(self.dig_P2, Int64)), 12)
		  var1 = Bitwise.ShiftRight(((Bitwise.ShiftLeft(CType(1, Int64), 47) + var1)  * CType(self.dig_P1, Int64)), 33)
		  
		  ' To avoid divide by zero exception
		  If var1 <> 0 Then
		    pressure = 1048576 - self.adc_P
		    pressure = ((Bitwise.ShiftLeft(pressure, 31) - var2) * 3125) / var1
		    var1 = Bitwise.ShiftRight((CType(self.dig_P9, Int64) * Bitwise.ShiftRight(pressure, 13) * Bitwise.ShiftRight(pressure, 13)), 25)
		    var2 = Bitwise.ShiftRight((CType(self.dig_P8, Int64) * pressure), 19)
		    pressure = Bitwise.ShiftRight((pressure + var1 + var2), 8) + Bitwise.ShiftLeft(CType(self.dig_P7, Int64), 4)
		  Else
		    pressure = pressure_min
		  End If
		  
		  pressure = CType(pressure, UInt32)
		  Return pressure
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function compensateTemperature() As Int32
		  Dim var1 As Int32
		  Dim var2 As Int32
		  Dim temperature As Int32
		  
		  var1 = Bitwise.ShiftRight(self.adc_T, 3) - Bitwise.ShiftLeft(self.dig_T1, 1)
		  var1 = Bitwise.ShiftRight((var1 * self.dig_T2), 11)
		  var2 = Bitwise.ShiftRight(self.adc_T, 4) - self.dig_T1
		  var2 = Bitwise.ShiftRight(Bitwise.ShiftRight((var2 * var2), 12) * self.dig_T3, 14)
		  self.t_fine = var1 + var2
		  temperature = Bitwise.ShiftRight((self.t_fine * 5 + 128), 8)
		  
		  Return temperature
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(DeviceAddress As Integer = &h77)
		  
		  If Super.Setup(DeviceAddress) Then
		    If Super.ReadReg8(self.BME280_CHIP_ID_ADDR) = self.BME280_CHIP_ID Then
		      Call Super.WriteReg8(self.BME280_RESET_ADDR, self.BME280_RESET_CMD)
		      Call Super.SleepMilliseconds(20)
		      Call self.setOversampleTemperature(self.BME280_OVERSAMPLING_1X)
		      Call self.setOversamplePressure(self.BME280_OVERSAMPLING_1X)
		      Call self.setOversampleHumidity(self.BME280_OVERSAMPLING_1X)
		      Call self.setFilterCoefficient(self.BME280_FILTER_COEFF_OFF)
		      Call self.setInactiveDuration(self.BME280_STANDBY_TIME_500_MS)
		      Call self.setDeviceMode(self.BME280_MODE_FORCED)
		      Call self.fetchCalibData
		    End If
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function fetchCalibData() As Integer
		  Dim rslt As Int8
		  Dim calib_lsb As Int16
		  Dim calib_msb As Int16
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB00_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB01_ADDR)
		  self.dig_T1 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB02_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB03_ADDR)
		  self.dig_T2 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB04_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB05_ADDR)
		  self.dig_T3 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB06_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB07_ADDR)
		  self.dig_P1 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB08_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB09_ADDR)
		  self.dig_P2 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB10_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB11_ADDR)
		  self.dig_P3 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB12_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB13_ADDR)
		  self.dig_P4 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB14_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB15_ADDR)
		  self.dig_P5 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB16_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB17_ADDR)
		  self.dig_P6 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB18_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB19_ADDR)
		  self.dig_P7 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB20_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB21_ADDR)
		  self.dig_P8 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB22_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB23_ADDR)
		  self.dig_P9 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  self.dig_H1 = self.ReadReg8(self.BME280_CALIB25_ADDR)
		  
		  calib_lsb = self.ReadReg8(self.BME280_CALIB26_ADDR)
		  calib_msb = self.ReadReg8(self.BME280_CALIB27_ADDR)
		  self.dig_H2 = Bitwise.BitOr(calib_lsb, Bitwise.ShiftLeft(calib_msb, 8))
		  
		  self.dig_H3 = self.ReadReg8(self.BME280_CALIB28_ADDR)
		  
		  Dim dig_H4_msb As Int16 = self.ReadReg8(self.BME280_CALIB29_ADDR) * 16
		  Dim dig_H4_lsb As Int16 = Bitwise.BitAnd(self.ReadReg8(self.BME280_CALIB30_ADDR), &h0F)
		  self.dig_H4 = Bitwise.BitOr(dig_H4_msb, dig_H4_lsb)
		  
		  Dim dig_H5_msb As Int16 = self.ReadReg8(self.BME280_CALIB31_ADDR) * 16
		  Dim dig_H5_lsb As Int16 = Bitwise.ShiftRight(self.ReadReg8(self.BME280_CALIB30_ADDR), 4)
		  self.dig_H5 = Bitwise.BitOr(dig_H5_msb, dig_H5_lsb)
		  
		  self.dig_H6 = self.ReadReg8(self.BME280_CALIB32_ADDR)
		  
		  Return self.BME280_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function fetchSensorData() As Integer
		  Dim press_msb As UInt8 = self.ReadReg8(self.BME280_PRESS_MSB_ADDR)
		  Dim press_lsb As UInt8 = self.ReadReg8(self.BME280_PRESS_LSB_ADDR)
		  Dim press_xlsb As UInt8 = self.ReadReg8(self.BME280_PRESS_XLSB_ADDR)
		  
		  Dim temp_msb As UInt8 = self.ReadReg8(self.BME280_TEMP_MSB_ADDR)
		  Dim temp_lsb As UInt8 = self.ReadReg8(self.BME280_TEMP_LSB_ADDR)
		  Dim temp_xlsb As UInt8 = self.ReadReg8(self.BME280_TEMP_XLSB_ADDR)
		  
		  Dim hum_msb As UInt8 = self.ReadReg8(self.BME280_HUM_MSB_ADDR)
		  Dim hum_lsb As UInt8 = self.ReadReg8(self.BME280_HUM_LSB_ADDR)
		  
		  self.adc_P = Bitwise.BitOr(Bitwise.BitOr(Bitwise.ShiftLeft(press_msb, 12, 32), Bitwise.ShiftLeft(press_lsb, 4, 32)), Bitwise.ShiftRight(press_xlsb, 4, 32))
		  
		  self.adc_T = Bitwise.BitOr(Bitwise.BitOr(Bitwise.ShiftLeft(temp_msb, 12, 32), Bitwise.ShiftLeft(temp_lsb, 4, 32)), Bitwise.ShiftRight(temp_xlsb, 4, 32))
		  
		  self.adc_H = Bitwise.BitOr(Bitwise.ShiftLeft(hum_msb, 8, 32), hum_lsb)
		  
		  Return self.BME280_OK
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHumidity() As Double
		  Return self.calibratedHumidity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getMeasurementTimestamp() As Xojo.Core.Date
		  Return self.lastMeasureTimestamp
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPressure() As Double
		  Return self.calibratedPressure
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTemperature() As Double
		  Return self.calibratedTemperature
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function initializeDevice() As Boolean
		  Call Super.WriteReg8(self.BME280_RESET_ADDR, self.BME280_RESET_CMD)
		  Call Super.SleepMilliseconds(10)
		  Call self.updateRegConfig
		  Call self.updateCtrlHum
		  Call self.updateCtrlMeas
		  Call Super.SleepMilliseconds(10)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function measureEnvironment() As Boolean
		  Dim timestampLocal As Xojo.Core.Date = Xojo.Core.Date.Now
		  Dim utc As New Xojo.Core.TimeZone(0)
		  Dim timestampUTC As New Xojo.Core.Date(timestampLocal.SecondsFrom1970, utc)
		  Call self.updateRegConfig
		  Call self.updateCtrlHum
		  Call self.updateCtrlMeas
		  
		  Call Super.SleepMilliseconds(10)
		  If Not(self.checkReady) Then
		    Call Super.SleepMilliseconds(5)
		    If Not(self.checkReady) Then
		      Call Super.SleepMilliseconds(5)
		      If Not(self.checkReady) Then
		        Call Super.SleepMilliseconds(5)
		        If Not(self.checkReady) Then
		          Call Super.SleepMilliseconds(5)
		          If Not(self.checkReady) Then
		            Call Super.SleepMilliseconds(10)
		            If Not(self.checkReady) Then
		              If Not(self.checkReady) Then
		                Call Super.SleepMilliseconds(20)
		                If Not(self.checkReady) Then
		                  If Not(self.checkReady) Then
		                    Call Super.SleepMilliseconds(40)
		                    If Not(self.checkReady) Then
		                      If Not(self.checkReady) Then
		                        Call self.initializeDevice
		                        Call Super.SleepMilliseconds(10)
		                        If Not(self.checkReady) Then
		                          MsgBox("Automated device reinitialization failed.")
		                        End If
		                      End If
		                    End If
		                  End If
		                End If
		              End If
		            End If
		          End If
		        End If
		      End If
		    End If
		  End If
		  
		  Call self.fetchSensorData
		  self.lastMeasureTimestamp = timestampUTC
		  Call self.processReading
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub processReading()
		  ' Check to be Max > val > Min
		  Dim newValue As Double
		  
		  ' Temperature range check
		  newValue = CType(self.compensateTemperature, Double) / 100
		  If newValue < -40.0 Then
		    newValue = -40.0
		  ElseIf newValue > 85.0 Then
		    newValue = 85.0
		  End If
		  self.calibratedTemperature = newValue
		  
		  ' Pressure range check
		  newValue = CType(self.compensatePressure, Double) / 256
		  If newValue < 30000.0 Then
		    newValue = 30000.0
		  ElseIf newValue > 110000.0 Then
		    newValue = 110000.0
		  End If
		  self.calibratedPressure = newValue / 100
		  
		  ' Humidity range check
		  newValue = CType(self.compensateHumidity, Double) / 1024
		  If newValue < 0.0 Then
		    newValue = 0.0
		  ElseIf newValue > 100.0 Then
		    newValue = 100.0
		  End If
		  self.calibratedHumidity = newValue
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setDeviceMode(newSensorMode As UInt8) As Boolean
		  Dim newMode As UInt8
		  
		  Select Case newSensorMode
		  Case self.BME280_MODE_SLEEP
		    newMode = self.BME280_MODE_SLEEP
		  Case self.BME280_MODE_FORCED
		    newMode = self.BME280_MODE_FORCED
		  Case self.BME280_MODE_NORMAL
		    newMode = self.BME280_MODE_NORMAL
		  Case Else
		    Return False
		  End Select
		  
		  self.mode = newMode
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setFilterCoefficient(newCoefficient As UInt8) As Boolean
		  Dim newFilter As UInt8
		  
		  Select Case newCoefficient
		  Case self.BME280_FILTER_COEFF_OFF
		    newFilter = self.BME280_FILTER_COEFF_OFF
		  Case self.BME280_FILTER_COEFF_2
		    newFilter = self.BME280_FILTER_COEFF_2
		  Case self.BME280_FILTER_COEFF_4
		    newFilter = self.BME280_FILTER_COEFF_4
		  Case self.BME280_FILTER_COEFF_8
		    newFilter = self.BME280_FILTER_COEFF_8
		  Case self.BME280_FILTER_COEFF_16
		    newFilter = self.BME280_FILTER_COEFF_16
		  Case Else
		    Return False
		  End Select
		  
		  Self.filter = Bitwise.ShiftLeft(newFilter, 2)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setInactiveDuration(newStandbyTime As Int8) As Boolean
		  Dim newTsb As UInt8
		  ' Check if the new value is valid.
		  Select Case newStandbyTime
		  Case self.BME280_STANDBY_TIME_0_5_MS
		    newTsb = self.BME280_STANDBY_TIME_0_5_MS
		  Case self.BME280_STANDBY_TIME_10_MS
		    newTsb = self.BME280_STANDBY_TIME_10_MS
		  Case self.BME280_STANDBY_TIME_20_MS
		    newTsb = self.BME280_STANDBY_TIME_20_MS
		  Case self.BME280_STANDBY_TIME_62_5_MS
		    newTsb = self.BME280_STANDBY_TIME_62_5_MS
		  Case self.BME280_STANDBY_TIME_125_MS
		    newTsb = self.BME280_STANDBY_TIME_125_MS
		  Case self.BME280_STANDBY_TIME_250_MS
		    newTsb = self.BME280_STANDBY_TIME_250_MS
		  Case self.BME280_STANDBY_TIME_500_MS
		    newTsb = self.BME280_STANDBY_TIME_500_MS
		  Case self.BME280_STANDBY_TIME_1000_MS
		    newTsb = self.BME280_STANDBY_TIME_1000_MS
		  Case Else
		    Return False
		  End Select
		  
		  self.t_sb = Bitwise.ShiftLeft(newTsb, 5)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setOversampleHumidity(newOversample As UInt8) As Boolean
		  Dim newOsrsH As UInt8
		  
		  Select Case newOversample
		  Case self.BME280_OVERSAMPLING_NONE
		    newOsrsH = self.BME280_OVERSAMPLING_NONE
		  Case self.BME280_OVERSAMPLING_1X
		    newOsrsH = self.BME280_OVERSAMPLING_1X
		  Case self.BME280_OVERSAMPLING_2X
		    newOsrsH = self.BME280_OVERSAMPLING_2X
		  Case self.BME280_OVERSAMPLING_4X
		    newOsrsH = self.BME280_OVERSAMPLING_4X
		  Case self.BME280_OVERSAMPLING_8X
		    newOsrsH = self.BME280_OVERSAMPLING_8X
		  Case self.BME280_OVERSAMPLING_16X
		    newOsrsH = self.BME280_OVERSAMPLING_16X
		  Case Else
		    Return False
		  End Select
		  
		  self.osrs_h = newOsrsH
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setOversamplePressure(newOversample As UInt8) As Boolean
		  Dim newOsrsP As UInt8
		  
		  Select Case newOversample
		  Case self.BME280_OVERSAMPLING_NONE
		    newOsrsP = self.BME280_OVERSAMPLING_NONE
		  Case self.BME280_OVERSAMPLING_1X
		    newOsrsP = self.BME280_OVERSAMPLING_1X
		  Case self.BME280_OVERSAMPLING_2X
		    newOsrsP = self.BME280_OVERSAMPLING_2X
		  Case self.BME280_OVERSAMPLING_4X
		    newOsrsP = self.BME280_OVERSAMPLING_4X
		  Case self.BME280_OVERSAMPLING_8X
		    newOsrsP = self.BME280_OVERSAMPLING_8X
		  Case self.BME280_OVERSAMPLING_16X
		    newOsrsP = self.BME280_OVERSAMPLING_16X
		  Case Else
		    Return False
		  End Select
		  
		  self.osrs_p = Bitwise.ShiftLeft(newOsrsP, 2)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setOversampleTemperature(newOversample As UInt8) As Boolean
		  Dim newOsrsT As UInt8
		  
		  Select Case newOversample
		  Case self.BME280_OVERSAMPLING_NONE
		    newOsrsT = self.BME280_OVERSAMPLING_NONE
		  Case self.BME280_OVERSAMPLING_1X
		    newOsrsT = self.BME280_OVERSAMPLING_1X
		  Case self.BME280_OVERSAMPLING_2X
		    newOsrsT = self.BME280_OVERSAMPLING_2X
		  Case self.BME280_OVERSAMPLING_4X
		    newOsrsT = self.BME280_OVERSAMPLING_4X
		  Case self.BME280_OVERSAMPLING_8X
		    newOsrsT = self.BME280_OVERSAMPLING_8X
		  Case self.BME280_OVERSAMPLING_16X
		    newOsrsT = self.BME280_OVERSAMPLING_16X
		  Case Else
		    Return False
		  End Select
		  
		  self.osrs_t = Bitwise.ShiftLeft(newOsrsT, 5)
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function updateCtrlHum() As Boolean
		  Call Super.WriteReg8(self.BME280_CTRL_HUM_ADDR, self.osrs_h)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function updateCtrlMeas() As Boolean
		  Dim newCtrlMeas As UInt8
		  newCtrlMeas = Bitwise.BitOr(Bitwise.BitOr(self.osrs_t, self.osrs_p), self.mode)
		  Call Super.WriteReg8(self.BME280_CTRL_MEAS_ADDR, newCtrlMeas)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function updateRegConfig() As Boolean
		  Dim newConfig As UInt8
		  newConfig = Bitwise.BitOr(self.t_sb, self.filter)
		  Call Super.WriteReg8(self.BME280_CONFIG_ADDR, newConfig)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected adc_H As Int32
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected adc_P As Int32
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected adc_T As Int32
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected calibratedHumidity As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected calibratedPressure As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected calibratedTemperature As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_H1 As UInt8
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_H2 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_H3 As UInt8
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_H4 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_H5 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_H6 As Int8
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_P1 As Uint16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_P2 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_P3 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_P4 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_P5 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_P6 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_P7 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_P8 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_P9 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_T1 As Uint16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_T2 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dig_T3 As Int16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected filter As UInt8
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected lastMeasureTimestamp As Xojo.Core.Date
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mode As UInt8
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected osrs_h As UInt8
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected osrs_p As Uint8
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected osrs_t As UInt8
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected t_fine As Int32
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected t_sb As UInt8
	#tag EndProperty


	#tag Constant, Name = BME280_CALIB00_ADDR, Type = Double, Dynamic = False, Default = \"&h88", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB01_ADDR, Type = Double, Dynamic = False, Default = \"&h89", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB02_ADDR, Type = Double, Dynamic = False, Default = \"&h8A", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB03_ADDR, Type = Double, Dynamic = False, Default = \"&h8B", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB04_ADDR, Type = Double, Dynamic = False, Default = \"&h8C", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB05_ADDR, Type = Double, Dynamic = False, Default = \"&h8D", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB06_ADDR, Type = Double, Dynamic = False, Default = \"&h8E", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB07_ADDR, Type = Double, Dynamic = False, Default = \"&h8F", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB08_ADDR, Type = Double, Dynamic = False, Default = \"&h90", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB09_ADDR, Type = Double, Dynamic = False, Default = \"&h91", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB10_ADDR, Type = Double, Dynamic = False, Default = \"&h92", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB11_ADDR, Type = Double, Dynamic = False, Default = \"&h93", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB12_ADDR, Type = Double, Dynamic = False, Default = \"&h94", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB13_ADDR, Type = Double, Dynamic = False, Default = \"&h95", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB14_ADDR, Type = Double, Dynamic = False, Default = \"&h96", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB15_ADDR, Type = Double, Dynamic = False, Default = \"&h97", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB16_ADDR, Type = Double, Dynamic = False, Default = \"&h98", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB17_ADDR, Type = Double, Dynamic = False, Default = \"&h99", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB18_ADDR, Type = Double, Dynamic = False, Default = \"&h9A", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB19_ADDR, Type = Double, Dynamic = False, Default = \"&h9B", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB20_ADDR, Type = Double, Dynamic = False, Default = \"&h9C", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB21_ADDR, Type = Double, Dynamic = False, Default = \"&h9D", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB22_ADDR, Type = Double, Dynamic = False, Default = \"&h9E", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB23_ADDR, Type = Double, Dynamic = False, Default = \"&h9F", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB24_ADDR, Type = Double, Dynamic = False, Default = \"&hA0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB25_ADDR, Type = Double, Dynamic = False, Default = \"&hA1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB26_ADDR, Type = Double, Dynamic = False, Default = \"&hE1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB27_ADDR, Type = Double, Dynamic = False, Default = \"&hE2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB28_ADDR, Type = Double, Dynamic = False, Default = \"&hE3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB29_ADDR, Type = Double, Dynamic = False, Default = \"&hE4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB30_ADDR, Type = Double, Dynamic = False, Default = \"&hE5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB31_ADDR, Type = Double, Dynamic = False, Default = \"&hE6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB32_ADDR, Type = Double, Dynamic = False, Default = \"&hE7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB33_ADDR, Type = Double, Dynamic = False, Default = \"&hE8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB34_ADDR, Type = Double, Dynamic = False, Default = \"&hE9", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB35_ADDR, Type = Double, Dynamic = False, Default = \"&hEA", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB36_ADDR, Type = Double, Dynamic = False, Default = \"&hEB", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB37_ADDR, Type = Double, Dynamic = False, Default = \"&hEC", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB38_ADDR, Type = Double, Dynamic = False, Default = \"&hED", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB39_ADDR, Type = Double, Dynamic = False, Default = \"&hEE", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB40_ADDR, Type = Double, Dynamic = False, Default = \"&hEF", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CALIB41_ADDR, Type = Double, Dynamic = False, Default = \"&hF0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CHIP_ID, Type = Double, Dynamic = False, Default = \"&h60", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CHIP_ID_ADDR, Type = Double, Dynamic = False, Default = \"&hD0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CONFIG_ADDR, Type = Double, Dynamic = False, Default = \"&hF5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CTRL_HUM_ADDR, Type = Double, Dynamic = False, Default = \"&hF2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_CTRL_MEAS_ADDR, Type = Double, Dynamic = False, Default = \"&hF4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_DATA_ADDR, Type = Double, Dynamic = False, Default = \"&hF7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_E_COMM_FAIL, Type = Double, Dynamic = False, Default = \"-4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_E_DEV_NOT_FOUND, Type = Double, Dynamic = False, Default = \"-2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_E_INVALID_LEN, Type = Double, Dynamic = False, Default = \"-3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_E_NULL_PTR, Type = Double, Dynamic = False, Default = \"-1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_E_SLEEP_MODE_FAIL, Type = Double, Dynamic = False, Default = \"-5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_FILTER_COEFF_16, Type = Double, Dynamic = False, Default = \"&h04", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_FILTER_COEFF_2, Type = Double, Dynamic = False, Default = \"&h01", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_FILTER_COEFF_4, Type = Double, Dynamic = False, Default = \"&h02", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_FILTER_COEFF_8, Type = Double, Dynamic = False, Default = \"&h03", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_FILTER_COEFF_OFF, Type = Double, Dynamic = False, Default = \"&h00", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_HUMIDITY_CALIB_DATA_ADDR, Type = Double, Dynamic = False, Default = \"&hE1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_HUMIDITY_CALIB_DATA_LEN, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_HUM_LSB_ADDR, Type = Double, Dynamic = False, Default = \"&hFE", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_HUM_MSB_ADDR, Type = Double, Dynamic = False, Default = \"&hFD", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_I2C_ADDR_PRIM, Type = Double, Dynamic = False, Default = \"&h76", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_I2C_ADDR_SEC, Type = Double, Dynamic = False, Default = \"&h77", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_MODE_FORCED, Type = Double, Dynamic = False, Default = \"&h01", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_MODE_NORMAL, Type = Double, Dynamic = False, Default = \"&h03", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_MODE_SLEEP, Type = Double, Dynamic = False, Default = \"&h00", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_OK, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_OVERSAMPLING_16X, Type = Double, Dynamic = False, Default = \"&h05", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_OVERSAMPLING_1X, Type = Double, Dynamic = False, Default = \"&h01", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_OVERSAMPLING_2X, Type = Double, Dynamic = False, Default = \"&h02", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_OVERSAMPLING_4X, Type = Double, Dynamic = False, Default = \"&h03", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_OVERSAMPLING_8X, Type = Double, Dynamic = False, Default = \"&h04", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_OVERSAMPLING_NONE, Type = Double, Dynamic = False, Default = \"&h00", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_PRESS_LSB_ADDR, Type = Double, Dynamic = False, Default = \"&hF8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_PRESS_MSB_ADDR, Type = Double, Dynamic = False, Default = \"&hF7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_PRESS_XLSB_ADDR, Type = Double, Dynamic = False, Default = \"&hF9", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_PWR_CTRL_ADDR, Type = Double, Dynamic = False, Default = \"&hF4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_P_T_H_DATA_LEN, Type = Double, Dynamic = False, Default = \"8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_RESET_ADDR, Type = Double, Dynamic = False, Default = \"&hE0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_RESET_CMD, Type = Double, Dynamic = False, Default = \"&hB6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_STANDBY_TIME_0_5_MS, Type = Double, Dynamic = False, Default = \"&h00", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_STANDBY_TIME_1000_MS, Type = Double, Dynamic = False, Default = \"&h05", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_STANDBY_TIME_10_MS, Type = Double, Dynamic = False, Default = \"&h06", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_STANDBY_TIME_125_MS, Type = Double, Dynamic = False, Default = \"&h02", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_STANDBY_TIME_20_MS, Type = Double, Dynamic = False, Default = \"&h07", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_STANDBY_TIME_250_MS, Type = Double, Dynamic = False, Default = \"&h03", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_STANDBY_TIME_500_MS, Type = Double, Dynamic = False, Default = \"&h04", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_STANDBY_TIME_62_5_MS, Type = Double, Dynamic = False, Default = \"&h01", Scope = Public
	#tag EndConstant

	#tag Constant, Name = BME280_STATUS_ADDR, Type = Double, Dynamic = False, Default = \"&hF3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_TEMP_LSB_ADDR, Type = Double, Dynamic = False, Default = \"&hFB", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_TEMP_MSB_ADDR, Type = Double, Dynamic = False, Default = \"&hFA", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_TEMP_PRESS_CALIB_DATA_ADDR, Type = Double, Dynamic = False, Default = \"&h88", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_TEMP_PRESS_CALIB_DATA_LEN, Type = Double, Dynamic = False, Default = \"26", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_TEMP_XLSB_ADDR, Type = Double, Dynamic = False, Default = \"&hFC", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = BME280_W_INVALID_OSR_MACRO, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
