/*------------------------------------------------------------------------
    File        : ProcedureGenerator
    Purpose     : Generator class for Procedures.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.BaseMethodGenerator.
USING OEMock.Reflection.Procedure.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.ProcedureGenerator INHERITS BaseMethodGenerator:
    
    DEFINE PROTECTED PROPERTY Procedure AS OEMock.Reflection.Procedure NO-UNDO
    GET.
    SET.
        
    CONSTRUCTOR PUBLIC ProcedureGenerator():
        SUPER().
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC ProcedureGenerator():

    END DESTRUCTOR.
    
    METHOD PUBLIC VOID AttachTo(INPUT proc AS OEMock.Reflection.Procedure):
        SUPER:AttachToBaseMethod(proc).
        THIS-OBJECT:Procedure = proc.
    END METHOD.

END CLASS.