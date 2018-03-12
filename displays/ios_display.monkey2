Namespace screentools.displaytool
Internal

#Import "../display"

#If __TARGET__="ios"
#Import "<std>"
#Import "<sdl2>"

'#Import "../native/AndroidDisplayUtility.java"
#Import "../sdl_wrappers"
 
Using std..
Using sdl2..

Class IOSDisplay Extends Display
	
	Method New( displayIndex:Int = 0 )
'		_displayIndex=displayIndex
		
		Local wrapper:=New SDLWrap( displayIndex )
		_dpi=wrapper.GetDisplayDPI()
		
		' Get the IOS DPI if SDL failed
		If wrapper.failed 
		End
		
		Local displayMode:=wrapper.GetDisplayMode()
		_dimensions=New Vec2i( displayMode.w, displayMode.h )
		_refreshRate=displayMode.refresh_rate
		
		_name=wrapper.GetDisplayName()
		_bounds=wrapper.GetDisplayBounds()
		
	End
End

#Else

Class IOSDisplay Extends Display	
End

#End