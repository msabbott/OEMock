 /*------------------------------------------------------------------------
    File        : FunctionGenerator
    Purpose     : Generator class for Functions.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.ReturningMethodGenerator.
USING OEMock.Reflection.Function.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.FunctionGenerator INHERITS ReturningMethodGenerator: 
    
    DEFINE PROTECTED PROPERTY Function AS OEMock.Reflection.Function NO-UNDO
    GET.
    SET.
        
    CONSTRUCTOR PUBLIC FunctionGenerator():
        SUPER().
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC FunctionGenerator():

    END DESTRUCTOR.
    
    METHOD PUBLIC VOID AttachTo(INPUT func AS OEMock.Reflection.Function):
        SUPER:AttachToReturningMethod(func).
        THIS-OBJECT:Function = func.
    END METHOD.

END CLASS.