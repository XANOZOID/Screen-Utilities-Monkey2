Namespace screentools.displaytool

#Import "<std>"

#Import "sdl_wrappers"

Using std..
Using sdlwrap..

#Rem monkeydoc Display class which has info about the display of a device. 
#End
Class Display
	
	#Rem monkeydoc Generic function which return a Display that is appropriate for the built target.
		@param displayIndex SDL DisplayIndex
		
	    @example
	    	Local display:Display.create()
	    	Local WidthInch:= display.Dimensions.x/display.DPI.x
	    @end
	#End
	Function Create:Display( displayIndex:Int=0 )
#If __TARGET__="android"
		Return New AndroidDisplay( displayIndex )
#End

		Return New DefaultDisplay( displayIndex )
	End
	
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




Class DefaultDisplay Extends Display
	Method New( displayIndex:Int = 0 )
'		_displayIndex=displayIndex
		
		Local wrapper:=New SDLWrap( displayIndex )
		_dpi=wrapper.GetDisplayDPI()
		
		Local displayMode:=wrapper.GetDisplayMode()
		_dimensions=New Vec2i( displayMode.w, displayMode.h )
		_refreshRate=displayMode.refresh_rate
		
		_name=wrapper.GetDisplayName()
		_bounds=wrapper.GetDisplayBounds()
	End
	
	
End
