Namespace screentools.displaytool
Internal

#Import "../display"

#If __TARGET__="android"
#Import "<std>"
#Import "<sdl2>"
#Import "<jni>"
#Import "../android_tools"

#Import "../native/AndroidDisplayUtility.java"
#Import "../sdl_wrappers"
 
Using std..
Using sdl2..
Using jni..
 


 
 Class AndroidWrapper
	Field env:=sdl2.Android_JNI_GetEnv()
	Field metricClass:jclass
	Field metric:jobject
	
	Method New()
		metric=GetMetricObject()
		metricClass=env.GetObjectClass( metric )
	End

	Property DPI:Vec3f()	
		Return New Vec3f( jDPI("x"), jDPI("y"), Null)
	End 
	
	Method Destroy()
		env.DeleteLocalRef(Cast<jni.jobject>( metricClass ))
		env.DeleteLocalRef(Cast<jni.jobject>( metric ))
	End
	
Private
	Method jDPI:Float( prop:String )
		Local id_dpi:=env.GetFieldID( metricClass, prop+"dpi", JNIType.JFloat.type )
		Return env.GetFloatField( metric, id_dpi )
	End
	
		
	Function GetMetricObject:jobject()
		Local env:=sdl2.Android_JNI_GetEnv()	
		Local cls:=env.FindClass( "com/monkey2/lib/AndroidDisplayUtility" )
		
		Local builder:=New JNIMethodBuilder
		builder.SetRet( JNIType.JObject("android/util/DisplayMetrics") )
		Local methodSig:=builder.Build()
		Local mth:=env.GetStaticMethodID( cls, "getMetrics", methodSig )	
		
		Local resp:=env.CallStaticObjectMethod( cls, mth, Null)
		env.DeleteLocalRef(Cast<jni.jobject>( cls ))
		Return resp
	End 

End


Class AndroidDisplay Extends Display
	
	Method New( displayIndex:Int = 0 )
'		_displayIndex=displayIndex
		
		Local awrap:=New AndroidWrapper
		
		Local wrapper:=New SDLWrap( displayIndex )
		_dpi=wrapper.GetDisplayDPI()
		
		' Get the Android DPI if SDL failed
		If wrapper.failed 
			_dpi=awrap.DPI
		End
		
		Local displayMode:=wrapper.GetDisplayMode()
		_dimensions=New Vec2i( displayMode.w, displayMode.h )
		_refreshRate=displayMode.refresh_rate
		
		_name=wrapper.GetDisplayName()
		_bounds=wrapper.GetDisplayBounds()
		
		' free memory from jni wrap
		awrap.Destroy()
	End
End

#Else

Class AndroidDisplay Extends Display	
End

#End