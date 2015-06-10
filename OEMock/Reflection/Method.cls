/*------------------------------------------------------------------------
    File        : Method
    Purpose     : Represents an ABL method 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.ReturningMethod.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.Method INHERITS ReturningMethod:
    
    
    
	DEFINE PUBLIC PROPERTY Abstract AS LOGICAL NO-UNDO INITIAL FALSE
	GET.
	SET(INPUT arg AS LOGICAL):
        IF arg = TRUE THEN
            THIS-OBJECT:Static = FALSE.
        THIS-OBJECT:Abstract = arg.
	END SET.
	
	DEFINE PUBLIC PROPERTY Final AS LOGICAL NO-UNDO INITIAL FALSE
	   GET.
	   SET.
    
    DEFINE PUBLIC PROPERTY Override AS LOGICAL NO-UNDO INITIAL FALSE
       GET.
       SET.

    DEFINE PUBLIC PROPERTY Static AS LOGICAL NO-UNDO INITIAL FALSE
    GET.
    SET(INPUT arg AS LOGICAL):
        IF arg = TRUE THEN
            THIS-OBJECT:Abstract = FALSE.
        THIS-OBJECT:Static = arg.
    END SET.
	 
    CONSTRUCTOR PUBLIC Method(INPUT nam AS CHARACTER):
        THIS-OBJECT(nam, "VOID").
    END CONSTRUCTOR.

    CONSTRUCTOR PUBLIC Method(INPUT nam AS CHARACTER, INPUT dType AS CHARACTER):
        SUPER(nam, dType).
    END CONSTRUCTOR.
    
    METHOD OVERRIDE PUBLIC LONGCHAR Generate():
        
        DEFINE VARIABLE meth AS LONGCHAR NO-UNDO.
        
        /* Name and return type must be set */
        IF TRIM(Name)        NE "" AND Name       NE ?   
        AND TRIM(ReturnType) NE "" AND ReturnType NE ? THEN
        DO:
            ASSIGN meth = "METHOD PUBLIC "
                        + (IF THIS-OBJECT:Abstract THEN "ABSTRACT " ELSE IF THIS-OBJECT:Static THEN "STATIC " ELSE "")
                        + (IF THIS-OBJECT:Override THEN "OVERRIDE " ELSE "")
                        + (IF THIS-OBJECT:Final    THEN "FINAL "    ELSE "")
                        + (IF ReturnType = ? OR TRIM(ReturnType) EQ "" THEN "VOID " ELSE ReturnType + " ")
                        + Name + " ("
                        + GenerateParameters() + "):" + CHR(13)
                        + Generators:Generate() + CHR(13) 
                        + "END METHOD." + CHR(13).              
        END.
        
        RETURN meth.
    END METHOD.

END CLASS.