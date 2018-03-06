Namespace screentools
#Import "display"
#Import "displays/android_display"
#Import "displays/default_display"


#Rem monkeydoc Generic function which return a Display that is appropriate for the built target.
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
