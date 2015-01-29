/*------------------------------------------------------------------------
    File        : BaseMethod
    Purpose     : Base class to represent any ABL named code section
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseParameter.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.BaseMethod:
    
    DEFINE PROTECTED TEMP-TABLE ttParameter NO-UNDO
        FIELD Order AS INTEGER
        FIELD Item  AS Progress.Lang.Object
            INDEX OrderKey IS PRIMARY UNIQUE Order.
    
	DEFINE PUBLIC PROPERTY Name AS CHARACTER INITIAL ? NO-UNDO 
	GET.
	SET.
	
	DEFINE PUBLIC PROPERTY ParameterCount AS INTEGER NO-UNDO 
	GET():
	    DEFINE VARIABLE count AS INTEGER NO-UNDO.
		FOR EACH ttParameter NO-LOCK:
		    ASSIGN count = count + 1.
		END.
		RETURN count.
	END GET.

    DEFINE PUBLIC PROPERTY RequireForward AS LOGICAL INITIAL FALSE NO-UNDO 
    GET.
    PROTECTED SET.
    
    CONSTRUCTOR PUBLIC BaseMethod():
        THIS-OBJECT(?).
    END CONSTRUCTOR.

	CONSTRUCTOR PUBLIC BaseMethod (INPUT nam AS CHARACTER):
	    SUPER().
	    NAME = nam.
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC BaseMethod():
	    DEFINE VARIABLE parm AS OEMock.Reflection.BaseParameter NO-UNDO.
	    
        /* Destory parameter objects */
        FOR EACH ttParameter EXCLUSIVE-LOCK:
            parm = DYNAMIC-CAST(ttParameter.Item, ttParameter.Item:GetClass():TypeName).
            IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        END.
	END DESTRUCTOR.
	
	METHOD PUBLIC LONGCHAR Generate():
	    RETURN "".
	END METHOD.
	
	METHOD PUBLIC LONGCHAR GenerateForward():
	    RETURN "".
	END METHOD.
	
	METHOD PUBLIC VOID AddParameter(INPUT parm AS OEMock.Reflection.BaseParameter):
	    DEFINE VARIABLE ord AS INTEGER NO-UNDO INITIAL 0.
	    
	    FOR EACH ttParameter NO-LOCK:
	        ASSIGN ord = MAXIMUM(ord, ttParameter.Order).
	    END.
	    
        CREATE ttParameter.
        ASSIGN ttParameter.Order = ord
               ttParameter.Item  = parm.
	END METHOD.
	
	METHOD PROTECTED LONGCHAR GenerateParameters():
	    RETURN "".
	END METHOD. 
	
END CLASS.