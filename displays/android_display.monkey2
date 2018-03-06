Namespace screentools.displaytool

#Import "../display"

#If __TARGET__="android"
#Import "<sdl2>"

#Import "native/DisplayUtility.java"
#Import "sdl_wrappers"
 
Using std..
Using sdl2..
 
 
#Rem monkeydocs Returns the vertical(true) or horizontal(false) DPI for Android. 
#End
Function GetDPI:Int( vertical:Bool )
	Local env:=sdl2.Android_JNI_GetEnv()	
	Local cls:=env.FindClass( "com/monkey2/lib/DisplayUtility" )
	Local mth:=env.GetStaticMethodID( cls, "getDPI", "(Z)I" )	
	Return env.CallStaticIntMethod( cls, mth, New Variant[]( vertical ) )
End 



Class AndroidDisplay Extends Display
	
	Method New( displayIndex:Int = 0 )
'		_displayIndex=displayIndex
		
		Local wrapper:=New SDLWrap( displayIndex )
		_dpi=wrapper.GetDisplayDPI()
		
		' Get the Android DPI if SDL failed
		If wrapper.failed 
			_dpi=New Vec3i( GetDPI(False), GetDPI(True), 0 )
		End
		
		Local displayMode:=wrapper.GetDisplayMode()
		_dimensions=New Vec2i( _displayMode.w, _displayMode.h )
		_refreshRate=displayMode.refresh_rate
		
		_name=wrapper.GetDisplayName()
		_bounds=wrapper.GetDisplayBounds()
	End
End

#Else

Class AndroidDisplay Extends Display	
End

#End