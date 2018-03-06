Namespace screentools.displaytool

#Import "<sdl2>"
#Import "<std>"
#Import "<libc>"
Using sdl2..
Using std..

Class Display
	
	Method New( displayIndex:Int = 1 )
		_displayIndex=displayIndex
		If SDL_GetDisplayDPI( _displayIndex, Varptr _ddpi, Varptr _dpiX, Varptr _dpiY ) < 0
			Print "Error, could not get display DPI"
		End
		
		If SDL_GetCurrentDisplayMode( _displayIndex, Varptr _displayMode ) < 0
			Print "Error, could not get current display mode."
		End
		
'		Const dname:=  ' PIPE "stdin" into "bufer"
	    _name=String.FromCString(SDL_GetDisplayName( _displayIndex )) ' Return Monkey String from 'Buffer'
		
		SDL_GetDisplayBounds( _displayIndex, Varptr _bounds )
	End
	
	
	Property Dimensions:Vec2i()
		Return New Vec2i( _displayMode.w, _displayMode.h )
	End
	
	Property DPI:Vec3f()
		Return New Vec3f( _dpiX, _dpiY, _ddpi )
	End

	Property Name:String()
		Return _name
	End
	
	Property Bounds:Recti()
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