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

END CLASS.