Namespace screentools.displaytool
Internal

#Import "../display"


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