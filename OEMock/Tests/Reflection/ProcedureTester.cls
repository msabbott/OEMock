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
    
    @Test.
    METHOD PUBLIC VOID GenereateIncludesParameters():
        DEFINE VARIABLE meth AS Procedure NO-UNDO.
        DEFINE VARIABLE parm1 AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE parm2 AS PrimitiveParameter NO-UNDO.
        
        meth  = NEW Procedure('ProcName').
        parm1 = NEW PrimitiveParameter('Param1', 'CHARACTER').
        parm2 = NEW PrimitiveParameter('Param2', 'CHARACTER').
        
        meth:Parameters:AddParameter(parm1).
        meth:Parameters:AddParameter(parm2).
        Assert:AreEqual(meth:Parameters:Count, 2).
        
        Assert:AreEqual(meth:Generate(), 'PROCEDURE ProcName :'
                                         + CHR(10) + CHR(13) + "DEFINE INPUT PARAMETER Param1 AS CHARACTER NO-UNDO."
                                         + CHR(10) + CHR(13) + "DEFINE INPUT PARAMETER Param2 AS CHARACTER NO-UNDO."
                                         + CHR(10) + CHR(13) + "END PROCEDURE.").

        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.

END CLASS.