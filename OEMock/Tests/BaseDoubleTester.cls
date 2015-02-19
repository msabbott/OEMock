/*------------------------------------------------------------------------
    File        : BaseDoubleTester
    Purpose     : Unit test for BaseDouble class. 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.BaseDouble.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.BaseDoubleTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsFile():
        DEFINE VARIABLE dbl AS BaseDouble NO-UNDO.
        DEFINE VARIABLE fil AS ClassFile  NO-UNDO.
        
        fil = NEW ClassFile('OEMock/Tests/Util/ListObject.cls', 'OEMock.Tests.Util.ListObject').
        dbl = NEW BaseDouble(fil).
        
        Assert:IsTrue(VALID-OBJECT(dbl:File)).
        Assert:AreEqual(dbl:File, fil).
        
        IF VALID-OBJECT(fil) THEN DELETE OBJECT(fil).
        IF VALID-OBJECT(dbl) THEN DELETE OBJECT(dbl).
    END METHOD.

END CLASS.