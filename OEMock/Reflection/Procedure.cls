/*------------------------------------------------------------------------
    File        : Procedure
    Purpose     : Represents an ABL procedure.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseMethod.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.Procedure INHERITS BaseMethod: 

	CONSTRUCTOR PUBLIC Procedure():
		SUPER().
	END CONSTRUCTOR.
	
	CONSTRUCTOR PUBLIC Procedure(INPUT nam AS CHARACTER):
	    SUPER(nam).
	END CONSTRUCTOR.
	
	DESTRUCTOR Procedure():
	END DESTRUCTOR.
	
	METHOD OVERRIDE PUBLIC LONGCHAR Generate():
        
        DEFINE VARIABLE proc AS LONGCHAR NO-UNDO.
        
        /* Name and return type must be set */
        IF TRIM(Name) NE "" AND Name NE ? THEN
        DO:
            ASSIGN proc = SUBSTITUTE("PROCEDURE &1 :",
                                     Name).
                                     
            /* Generate parameter definitions */
            ASSIGN proc = SUBSTITUTE("&1&2",
                                     proc,
                                     GenerateParameters()).
                                     
            ASSIGN proc = SUBSTITUTE("&1&2&3&2",
                                     proc,
                                     CHR(10) + CHR(13),
                                     Generators:Generate()).
                                     
            ASSIGN proc = SUBSTITUTE("&1&2&3END PROCEDURE.",
                                     proc,
                                     CHR(10),
                                     CHR(13)).
        END.
        
        RETURN proc.
	END METHOD.
	
	METHOD OVERRIDE PROTECTED LONGCHAR GenerateParameters():
	    DEFINE VARIABLE params AS LONGCHAR NO-UNDO.
	    DEFINE VARIABLE parm   AS OEMock.Reflection.BaseParameter NO-UNDO.
	    
	    params = SUPER:GenerateParameters().

        /* Loop through parameters */
	    parm = Parameters:MoveFirst().
	    DO WHILE VALID-OBJECT(parm):
	       ASSIGN params = params + parm:GenerateDefinition().
	              parm   = Parameters:MoveNext().
	    END.
	    
	    RETURN params.
	    
	END METHOD.

END CLASS.