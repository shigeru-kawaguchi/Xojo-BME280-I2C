#tag Class
Protected Class I2C
	#tag Method, Flags = &h1
		Protected Function ReadReg16(RegisterToRead As Integer) As Int16
		  #If TargetARM And TargetLinux Then
		    Soft Declare Function wpWiringPiI2CReadReg16 Lib "libwiringPi.so" Alias "wiringPiI2CReadReg16" (fd as Integer, reg as Integer) as Int16
		    
		    Return wpWiringPiI2CReadReg16(self.fileHandle, RegisterToRead)
		  #Endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReadReg8(RegisterToRead As Integer) As Integer
		  #If TargetARM And TargetLinux Then
		    Try
		      Soft Declare Function wpWiringPiI2CReadReg8 Lib "libwiringPi.so" Alias "wiringPiI2CReadReg8" (fd as Integer, reg as Integer) as Integer
		      Return wpWiringPiI2CReadReg8(self.fileHandle, RegisterToRead)
		    Catch e As RuntimeException
		      MsgBox(e.Message)
		      Return &hFF
		    End Try
		  #Endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Setup(DeviceAddress As Int16) As Boolean
		  #If TargetARM And TargetLinux Then
		    
		    Soft Declare Function wpWiringPiI2CSetup Lib "libwiringPi.so" alias "wiringPiI2CSetup" (devid as Integer) as Integer
		    self.fileHandle = wpWiringPiI2CSetup(DeviceAddress)
		    Return True
		  #Endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SleepMilliseconds(sleepDuration As Integer) As Boolean
		  #If TargetARM And TargetLinux Then
		    Soft Declare Sub wpDelay Lib "libwiringPi.so" Alias "delay" (duration As UInteger)
		    wpDelay(sleepDuration)
		    Return True
		  #Endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WriteReg16(RegisterToWrite As Int16, DataToWrite As Int16) As Integer
		  #If TargetARM And TargetLinux Then
		    Soft Declare Function wpWiringPiI2CWriteReg16 Lib "libwiringPi.so" Alias "wiringPiI2CWriteReg16" (fd as Integer, reg As Integer, data as Integer) As Integer
		    Return wpWiringPiI2CWriteReg16(self.fileHandle, RegisterToWrite, DataToWrite)
		  #Endif
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function WriteReg8(RegisterToWrite As Int16, DataToWrite As Int8) As Integer
		  #If TargetARM And TargetLinux Then
		    Soft Declare Function wpWiringPiI2CWriteReg8 Lib "libwiringPi.so" alias "wiringPiI2CWriteReg8" (fd as Integer, reg as Integer, data as Integer) As Integer
		    Return wpWiringPiI2CWriteReg8(self.fileHandle, RegisterToWrite, DataToWrite)
		  #Endif
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected fileHandle As Integer
	#tag EndProperty


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
