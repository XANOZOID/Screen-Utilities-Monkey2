Namespace screentools.displaytool
Internal

#Import "../display"

#If __TARGET__="ios"
#Import "<std>"
#Import "<sdl2>"

#Import "../native/IOSDisplayUtility.mm"
#Import "../native/IOSDisplayUtility.h"
#Import "../sdl_wrappers"

Using std..
Using sdl2..

Extern

Function IOSDeviceName:String()="IOSDeviceName"

Public

' Implementation translated from https://github.com/marchv/UIScreenExtension/blob/master/UIScreenExtension/UIScreenExtension.swift
Function IOSDPI:Vec3f()
	Local dpi:= -1
	
	Local model:=IOSDeviceName()
	Select model
        Case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4" ' iPad 2
            dpi=132
            
        Case "iPad2,5", "iPad2,6", "iPad2,7"            ' iPad Mini
            dpi=163
        
        case "iPad3,1", "iPad3,2", "iPad3,3",           ' iPad 3rd generation
	        "iPad3,4", "iPad3,5", "iPad3,6",            ' iPad 4th generation
	        "iPad4,1", "iPad4,2", "iPad4,3",            ' iPad Air
	        "iPad5,3", "iPad5,4",                       ' iPad Air 2
	        "iPad6,7", "iPad6,8",                       ' iPad Pro (12.9 inch)
	        "iPad6,3", "iPad6,4",                       ' iPad Pro (9.7 inch)
	        "iPad6,11", "iPad6,12",                     ' iPad 5th generation
	        "iPad7,1", "iPad7,2",                       ' iPad Pro (12.9 inch, 2nd generation)
	        "iPad7,3", "iPad7,4"                       	' iPad Pro (10.5 inch)
            dpi=264
            
        case "iPhone4,1",
	        "iPhone5,1", "iPhone5,2",                   ' iPhone 5
        	"iPhone5,3", "iPhone5,4",                   ' iPhone 5C
         	"iPhone6,1", "iPhone6,2",                  	' iPhone 5S
         	"iPhone8,4",                               	' iPhone SE
         	"iPhone7,2",                               	' iPhone 6
         	"iPhone8,1",                               	' iPhone 6S
         	"iPhone9,1", "iPhone9,3",                  	' iPhone 7
         	"iPhone10,1", "iPhone10,4",                	' iPhone 8
         	"iPod5,1",                                 	' iPod Touch 5th generation
         	"iPod7,1",                                 	' iPod Touch 6th generation
         	"iPad4,4", "iPad4,5", "iPad4,6",           	' iPad Mini 2
         	"iPad4,7", "iPad4,8", "iPad4,9",           	' iPad Mini 3
         	"iPad5,1", "iPad5,2"                      	' iPad Mini 4
            dpi=326
            
        Case "iPhone7,1",                              	' iPhone 6 Plus
	        "iPhone8,2",                              	' iPhone 6S Plus
	        "iPhone9,2", "iPhone9,4",                 	' iPhone 7 Plus
	        "iPhone10,2", "iPhone10,5"               	' iPhone 8 Plus
            dpi=401
            
        Case "iPhone10,3", "iPhone10,6"             	' iPhone X
            dpi=458
    End
    
    Return New Vec3f(dpi)
End
 

Class IOSDisplay Extends Display
	
	Method New( displayIndex:Int = 0 )
'		_displayIndex=displayIndex
		
		Local wrapper:=New SDLWrap( displayIndex )
		_dpi=wrapper.GetDisplayDPI()
		
		' Get the IOS DPI if SDL failed
		If wrapper.failed 
			_dpi=IOSDPI()
			Print " DPI FAILED (retrying): device name is: " + IOSDeviceName()	
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