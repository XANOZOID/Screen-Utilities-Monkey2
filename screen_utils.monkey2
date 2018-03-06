#Import "sdl2"
#Import "std"
Using sdl2..
Using std..

Class Display
	
	Method New( displayIndex:Int = 0 )
		_displayIndex=displayIndex
		If SDL_GetDisplayDPI( _displayIndex, Varptr _ddpi, Varptr _dpiX, Varptr _dpiY ) < 0
			Print "Error, could not get display DPI"
		End
		
		If SDL_GetCurrentDisplayMode( _displayIndex, Varptr _displayMode ) < 0
			Print "Error, could not get current display mode."
		End
		
		_name= Cast<String>(SDL_GetDisplayName( _displayIndex ))
		
		SDL_GetDisplayBounds( _displayIndex, Varptr _bounds )
	End
	
	
	Property Dimensions:Vec2i()
		Return New Vec2i( _displayMode.w, _displayMode.h )
	End
	
	Property DPI:Vec3f()
		Return New Vec3f( _dpiX, _dpiY, _ddpi )
	End

	Property Name()
		Return _name
	End
	
	Property Bounds()
		Return New Rect( _bounds.x, _bounds.y, _bounds.x + _bounds.w, _bounds.y + _bounds.h )
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


Function Main()
	
	Print "test"
	
	Local dim:Dimension=(5)
	
	Print String(Int(dim))
	
	
End