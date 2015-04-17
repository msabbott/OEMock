/*------------------------------------------------------------------------
    File        : BaseFileTester
    Purpose     : Unit tests for BaseFile class 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.BaseFileTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsFileName():
        DEFINE VARIABLE fil AS BaseFile NO-UNDO.
        fil = NEW BaseFile('filename').
        
        Assert:AreEqual(fil:FileName, 'filename').
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesUsingList():
        DEFINE VARIABLE fil AS BaseFile NO-UNDO.
        fil = NEW BaseFile('filename').
        
        Assert:IsTrue(VALID-OBJECT(fil:UsingList)).
        
        IF VALID-OBJECT(fil) THEN DELETE OBJECT fil.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesTempTableList():
        DEFINE VARIABLE fil AS BaseFile NO-UNDO.
        fil = NEW BaseFile('filename').
        
        Assert:IsTrue(VALID-OBJECT(fil:TempTables)).
        
        IF VALID-OBJECT(fil) THEN DELETE OBJECT fil.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlank():
        DEFINE VARIABLE fil AS BaseFile NO-UNDO.
        fil = NEW BaseFile('filename').
        
        Assert:AreEqual(fil:Generate(), '').
        
    END METHOD.

END CLASS.