/*------------------------------------------------------------------------
    File        : ReturningMethod
    Purpose     : Represents an ABL code block that returns a value.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseMethod.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.ReturningMethod INHERITS BaseMethod:
    

	DEFINE PUBLIC PROPERTY ReturnType AS CHARACTER INITIAL ? NO-UNDO 
	GET.
	SET.

	CONSTRUCTOR PUBLIC ReturningMethod(INPUT dType AS CHARACTER):
		THIS-OBJECT(INPUT ?, INPUT dType).
	END CONSTRUCTOR.

    CONSTRUCTOR PUBLIC ReturningMethod(INPUT nam AS CHARACTER, INPUT dType AS CHARACTER):
        SUPER(nam).
        ReturnType = dType.
    END CONSTRUCTOR.
    
    
    METHOD OVERRIDE PROTECTED LONGCHAR GenerateParameters():
        DEFINE VARIABLE params AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE parm   AS OEMock.Reflection.BaseParameter NO-UNDO.
        
        params = SUPER:GenerateParameters().
  
        /* Loop through parameters */
        parm = Parameters:MoveFirst().
        DO WHILE VALID-OBJECT(parm):
           ASSIGN params = params + parm:Generate().
                  parm   = Parameters:MoveNext().
        END.
        
        /* Trim trailing comma from end of last parameter */
        ASSIGN params = TRIM(params, " ,").

        RETURN params.
        
    END METHOD.

END CLASS.