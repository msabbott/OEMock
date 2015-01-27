/*------------------------------------------------------------------------
    File        : BaseMethod
    Purpose     : Base class to represent any ABL named code section
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.BaseMethod:
    
	DEFINE PUBLIC PROPERTY Name AS CHARACTER INITIAL ? NO-UNDO 
	GET.
	SET.
    
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

	DESTRUCTOR PUBLIC BaseMethod ( ):

	END DESTRUCTOR.
	
	METHOD PUBLIC LONGCHAR Generate():
	    RETURN "".
	END METHOD.
	
	METHOD PUBLIC LONGCHAR GenerateForward():
	    RETURN "".
	END METHOD.

END CLASS.