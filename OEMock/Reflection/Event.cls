/*------------------------------------------------------------------------
    File        : Event
    Purpose     : Represents an event in a class 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.ParameterList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.Event: 

    DEFINE PUBLIC PROPERTY Name AS CHARACTER INITIAL ? NO-UNDO 
    GET.
    SET.
    
    DEFINE PUBLIC PROPERTY Parameters AS OEMock.Reflection.ParameterList NO-UNDO
    GET.
    PROTECTED SET.
    
    DEFINE PUBLIC PROPERTY Abstract AS LOGICAL NO-UNDO INITIAL FALSE
    GET.
    SET(INPUT arg AS LOGICAL):
        IF arg = TRUE THEN
            THIS-OBJECT:Static = FALSE.
        THIS-OBJECT:Abstract = arg.
    END SET.
    
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
		
	CONSTRUCTOR PUBLIC Event(INPUT nam AS CHARACTER):
        SUPER().
        
        ASSIGN Name     = nam
               Abstract = FALSE
               Static   = FALSE
               Override = FALSE.
        
        /* Create objects */
        ASSIGN Parameters = NEW OEMock.Reflection.ParameterList().
	END CONSTRUCTOR.
	
	METHOD PUBLIC LONGCHAR Generate():
	    DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
	    
	    res = "DEFINE PUBLIC "
            + (IF THIS-OBJECT:Abstract THEN "ABSTRACT " ELSE IF THIS-OBJECT:Static THEN "STATIC " ELSE "")
            + (IF THIS-OBJECT:Override THEN "OVERRIDE " ELSE "")
            + "EVENT " + Name
            + " SIGNATURE VOID (" + GenerateParameters()
            + ")." + "~n".
        
	    RETURN res.
	END METHOD.
	
	METHOD PROTECTED LONGCHAR GenerateParameters():
	    
	    DEFINE VARIABLE params AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE parm   AS OEMock.Reflection.BaseParameter NO-UNDO.
	    
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