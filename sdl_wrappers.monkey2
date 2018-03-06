Namespace sdlwrap
#Import "<sdl2>"
#Import "<std>"
Using sdl2..
Using std..

Class SDLWrap
	Field displayIndex:Int
	
	Method New( displayIndex:Int )
		Self.displayIndex=displayIndex
	End
	
	Method GetDisplayDPI:Vec3f()
		Local ddpi:Float, dpiX:Float, dpiY:Float
		If SDL_GetDisplayDPI( displayIndex, Varptr ddpi, Varptr dpiX, Varptr dpiY ) < 0
	'		Print "Error, could not get display DPI."
			Return Null
		End
		Return New Vec3f( dpiX, dpiY, ddpi )
	End 
	
	Method GetDisplayMode:SDL_DisplayMode()
		Local displayMode:=New SDL_DisplayMode
		If SDL_GetCurrentDisplayMode( displayIndex, Varptr displayMode ) < 0
	'		Print "Error, could not get current display mode."
			Return Null
		End
		Return displayMode
	End
	
	Method GetDisplayName:String()
	    Return String.FromCString(SDL_GetDisplayName( displayIndex )) ' Return Monkey String from 'Buffer'
	End 
	
	Method GetDisplayBounds:Recti()
		Local bounds:SDL_Rect
		If SDL_GetDisplayBounds( displayIndex, Varptr bounds ) < 0 
	'		Print "Error, could not get display bounds."
			Return Null
		End
		Return New Recti( bounds.x, bounds.y, bounds.x + bounds.w, bounds.y + bounds.h )
	End
End