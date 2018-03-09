Namespace screentools.androidtools

Class JNIMethodBuilder
	
	Method AddArg:JNIMethodBuilder( arg:JNIType )
		_arguments.Push( arg.type ) ; Return Self
	End
	
	Method SetRet:JNIMethodBuilder( arg:JNIType )
		_retType=arg.type ; Return Self
	End
	
	Method Build:String()
		Local params:= _arguments.Join("")
		Return "(" + params + ")" + _retType
	End
	
Private

	Field _arguments:=New StringStack
	Field _retType:String
	
End

Struct JNIType 
	Field type:=""
	Const JBool:=	New JNIType("Z")
	Const JByte:=	New JNIType("B")
	Const JChar:=	New JNIType("C")
	Const JShort:=	New JNIType("S")
	Const JInt:=	New JNIType("I")
	Const JLong:=	New JNIType("J")
	Const JFloat:=	New JNIType("F")
	Const JDouble:=	New JNIType("D")
	Const JVoid:=	New JNIType("V")
	Function JObject:JNIType( path:String )
		Return New JNIType( "L" + path + ";" )
	End
	Function jArray:JNIType( type:JNIType )
		Return New JNIType( "[" + type.type )
	End
	
Private
	Method New( str:String )
		type=str
	End
End