 /*------------------------------------------------------------------------
    File        : MethodGenerator
    Purpose     : Generator class for Methods.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.ReturningMethodGenerator.
USING OEMock.Reflection.Method.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.MethodGenerator INHERITS ReturningMethodGenerator: 
    
    DEFINE PRIVATE PROPERTY Procedure AS OEMock.Reflection.Method NO-UNDO
    GET.
    SET.
        
    CONSTRUCTOR PUBLIC MethodGenerator():
        SUPER().
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC MethodGenerator():

    END DESTRUCTOR.
    
    METHOD PUBLIC VOID AttachTo(INPUT meth AS OEMock.Reflection.Method):
        SUPER:AttachToReturningMethod(meth).
        THIS-OBJECT:Procedure = meth.
    END METHOD.

END CLASS.