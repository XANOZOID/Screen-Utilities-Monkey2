Namespace screentools.displaytool

#Import "<std>"

#Import "sdl_wrappers"

Using std..

#Rem monkeydoc Display class which has info about the display of a device. 
#End
Class Display

	#Rem monkeydoc Returns the dimensions of the screen in terms of pixels.
	#End
	Property Dimensions:Vec2i()
		Return _dimensions
	End
	
	#Rem monkeydoc Provides access to the DPI of the display.
	#End
	Property DPI:Vec3f()
		Return _dpi
	End
	
	#Rem monkeydoc Name of the display type. Example: "Generic PnP Monitor"
	#End
	Property Name:String()
		Return _name
	End
	
	#Rem monkeydoc Get the boundaries of the display.
	#End
	Property Bounds:Recti()
		Return _bounds
	End
	
	#Rem monkeydoc The refresh rate of the screen. 
	#End
	Property RefreshRate:Int()
		Return _refreshRate
	End
	
Protected
	Field _bounds:Recti
	Field _dpi:Vec3f
	Field _name:String
	Field _dimensions:Vec2i
	Field _refreshRate:Int
	
End




