Namespace screentools
#Import "display"
#Import "displays/android_display"
#Import "displays/default_display"


#Rem monkeydoc Use this function to grab a usable Display instance.
	This function will generate the correct type of Display information you need
	depending on the current export target. 
	- Currently Android has been tested to require additional fallbacks
	 past SDL's own features. 
	
	@param displayIndex SDL DisplayIndex
	
    @example
    	Local display:Display.create()
    	Local WidthInch:= display.Dimensions.x/display.DPI.x
    @end
#End
Function CreateCurrentDisplay:Display( displayIndex:Int=0 )
#If __TARGET__="android"
	Return New AndroidDisplay( displayIndex )
#End

	Return New DefaultDisplay( displayIndex )
End
