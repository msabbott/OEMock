/*------------------------------------------------------------------------
    File        : BaseNamedListTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Util.BaseNamedList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Util.BaseNamedListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS BaseNamedList NO-UNDO.
        list = NEW BaseNamedList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS BaseNamedList NO-UNDO.
        list = NEW BaseNamedList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID HasValueReturnsFalseWithBlankList():
        DEFINE VARIABLE list AS BaseNamedList NO-UNDO.
        list = NEW BaseNamedList().
        Assert:IsFalse(list:HasValue("Test Value")).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
END CLASS.