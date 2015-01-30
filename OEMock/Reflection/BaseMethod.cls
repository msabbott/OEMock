/*------------------------------------------------------------------------
    File        : BaseMethod
    Purpose     : Base class to represent any ABL named code section
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseParameter.
USING OEMock.Reflection.ParameterList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.BaseMethod:
    
	DEFINE PUBLIC PROPERTY Name AS CHARACTER INITIAL ? NO-UNDO 
	GET.
	SET.
	
	DEFINE PUBLIC PROPERTY Parameters AS OEMock.Reflection.ParameterList NO-UNDO
	GET.
	PROTECTED SET.

    DEFINE PUBLIC PROPERTY RequireForward AS LOGICAL INITIAL FALSE NO-UNDO 
    GET.
    PROTECTED SET.
    
    CONSTRUCTOR PUBLIC BaseMethod():
        THIS-OBJECT(?).
    END CONSTRUCTOR.

	CONSTRUCTOR PUBLIC BaseMethod (INPUT nam AS CHARACTER):
	    SUPER().
	    NAME = nam.
	    Parameters = NEW OEMock.Reflection.ParameterList().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC BaseMethod():
	    IF VALID-OBJECT(Parameters) THEN DELETE OBJECT Parameters.
	END DESTRUCTOR.
	
	METHOD PUBLIC LONGCHAR Generate():
	    RETURN "".
	END METHOD.
	
	METHOD PUBLIC LONGCHAR GenerateForward():
	    RETURN "".
	END METHOD.
	
	METHOD PROTECTED LONGCHAR GenerateParameters():
	    RETURN "".
	END METHOD. 
	
END CLASS.