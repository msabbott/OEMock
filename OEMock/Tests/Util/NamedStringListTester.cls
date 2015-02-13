/*------------------------------------------------------------------------
    File        : NamedStringListTester
    Purpose     : Unit tests for NamedStringList class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Util.NamedStringList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Util.NamedStringListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankNamedStringList():
        DEFINE VARIABLE list AS NamedStringList NO-UNDO.
        list = NEW NamedStringList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddValueIncrementsCounter():
        DEFINE VARIABLE list AS NamedStringList NO-UNDO.
        list = NEW NamedStringList().
        list:AddValue("Name 1", "String 1").
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddValueDoesNotIncrementCounterWhenValueNull():
        DEFINE VARIABLE list AS NamedStringList NO-UNDO.
        list = NEW NamedStringList().
        list:AddValue("Name 1", ?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddValueIgnoresBlankName():
        DEFINE VARIABLE list AS NamedStringList NO-UNDO.
        list = NEW NamedStringList().
        list:AddValue("", "String 1").
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddValueIgnoresNullName():
        DEFINE VARIABLE list AS NamedStringList NO-UNDO.
        list = NEW NamedStringList().
        list:AddValue(?, "String 1").
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    
    @Test.
    METHOD PUBLIC VOID EmptyNamedStringListClearsList():
        DEFINE VARIABLE list AS NamedStringList NO-UNDO.
        list = NEW NamedStringList().
        list:AddValue("Name 1", "String 1").
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetValueReturnsExpectedValue():
        DEFINE VARIABLE list AS NamedStringList NO-UNDO.
        list = NEW NamedStringList().
        list:AddValue("Name 1", "String 1").
        Assert:AreEqual(list:GetValue("Name 1"),"String 1").
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetValueReturnsNullWhenNotFound():
        DEFINE VARIABLE list AS NamedStringList NO-UNDO.
        list = NEW NamedStringList().
        list:AddValue("Name 1", "String 1").
        Assert:IsNull(list:GetValue("Name Not Added")).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID HasValueReturnsTrueWhenExists():
        DEFINE VARIABLE list AS NamedStringList NO-UNDO.
        list = NEW NamedStringList().
        list:AddValue("Name 1", "String 1").
        Assert:IsTrue(list:HasValue("Name 1")).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID HasValueReturnsFalseWhenNotExists():
        DEFINE VARIABLE list AS NamedStringList NO-UNDO.
        list = NEW NamedStringList().
        list:AddValue("Name 1", "String 1").
        Assert:IsFalse(list:HasValue("Name Not Added")).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    
END CLASS.