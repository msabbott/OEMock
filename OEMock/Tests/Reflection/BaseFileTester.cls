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
    METHOD PUBLIC VOID GenerateReturnsBlank():
        DEFINE VARIABLE fil AS BaseFile NO-UNDO.
        fil = NEW BaseFile('filename').
        
        Assert:AreEqual(fil:Generate(), '').
        
    END METHOD.

END CLASS.