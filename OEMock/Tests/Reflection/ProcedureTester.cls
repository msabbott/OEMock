/*------------------------------------------------------------------------
    File        : ProcedureTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.ProcedureTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        DEFINE VARIABLE meth AS Procedure NO-UNDO.
        
        meth = NEW Procedure('Procedure').
        
        Assert:AreEqual(meth:Name,'Procedure').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID DoesNotRequireForwardDeclaration():
        DEFINE VARIABLE meth AS Procedure NO-UNDO.
        
        meth = NEW Procedure('Procedure').
        
        Assert:AreEqual(meth:RequireForward,FALSE).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateForwardReturnsBlank():
        DEFINE VARIABLE meth AS Procedure NO-UNDO.
        
        meth = NEW Procedure('Procedure').
        
        Assert:AreEqual(meth:GenerateForward(), '').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesValidProcedure():
        DEFINE VARIABLE meth AS Procedure NO-UNDO.
        
        meth = NEW Procedure('ProcName').
        
        Assert:AreEqual(meth:Generate(), 'PROCEDURE ProcName :' + CHR(10) + CHR(13) + "END PROCEDURE.").
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.

END CLASS.