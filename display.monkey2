Namespace screentools.displaytool

#Import "<sdl2>"
#Import "<std>"
#Import "<libc>"
Using sdl2..
Using std..

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
End




Class DefaultDisplay Extends Display
	
	Method New( displayIndex:Int = 0 )
		_displayIndex=displayIndex
		If SDL_GetDisplayDPI( _displayIndex, Varptr _ddpi, Varptr _dpiX, Varptr _dpiY ) < 0
			Print "Error, could not get display DPI"
		End
		
		If SDL_GetCurrentDisplayMode( _displayIndex, Varptr _displayMode ) < 0
			Print "Error, could not get current display mode."
		End
		
	    _name=String.FromCString(SDL_GetDisplayName( _displayIndex )) ' Return Monkey String from 'Buffer'
		
		SDL_GetDisplayBounds( _displayIndex, Varptr _bounds )
	End
	
	
	Property Dimensions:Vec2i() Override
		Return New Vec2i( _displayMode.w, _displayMode.h )
	End
	
	Property DPI:Vec3f() Override
		Return New Vec3f( _dpiX, _dpiY, _ddpi )
	End

	Property Name:String() Override
		Return _name
	End
	
	Property Bounds:Recti() Override
		Return New Recti( _bounds.x, _bounds.y, _bounds.x + _bounds.w, _bounds.y + _bounds.h )
	End
	
Private
	Field _dpiX:Float
	Field _dpiY:Float
	Field _ddpi:Float
	Field _displayIndex:Int 
	Field _displayMode:SDL_DisplayMode
	Field _name:String
	Field _bounds:SDL_Rect
	
End


Class AndroidDisplay Extends Display
	
End