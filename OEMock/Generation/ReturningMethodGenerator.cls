/*------------------------------------------------------------------------
    File        : ReturningMethodGenerator
    Purpose     : Base class for a generator for a method that returns a
                  value. 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.BaseMethodGenerator.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.ReturningMethodGenerator INHERITS BaseMethodGenerator:

    DEFINE PRIVATE VARIABLE ReturnValue    AS CHARACTER NO-UNDO INITIAL ?.
    DEFINE PRIVATE VARIABLE UseReturnValue AS LOGICAL   NO-UNDO INITIAL FALSE.
    
    DEFINE PRIVATE PROPERTY ReturningMethod AS OEMock.Reflection.ReturningMethod NO-UNDO
    GET.
    SET.
    
	CONSTRUCTOR PUBLIC ReturningMethodGenerator():
		SUPER().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC ReturningMethodGenerator():

	END DESTRUCTOR.
    
    METHOD PUBLIC VOID AttachToReturningMethod(INPUT meth AS OEMock.Reflection.ReturningMethod):
        SUPER:AttachToBaseMethod(meth).
        ReturningMethod = meth.
    END METHOD.
	
	METHOD OVERRIDE PROTECTED LONGCHAR GenerateVariableDefinitions():
	    DEFINE VARIABLE res AS LONGCHAR NO-UNDO.

	    IF VALID-OBJECT(ReturningMethod) 
        AND THIS-OBJECT:ReturningMethod:ReturnType NE ? 
        AND THIS-OBJECT:ReturningMethod:ReturnType NE "" THEN
        DO:
            ASSIGN res = SUBSTITUTE("DEFINE VARIABLE res AS &1 NO-UNDO.",
                                    TRIM(THIS-OBJECT:ReturningMethod:ReturnType)).
        END.
	    
	    IF res = ? THEN res = "".
	    
	    RETURN res.
	END METHOD.
    
    METHOD OVERRIDE PUBLIC LONGCHAR Generate():
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
        
        ASSIGN res = SUBSTITUTE("&1&2&1&3&1RETURN &4.&1",
                                CHR(10) + CHR(13),
                                SUPER:Generate(),
                                (IF UseReturnValue THEN SUBSTITUTE("ASSIGN res = &1.", ReturnValue) ELSE ""),
                                (IF VALID-OBJECT(ReturningMethod) 
                                 AND THIS-OBJECT:ReturningMethod:ReturnType NE ? 
                                 AND THIS-OBJECT:ReturningMethod:ReturnType NE "" THEN "res" ELSE "")).
        
        IF res = ? THEN res = "".
        
        RETURN res.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC LONGCHAR GenerateProcedural():
        RETURN Generate().
    END METHOD.
    
    METHOD PUBLIC VOID SetReturnValue(INPUT retval AS CHARACTER):
        
        /* Format correct return value based on type */
        IF VALID-OBJECT(THIS-OBJECT:ReturningMethod)
        AND THIS-OBJECT:ReturningMethod:ReturnType NE "" 
        AND THIS-OBJECT:ReturningMethod:ReturnType NE ? THEN
        DO:
            /* Indicate ReturnValue has been set */
            CASE THIS-OBJECT:ReturningMethod:ReturnType:
                
                WHEN "CHARACTER" OR WHEN "LONGCHAR" THEN
                DO:
                    IF NOT (retval MATCHES ("'*'") OR retval MATCHES ('"*"')) AND retval NE ? THEN
                    DO:
                        retval = SUBSTITUTE('"&1"', retval).
                    END.
                END.
            END CASE.

            ASSIGN UseReturnValue = TRUE
                   ReturnValue    = retval.
        END.       
    END METHOD.

END CLASS.