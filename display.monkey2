Namespace screentools.displaytool

#Import "<sdl2>"
#Import "<std>"

#Import "sdl_wrappers"

Using sdl2..
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
	
	Property Dimensions:Vec2i() Abstract
	
	Property DPI:Vec3f() Abstract

	Property Name:String() Abstract
	
	Property Bounds:Recti() Abstract
	
	Property RefreshRate:Int() Abstract
	
End




Class DefaultDisplay Extends Display
	
	Method New( displayIndex:Int = 0 )
		_displayIndex=displayIndex
		
		Local wrapper:=New SDLWrap( displayIndex )
		_dpi=wrapper.GetDisplayDPI()
		_displayMode=wrapper.GetDisplayMode()
		_name=wrapper.GetDisplayName()
		_bounds=wrapper.GetDisplayBounds()
	End
	
	
	Property Dimensions:Vec2i() Override
		Return New Vec2i( _displayMode.w, _displayMode.h )
	End
	
	Property DPI:Vec3f() Override
		Return _dpi
	End

	Property Name:String() Override
		Return _name
	End
	
	Property Bounds:Recti() Override
		Return _bounds
	End
	
	Property RefreshRate:Int() Override
		Return _displayMode.refresh_rate
	End
	
Private
	Field _bounds:Recti
	Field _dpi:Vec3f
	Field _displayIndex:Int 
	Field _displayMode:SDL_DisplayMode
	Field _name:String
	
End
