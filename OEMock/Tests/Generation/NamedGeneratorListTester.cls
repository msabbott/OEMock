/*------------------------------------------------------------------------
    File        : NamedGeneratorListTester
    Purpose     : Unit tests for NamedGeneratorList class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Generation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Generation.NamedGeneratorListTester: 
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS NamedGeneratorList NO-UNDO.
        list = NEW NamedGeneratorList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS NamedGeneratorList NO-UNDO.
        list = NEW NamedGeneratorList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID HasGeneratorReturnsFalseWithBlankList():
        DEFINE VARIABLE list AS NamedGeneratorList NO-UNDO.
        list = NEW NamedGeneratorList().
        Assert:IsFalse(list:HasGenerator("Test Value")).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID HasGeneratorReturnsTrueWhenInList():
        DEFINE VARIABLE list AS OEMock.Generation.NamedGeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.NamedGeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator("Name", gen).
        Assert:IsTrue(list:HasGenerator("Name")).
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID HasGeneratorReturnsFalseWhenNotInList():
        DEFINE VARIABLE list AS OEMock.Generation.NamedGeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.NamedGeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator("Name", gen).
        Assert:IsFalse(list:HasGenerator("Not In List")).
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddGeneratorIncrementsCounter():
        DEFINE VARIABLE list AS OEMock.Generation.NamedGeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.NamedGeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator("Name", gen).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS OEMock.Generation.NamedGeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.NamedGeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator("Name", gen).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetGeneratorReturnsSameObject():
        DEFINE VARIABLE list   AS OEMock.Generation.NamedGeneratorList NO-UNDO.
        DEFINE VARIABLE gen    AS BaseGenerator NO-UNDO.
        DEFINE VARIABLE retVal AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.NamedGeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator("Name", gen).
        retVal = list:GetGenerator("Name").
        Assert:AreEqual(retVal, gen).
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetGeneratorReturnsNullIfNotFound():
        DEFINE VARIABLE list   AS OEMock.Generation.NamedGeneratorList NO-UNDO.
        DEFINE VARIABLE gen    AS BaseGenerator NO-UNDO.
        DEFINE VARIABLE retVal AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.NamedGeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator("Name", gen).
        retVal = list:GetGenerator("Not In List").
        Assert:IsNull(retVal).
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.