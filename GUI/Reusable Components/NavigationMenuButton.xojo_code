#tag WebContainerControl
Begin WebContainer NavigationMenuButton
   Compatibility   =   ""
   ControlID       =   ""
   Enabled         =   True
   Height          =   50
   Indicator       =   0
   LayoutDirection =   0
   LayoutType      =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   True
   LockRight       =   False
   LockTop         =   True
   LockVertical    =   False
   ScrollDirection =   0
   TabIndex        =   0
   Top             =   0
   Visible         =   True
   Width           =   250
   _mDesignHeight  =   0
   _mDesignWidth   =   0
   _mPanelIndex    =   -1
   Begin WebCanvas BackgroundCanvas
      ControlID       =   ""
      DiffEngineDisabled=   False
      Enabled         =   True
      Height          =   50
      Index           =   -2147483648
      Indicator       =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      TabIndex        =   0
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   250
      _mPanelIndex    =   -1
   End
   Begin WebImageViewer IconViewer
      ControlID       =   ""
      Enabled         =   True
      Height          =   26
      HorizontalAlignment=   2
      Index           =   -2147483648
      Indicator       =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      LockVertical    =   True
      Picture         =   0
      Scope           =   0
      SVGData         =   ""
      TabIndex        =   1
      Tooltip         =   ""
      Top             =   12
      URL             =   ""
      VerticalAlignment=   2
      Visible         =   True
      Width           =   26
      _mPanelIndex    =   -1
      _ProtectImage   =   False
   End
   Begin WebLabel CaptionLabel
      Bold            =   False
      ControlID       =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   20.0
      Height          =   50
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   56
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Multiline       =   False
      Scope           =   0
      TabIndex        =   2
      Text            =   "Untitled"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   0
      Underline       =   False
      Visible         =   True
      Width           =   174
      _mPanelIndex    =   -1
   End
   Begin WebCanvas OverlayCanvas
      ControlID       =   ""
      DiffEngineDisabled=   False
      Enabled         =   True
      Height          =   50
      Index           =   -2147483648
      Indicator       =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      LockVertical    =   False
      Scope           =   0
      TabIndex        =   3
      Tooltip         =   ""
      Top             =   0
      Visible         =   True
      Width           =   250
      _mPanelIndex    =   -1
   End
End
#tag EndWebContainerControl

#tag WindowCode
	#tag Event
		Sub Opening()
		  Style.Cursor = WebStyle.Cursors.Pointer
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function CaptionWidth() As Integer
		  Var p As New Picture(1, 1)
		  Var g As Graphics = p.Graphics
		  g.Bold = True
		  g.FontSize = 20
		  Return g.TextWidth(Caption)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UpdateIcon()
		  Var icon As String = If(Active, IconName + "-fill", IconName)
		  IconViewer.Picture = WebPicture.BootstrapIcon(icon, Color.Black)
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Pressed()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mActive
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mActive = value
			  UpdateIcon
			  CaptionLabel.Bold = value
			End Set
		#tag EndSetter
		Active As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return CaptionLabel.Text
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  CaptionLabel.Text = value
			  BackgroundCanvas.Refresh
			End Set
		#tag EndSetter
		Caption As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mIconName
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mIconName = value
			  UpdateIcon
			End Set
		#tag EndSetter
		IconName As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mActive As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mIconName As String = "house"
	#tag EndProperty


	#tag Constant, Name = kHoverJS, Type = String, Dynamic = False, Default = \"$(\'#{{controlID}}\').hover(function() {\n  $(\'#{{targetID}} canvas\').css(\'opacity\'\x2C 1);\n}\x2C function() {\n  $(\'#{{targetID}} canvas\').css(\'opacity\'\x2C 0);\n});", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events BackgroundCanvas
	#tag Event
		Sub Paint(g as WebGraphics)
		  g.DrawingColor = Color.RGB(215, 215, 215)
		  g.FillRoundRectangle(0, 0, CaptionLabel.Left + captionWidth + 20, g.Height, 25)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Me.Style.Opacity = 0
		  Me.Style.AddTransition("opacity", .15)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OverlayCanvas
	#tag Event
		Sub Pressed(x as Integer, y as Integer)
		  Pressed
		End Sub
	#tag EndEvent
	#tag Event
		Sub Opening()
		  Var js As String = kHoverJS
		  js = js.ReplaceAll("{{controlID}}", Me.ControlID)
		  js = js.ReplaceAll("{{targetID}}", BackgroundCanvas.ControlID)
		  ExecuteJavaScript(js)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=false
		Group="Position"
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=false
		Group="Position"
		InitialValue="250"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mPanelIndex"
		Visible=false
		Group="Behavior"
		InitialValue="-1"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ControlID"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignHeight"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mDesignWidth"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="_mName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ScrollDirection"
		Visible=true
		Group="Behavior"
		InitialValue="ScrollDirections.None"
		Type="WebContainer.ScrollDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - None"
			"1 - Horizontal"
			"2 - Vertical"
			"3 - Both"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Caption"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabIndex"
		Visible=true
		Group="Visual Controls"
		InitialValue=""
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Indicator"
		Visible=false
		Group="Visual Controls"
		InitialValue=""
		Type="WebUIControl.Indicators"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Primary"
			"2 - Secondary"
			"3 - Success"
			"4 - Danger"
			"5 - Warning"
			"6 - Info"
			"7 - Light"
			"8 - Dark"
			"9 - Link"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutType"
		Visible=true
		Group="View"
		InitialValue="LayoutTypes.Fixed"
		Type="LayoutTypes"
		EditorType="Enum"
		#tag EnumValues
			"0 - Fixed"
			"1 - Flex"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="LayoutDirection"
		Visible=true
		Group="View"
		InitialValue="LayoutDirections.LeftToRight"
		Type="LayoutDirections"
		EditorType="Enum"
		#tag EnumValues
			"0 - LeftToRight"
			"1 - RightToLeft"
			"2 - TopToBottom"
			"3 - BottomToTop"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="IconName"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Active"
		Visible=false
		Group="Behavior"
		InitialValue=""
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
