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
		
		_dpi=GetDisplayDPI( _displayIndex )
		_displayMode=GetDisplayMode( _displayIndex )
		_name=GetDisplayName( _displayIndex )
		_bounds=GetDisplayBounds( _displayIndex )
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
	
Private
	Field _bounds:Recti
	Field _dpi:Vec3f
	Field _displayIndex:Int 
	Field _displayMode:SDL_DisplayMode
	Field _name:String
	
End


Class AndroidDisplay Extends Display
	
End




Private
Function GetDisplayDPI:Vec3f( displayIndex:Int )
	Local ddpi:Float, dpiX:Float, dpiY:Float
	If SDL_GetDisplayDPI( displayIndex, Varptr ddpi, Varptr dpiX, Varptr dpiY ) < 0
'		Print "Error, could not get display DPI."
		Return Null
	End
	Return New Vec3f( dpiX, dpiY, ddpi )
End 

Function GetDisplayMode:SDL_DisplayMode( displayIndex:Int )
	Local displayMode:=New SDL_DisplayMode
	If SDL_GetCurrentDisplayMode( displayIndex, Varptr displayMode ) < 0
'		Print "Error, could not get current display mode."
		Return Null
	End
	Return displayMode
End

Function GetDisplayName:String( displayIndex:Int )
    Return String.FromCString(SDL_GetDisplayName( displayIndex )) ' Return Monkey String from 'Buffer'
End 

Function GetDisplayBounds:Recti( displayIndex:Int )
	Local bounds:SDL_Rect
	If SDL_GetDisplayBounds( displayIndex, Varptr bounds ) < 0 
'		Print "Error, could not get display bounds."
		Return Null
	End
	Return New Recti( bounds.x, bounds.y, bounds.x + bounds.w, bounds.y + bounds.h )
End