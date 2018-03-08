Namespace screentools.displaytool
Internal

#Import "../display"

#If __TARGET__="android"
#Import "<std>"
#Import "<sdl2>"

#Import "../native/AndroidDisplayUtility.java"
#Import "../sdl_wrappers"
 
Using std..
Using sdl2..
 
 
#Rem monkeydocs Returns the vertical(true) or horizontal(false) DPI for Android. 
#End
Function GetDPI:Float( vertical:Bool )
	Local env:=sdl2.Android_JNI_GetEnv()	
	Const cls:=env.FindClass( "com/monkey2/lib/AndroidDisplayUtility" )
	Const mth:=env.GetStaticMethodID( cls, "getDPI", "(Z)F" )	
	Return env.CallStaticFloatMethod( cls, mth, New Variant[]( vertical ) )
End 



Class AndroidDisplay Extends Display
	
	Method New( displayIndex:Int = 0 )
'		_displayIndex=displayIndex
		
		Local wrapper:=New SDLWrap( displayIndex )
		_dpi=wrapper.GetDisplayDPI()
		
		' Get the Android DPI if SDL failed
		If wrapper.failed 
			_dpi=New Vec3f( GetDPI(False), GetDPI(True), 0 )
		End
		
		Local displayMode:=wrapper.GetDisplayMode()
		_dimensions=New Vec2i( displayMode.w, displayMode.h )
		_refreshRate=displayMode.refresh_rate
		
		_name=wrapper.GetDisplayName()
		_bounds=wrapper.GetDisplayBounds()
	End
End

#Else

Class AndroidDisplay Extends Display	
End

#End