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
            ASSIGN meth = SUBSTITUTE("METHOD PUBLIC &1 &2 (&3):",
                                     ReturnType,
                                     Name,
                                     GenerateParameters()).
                                     
            ASSIGN meth = SUBSTITUTE("&1&2&3END METHOD.",
                                     meth,
                                     CHR(10),
                                     CHR(13)).
        END.
        
        RETURN meth.
    END METHOD.

END CLASS.