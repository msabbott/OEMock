 /*------------------------------------------------------------------------
    File        : BaseParameter
    Purpose     : Base class for a parameter 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.BaseParameter: 
    
	DEFINE PUBLIC PROPERTY Name AS CHARACTER NO-UNDO INITIAL "" 
	GET.
	SET. 

	CONSTRUCTOR PUBLIC BaseParameter():
		THIS-OBJECT("").
	END CONSTRUCTOR.
	
	CONSTRUCTOR PUBLIC BaseParameter(INPUT nam AS CHARACTER):
	    SUPER().
	    ASSIGN Name = nam.
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC BaseParameter():

	END DESTRUCTOR.
	
	METHOD PUBLIC CHARACTER GenerateDefinition():
	    RETURN "".
	END METHOD.
	
	METHOD PUBLIC CHARACTER Generate():
	    RETURN "".
	END METHOD.
	
	METHOD PUBLIC CHARACTER Normalise():
	    RETURN "".
	END METHOD.

END CLASS.