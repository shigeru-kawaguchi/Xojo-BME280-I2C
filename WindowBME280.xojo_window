#tag Window
Begin Window WindowBME280
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   306
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   1908432895
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "BME280"
   Visible         =   True
   Width           =   377
   Begin RoundRectangle RoundRectangle1
      AutoDeactivate  =   True
      BorderColor     =   &c66FFFE00
      BorderWidth     =   1
      Enabled         =   True
      FillColor       =   &cCCFFFE00
      Height          =   100
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   15
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      OvalHeight      =   16
      OvalWidth       =   16
      Scope           =   2
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   186
      Transparent     =   False
      Visible         =   True
      Width           =   342
      Begin PopupMenu PopupMenuFilter
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   30
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "RoundRectangle1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   264
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   221
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin PopupMenu PopupMenuOversampleP
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   30
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "RoundRectangle1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   132
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   221
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin PopupMenu PopupMenuOversampleH
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   30
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "RoundRectangle1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   132
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   2
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   253
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
      Begin Label Label8
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "RoundRectangle1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Oversample H"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   254
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin Label Label7
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "RoundRectangle1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Oversample P"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   222
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin Label Label9
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "RoundRectangle1"
         Italic          =   False
         Left            =   224
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   5
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Filter CoEfficient"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   190
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   120
      End
      Begin Label Label6
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "RoundRectangle1"
         Italic          =   False
         Left            =   20
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   2
         Selectable      =   False
         TabIndex        =   6
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   "Oversample T"
         TextAlign       =   0
         TextColor       =   &c00000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   190
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   100
      End
      Begin PopupMenu PopupMenuOversampleT
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   30
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "RoundRectangle1"
         InitialValue    =   ""
         Italic          =   False
         Left            =   132
         ListIndex       =   0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   2
         TabIndex        =   7
         TabPanelIndex   =   0
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   189
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   80
      End
   End
   Begin Label Label1
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Temperature"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin Label Label2
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Barometer"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   52
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin Label Label3
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Humidity"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   84
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin Label Label4
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Timestamp"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   116
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin TextField TextFieldTemperature
      AcceptTabs      =   False
      Alignment       =   3
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Format          =   ""
      Height          =   30
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   132
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   19
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   220
   End
   Begin TextField TextFieldBarometer
      AcceptTabs      =   False
      Alignment       =   3
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Format          =   ""
      Height          =   30
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   132
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   51
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   220
   End
   Begin TextField TextFieldHumidity
      AcceptTabs      =   False
      Alignment       =   3
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Format          =   ""
      Height          =   30
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   132
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   83
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   220
   End
   Begin TextField TextFieldTimestamp
      AcceptTabs      =   False
      Alignment       =   3
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   False
      Format          =   ""
      Height          =   30
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   132
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   115
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   220
   End
   Begin Timer TimerRepeat
      Enabled         =   True
      Index           =   -2147483648
      LockedInPosition=   False
      Mode            =   2
      Period          =   100
      Scope           =   2
      TabPanelIndex   =   0
   End
   Begin PopupMenu PopupMenuTimer
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   30
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   132
      ListIndex       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   148
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin Label Label5
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Timer"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   149
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
End
#tag EndWindow

#tag WindowCode
#tag EndWindowCode

#tag Events PopupMenuFilter
	#tag Event
		Sub Open()
		  self.PopupMenuFilter.DeleteAllRows
		  self.PopupMenuFilter.AddRow("Off")
		  self.PopupMenuFilter.AddRow("2")
		  self.PopupMenuFilter.AddRow("4")
		  self.PopupMenuFilter.AddRow("8")
		  self.PopupMenuFilter.AddRow("16")
		  self.PopupMenuFilter.ListIndex = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Select Case self.PopupMenuFilter.ListIndex
		  Case 0
		    Call app.envitonmentMeasures.setFilterCoefficient(RasPi_I2C.BME280.BME280_FILTER_COEFF_OFF)
		  Case 1
		    Call app.envitonmentMeasures.setFilterCoefficient(RasPi_I2C.BME280.BME280_FILTER_COEFF_2)
		  Case 2
		    Call app.envitonmentMeasures.setFilterCoefficient(RasPi_I2C.BME280.BME280_FILTER_COEFF_4)
		  Case 3
		    Call app.envitonmentMeasures.setFilterCoefficient(RasPi_I2C.BME280.BME280_FILTER_COEFF_8)
		  Case 4
		    Call app.envitonmentMeasures.setFilterCoefficient(RasPi_I2C.BME280.BME280_FILTER_COEFF_16)
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupMenuOversampleP
	#tag Event
		Sub Open()
		  self.PopupMenuOversampleP.DeleteAllRows
		  self.PopupMenuOversampleP.AddRow("1x")
		  self.PopupMenuOversampleP.AddRow("2x")
		  self.PopupMenuOversampleP.AddRow("4x")
		  self.PopupMenuOversampleP.AddRow("8x")
		  self.PopupMenuOversampleP.AddRow("16x")
		  self.PopupMenuOversampleP.ListIndex = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Select Case self.PopupMenuOversampleP.ListIndex
		  Case 0
		    Call app.envitonmentMeasures.setOversamplePressure(RasPi_I2C.BME280.BME280_OVERSAMPLING_1X)
		  Case 1
		    Call app.envitonmentMeasures.setOversamplePressure(RasPi_I2C.BME280.BME280_OVERSAMPLING_2X)
		  Case 2
		    Call app.envitonmentMeasures.setOversamplePressure(RasPi_I2C.BME280.BME280_OVERSAMPLING_4X)
		  Case 3
		    Call app.envitonmentMeasures.setOversamplePressure(RasPi_I2C.BME280.BME280_OVERSAMPLING_8X)
		  Case 4
		    Call app.envitonmentMeasures.setOversamplePressure(RasPi_I2C.BME280.BME280_OVERSAMPLING_16X)
		  Case 5
		    Call app.envitonmentMeasures.setOversamplePressure(RasPi_I2C.BME280.BME280_OVERSAMPLING_NONE)
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupMenuOversampleH
	#tag Event
		Sub Open()
		  self.PopupMenuOversampleH.DeleteAllRows
		  self.PopupMenuOversampleH.AddRow("1x")
		  self.PopupMenuOversampleH.AddRow("2x")
		  self.PopupMenuOversampleH.AddRow("4x")
		  self.PopupMenuOversampleH.AddRow("8x")
		  self.PopupMenuOversampleH.AddRow("16x")
		  self.PopupMenuOversampleH.ListIndex = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Select Case self.PopupMenuOversampleH.ListIndex
		  Case 0
		    Call app.envitonmentMeasures.setOversampleHumidity(RasPi_I2C.BME280.BME280_OVERSAMPLING_1X)
		  Case 1
		    Call app.envitonmentMeasures.setOversampleHumidity(RasPi_I2C.BME280.BME280_OVERSAMPLING_2X)
		  Case 2
		    Call app.envitonmentMeasures.setOversampleHumidity(RasPi_I2C.BME280.BME280_OVERSAMPLING_4X)
		  Case 3
		    Call app.envitonmentMeasures.setOversampleHumidity(RasPi_I2C.BME280.BME280_OVERSAMPLING_8X)
		  Case 4
		    Call app.envitonmentMeasures.setOversampleHumidity(RasPi_I2C.BME280.BME280_OVERSAMPLING_16X)
		  Case 5
		    Call app.envitonmentMeasures.setOversampleHumidity(RasPi_I2C.BME280.BME280_OVERSAMPLING_NONE)
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupMenuOversampleT
	#tag Event
		Sub Open()
		  self.PopupMenuOversampleT.DeleteAllRows
		  self.PopupMenuOversampleT.AddRow("1x")
		  self.PopupMenuOversampleT.AddRow("2x")
		  self.PopupMenuOversampleT.AddRow("4x")
		  self.PopupMenuOversampleT.AddRow("8x")
		  self.PopupMenuOversampleT.AddRow("16x")
		  self.PopupMenuOversampleT.ListIndex = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Select Case self.PopupMenuOversampleT.ListIndex
		  Case 0
		    Call app.envitonmentMeasures.setOversampleTemperature(RasPi_I2C.BME280.BME280_OVERSAMPLING_1X)
		  Case 1
		    Call app.envitonmentMeasures.setOversampleTemperature(RasPi_I2C.BME280.BME280_OVERSAMPLING_2X)
		  Case 2
		    Call app.envitonmentMeasures.setOversampleTemperature(RasPi_I2C.BME280.BME280_OVERSAMPLING_4X)
		  Case 3
		    Call app.envitonmentMeasures.setOversampleTemperature(RasPi_I2C.BME280.BME280_OVERSAMPLING_8X)
		  Case 4
		    Call app.envitonmentMeasures.setOversampleTemperature(RasPi_I2C.BME280.BME280_OVERSAMPLING_16X)
		  Case 5
		    Call app.envitonmentMeasures.setOversampleTemperature(RasPi_I2C.BME280.BME280_OVERSAMPLING_NONE)
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TimerRepeat
	#tag Event
		Sub Action()
		  Call app.envitonmentMeasures.measureEnvironment
		  self.TextFieldTemperature.Text = Format(app.envitonmentMeasures.getTemperature, "0.00") + " ºC"
		  self.TextFieldBarometer.Text = Format(app.envitonmentMeasures.getPressure, "0.000") + " hPa"
		  self.TextFieldHumidity.Text = Format(app.envitonmentMeasures.getHumidity, "0.000") + " %RH"
		  self.TextFieldTimestamp.Text = app.envitonmentMeasures.getMeasurementTimestamp.ToText + "." + Format(app.envitonmentMeasures.getMeasurementTimestamp.Nanosecond / 1000000, "000")
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PopupMenuTimer
	#tag Event
		Sub Open()
		  self.PopupMenuTimer.DeleteAllRows
		  self.PopupMenuTimer.AddRow("100 ms")
		  self.PopupMenuTimer.AddRow("250 ms")
		  self.PopupMenuTimer.AddRow("500 ms")
		  self.PopupMenuTimer.AddRow("1000 ms")
		  self.PopupMenuTimer.AddRow("2500 ms")
		  self.PopupMenuTimer.AddRow("5000 ms")
		  self.PopupMenuTimer.ListIndex = 0
		End Sub
	#tag EndEvent
	#tag Event
		Sub Change()
		  Select Case self.PopupMenuTimer.ListIndex
		  Case 0
		    self.TimerRepeat.Period = 100
		  Case 1
		    self.TimerRepeat.Period = 250
		  Case 2
		    self.TimerRepeat.Period = 500
		  Case 3
		    self.TimerRepeat.Period = 1000
		  Case 4
		    self.TimerRepeat.Period = 2500
		  Case 5
		    self.TimerRepeat.Period = 5000
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
