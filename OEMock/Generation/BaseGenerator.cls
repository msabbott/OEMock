 /*------------------------------------------------------------------------
    File        : BaseGenerator
    Purpose     : Defines base class for a code generator
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.BaseGenerator:
    
    CONSTRUCTOR BaseGenerator():
    END CONSTRUCTOR.
    
    METHOD PUBLIC LONGCHAR Generate():
        RETURN "".
    END METHOD.

END CLASS.