Namespace screentools.displaytool

#Import "<std>"

#Import "sdl_wrappers"

Using std..

#Rem monkeydoc Display class which has info about the display of a device. 
#End
Class Display

	Property Dimensions:Vec2i()
		Return _dimensions
	End
	
	Property DPI:Vec3f()
		Return _dpi
	End
	
	Property Name:String()
		Return _name
	End
	
	Property Bounds:Recti()
		Return _bounds
	End
	
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




