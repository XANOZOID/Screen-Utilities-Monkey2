Namespace screentools.tests

#Import "<std>"
#Import "<mojo>"

#Import "../screen_tools"

Using std..
Using mojo..
Using screentools..

Class DisplayTest Extends Window
'	Field display:Display
	Field displayStats:String

	Method New( title:String="Simple mojo app",width:Int=640,height:Int=480,flags:WindowFlags=Null )
		Super.New( title,width,height,flags )
	End
	
	Method OnCreateWindow() Override	
		Local display:=CreateCurrentDisplay()
		displayStats=""
		displayStats+="screen: " + display.Name						+ "~n"
		displayStats+="dimension: " + String(display.Dimensions)	+ "~n"
		displayStats+="DPI: " + String(display.DPI)					+ "~n"
		displayStats+="bounds: " + display.Bounds					+ "~n"
		displayStats+="refresh rate: " + display.RefreshRate	
		
		Print displayStats
	End

	Method OnRender( canvas:Canvas ) Override
		Local i:=0
		For Local strn:=Eachin displayStats.Split("~n")
			canvas.DrawText( strn, Width/2, i*35 + 100, 0.5, 1 ) ; i+=1
		Next
		
	End
	
End

Function Main()
	New AppInstance
	New DisplayTest
	App.Run()
End