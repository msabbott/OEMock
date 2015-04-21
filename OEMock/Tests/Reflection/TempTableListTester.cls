/*------------------------------------------------------------------------
    File        : TempTableListTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.TempTableListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddTempTableIncrementsCounter():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        DEFINE VARIABLE drel AS TempTable NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        drel = NEW TempTable("TempTableName").
        list:AddTempTable(drel).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        list:AddTempTable(?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        DEFINE VARIABLE drel AS TempTable NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        drel = NEW TempTable("TempTableName").
        list:AddTempTable(drel).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        DEFINE VARIABLE drel AS TempTable NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        drel = NEW TempTable("TempTableName").
        list:AddTempTable(drel).
        Assert:IsNotNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        DEFINE VARIABLE drel AS TempTable NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        drel = NEW TempTable("TempTableName").
        Assert:IsNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        DEFINE VARIABLE ttab AS TempTable NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        ttab = NEW TempTable("TempTableName").
        list:AddTempTable(ttab).
        Assert:IsNotNull(list:MoveLast()).
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        DEFINE VARIABLE ttab AS TempTable NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        ttab = NEW TempTable("TempTableName").
        Assert:IsNull(list:MoveLast()).
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        DEFINE VARIABLE ttab AS TempTable NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        ttab = NEW TempTable("TempTableName").
        list:AddTempTable(ttab).
        Assert:IsNotNull(list:MoveNext()).
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        DEFINE VARIABLE ttab AS TempTable NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        ttab = NEW TempTable("TempTableName").
        Assert:IsNull(list:MoveNext()).
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextReturnsValidObjectsWithMultipleItemList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        DEFINE VARIABLE res  AS TempTable NO-UNDO.
        
        list = NEW OEMock.Reflection.TempTableList().
        list:AddTempTable(NEW TempTable('Relation1')).
        list:AddTempTable(NEW TempTable('Relation2')).
        list:AddTempTable(NEW TempTable('Relation3')).

        res = list:MoveFirst().
        AssertString:Contains(res:GetClass():TypeName, 'TempTable').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTable')).
        Assert:AreEqual(res:Name, "Relation1").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'TempTable').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTable')).
        Assert:AreEqual(res:Name, "Relation2").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'TempTable').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTable')).
        Assert:AreEqual(res:Name, "Relation3").
        
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        DEFINE VARIABLE ttab AS TempTable NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        ttab = NEW TempTable("TempTableName").
        list:AddTempTable(ttab).
        Assert:IsNotNull(list:MovePrev()).
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableList NO-UNDO.
        DEFINE VARIABLE ttab AS TempTable NO-UNDO.
        list = NEW OEMock.Reflection.TempTableList().
        ttab = NEW TempTable("TempTableName").
        Assert:IsNull(list:MovePrev()).
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.