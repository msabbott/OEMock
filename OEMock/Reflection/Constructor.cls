/*------------------------------------------------------------------------
    File        : Constructor
    Purpose     : Represents an ABL Constructor.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseMethod.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.Constructor INHERITS BaseMethod: 

	CONSTRUCTOR PUBLIC Constructor():
		SUPER().
	END CONSTRUCTOR.
	
	CONSTRUCTOR PUBLIC Constructor(INPUT nam AS CHARACTER):
	    SUPER(nam).
	END CONSTRUCTOR.
	
	DESTRUCTOR Constructor():
	END DESTRUCTOR.
	
	METHOD OVERRIDE PUBLIC LONGCHAR Generate():
        
        DEFINE VARIABLE constr AS LONGCHAR NO-UNDO.
        
        /* Name and return type must be set */
        IF TRIM(Name) NE "" AND Name NE ? THEN
        DO:
            ASSIGN constr = SUBSTITUTE("CONSTRUCTOR &1 (&2):",
                                       Name,
                                       GenerateParameters()).
                                     
            ASSIGN constr = SUBSTITUTE("&1&2END CONSTRUCTOR.",
                                       constr,
                                       CHR(13)).
        END.
        
        RETURN constr.
	END METHOD.
	
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