#tag WebContainerControl
Begin WebContainer LoggedUserMenuButton
   Compatibility   =   ""
   ControlID       =   ""
   Enabled         =   True
   Height          =   65
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
   Begin WebImageViewer AvatarImageViewer
      ControlID       =   ""
      Enabled         =   True
      Height          =   39
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
      Scope           =   2
      SVGData         =   ""
      TabIndex        =   0
      Tooltip         =   ""
      Top             =   13
      URL             =   ""
      VerticalAlignment=   2
      Visible         =   True
      Width           =   39
      _mPanelIndex    =   -1
      _ProtectImage   =   False
   End
   Begin WebLabel FullNameLabel
      Bold            =   True
      ControlID       =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   18.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   ""
      Italic          =   False
      Left            =   67
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      Scope           =   2
      TabIndex        =   1
      Text            =   "Full Name"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   5
      Underline       =   False
      Visible         =   True
      Width           =   139
      _mPanelIndex    =   -1
   End
   Begin WebLabel HandleLabel
      Bold            =   False
      ControlID       =   ""
      Enabled         =   True
      FontName        =   ""
      FontSize        =   14.0
      Height          =   38
      Index           =   -2147483648
      Indicator       =   0
      Italic          =   False
      Left            =   67
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   True
      Multiline       =   False
      Scope           =   2
      TabIndex        =   2
      Text            =   "@user_handle"
      TextAlignment   =   0
      TextColor       =   &c3F3F3F00
      Tooltip         =   ""
      Top             =   23
      Underline       =   False
      Visible         =   True
      Width           =   139
      _mPanelIndex    =   -1
   End
   Begin WebImageViewer MoreImageViewer
      ControlID       =   ""
      Enabled         =   True
      Height          =   17
      HorizontalAlignment=   2
      Index           =   -2147483648
      Indicator       =   0
      Left            =   213
      LockBottom      =   False
      LockedInPosition=   False
      LockHorizontal  =   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      LockVertical    =   True
      Picture         =   0
      Scope           =   2
      SVGData         =   ""
      TabIndex        =   3
      Tooltip         =   ""
      Top             =   23
      URL             =   ""
      VerticalAlignment=   2
      Visible         =   True
      Width           =   17
      _mPanelIndex    =   -1
      _ProtectImage   =   False
   End
   Begin WebCanvas OverlayCanvas
      ControlID       =   ""
      DiffEngineDisabled=   False
      Enabled         =   True
      Height          =   65
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
      Scope           =   2
      TabIndex        =   4
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
		  Style.Value("border-radius") = "50px"
		  Style.Value("position") = "fixed"
		  Style.Value("left") = "initial"
		  Style.BackgroundColor = Color.RGB(215, 215, 215, 255)
		  
		  Style.AddTransition("background-color", 0.1)
		  
		  ExecuteJavaScript("$('#" + Self.ControlID + "').addClass('dropup')")
		  
		  Var menu As New WebMenuItem
		  menu.AddMenuItem("Add an existing account")
		  menu.AddMenuItem("Manage accounts")
		  menu.AddMenuItem("Log out @" + mUserHandle)
		  ContextualMenu = menu
		  
		  Opening
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event Opening()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return FullNameLabel.Text
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  FullNameLabel.Text = value
			End Set
		#tag EndSetter
		FullName As String
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mUserHandle As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return AvatarImageViewer.Picture
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  AvatarImageViewer.Picture = value
			End Set
		#tag EndSetter
		UserAvatar As WebPicture
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mUserHandle
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mUserHandle = value
			  HandleLabel.Text = "@" + value
			End Set
		#tag EndSetter
		UserHandle As String
	#tag EndComputedProperty


	#tag Constant, Name = kHoverJS, Type = String, Dynamic = False, Default = \"$(\'#{{controlID}}\').hover(function() {\n  $(\'#{{targetID}}\').css(\'backgroundColor\'\x2C \'rgb(215\x2C 215\x2C 215\x2C 1)\');\n}\x2C function() {\n  $(\'#{{targetID}}\').css(\'backgroundColor\'\x2C \'rgb(215\x2C 215\x2C 215\x2C 0)\');\n});", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events AvatarImageViewer
	#tag Event
		Sub Opening()
		  Me.Picture = WebPicture.BootstrapIcon("person-bounding-box", Color.LightGray)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MoreImageViewer
	#tag Event
		Sub Opening()
		  Me.Picture = WebPicture.BootstrapIcon("three-dots", Color.Black)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events OverlayCanvas
	#tag Event
		Sub Opening()
		  Me.Style.Cursor = WebStyle.Cursors.Pointer
		  
		  Var js As String = kHoverJS
		  js = js.ReplaceAll("{{controlID}}", Me.ControlID)
		  js = js.ReplaceAll("{{targetID}}", Self.ControlID)
		  ExecuteJavaScript(js)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Pressed(x as Integer, y as Integer)
		  ExecuteJavaScript("$('#" + Self.ControlID + "').trigger('contextmenu')")
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
		Name="FullName"
		Visible=true
		Group="Behavior"
		InitialValue=""
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UserHandle"
		Visible=true
		Group="Behavior"
		InitialValue=""
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
#tag EndViewBehavior
