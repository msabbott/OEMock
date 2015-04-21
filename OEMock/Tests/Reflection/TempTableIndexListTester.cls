/*------------------------------------------------------------------------
    File        : TempTableIndexListTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.TempTableIndexListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddTempTableIndexIncrementsCounter():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableIndex NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        drel = NEW TempTableIndex("TempTableIndexName").
        list:AddTempTableIndex(drel).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        list:AddTempTableIndex(?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableIndex NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        drel = NEW TempTableIndex("TempTableIndexName").
        list:AddTempTableIndex(drel).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableIndex NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        drel = NEW TempTableIndex("TempTableIndexName").
        list:AddTempTableIndex(drel).
        Assert:IsNotNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableIndex NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        drel = NEW TempTableIndex("TempTableIndexName").
        Assert:IsNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndex NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        fiel = NEW TempTableIndex("TempTableIndexName").
        list:AddTempTableIndex(fiel).
        Assert:IsNotNull(list:MoveLast()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndex NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        fiel = NEW TempTableIndex("TempTableIndexName").
        Assert:IsNull(list:MoveLast()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndex NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        fiel = NEW TempTableIndex("TempTableIndexName").
        list:AddTempTableIndex(fiel).
        Assert:IsNotNull(list:MoveNext()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndex NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        fiel = NEW TempTableIndex("TempTableIndexName").
        Assert:IsNull(list:MoveNext()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextReturnsValidObjectsWithMultipleItemList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        DEFINE VARIABLE res  AS TempTableIndex NO-UNDO.
        
        list = NEW OEMock.Reflection.TempTableIndexList().
        list:AddTempTableIndex(NEW TempTableIndex("Index1")).
        list:AddTempTableIndex(NEW TempTableIndex("Index2")).
        list:AddTempTableIndex(NEW TempTableIndex("Index3")).

        res = list:MoveFirst().
        AssertString:Contains(res:GetClass():TypeName, 'TempTableIndex').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTableIndex')).
        Assert:AreEqual(res:Name, "Index1").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'TempTableIndex').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTableIndex')).
        Assert:AreEqual(res:Name, "Index2").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'TempTableIndex').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTableIndex')).
        Assert:AreEqual(res:Name, "Index3").
        
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndex NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        fiel = NEW TempTableIndex("TempTableIndexName").
        list:AddTempTableIndex(fiel).
        Assert:IsNotNull(list:MovePrev()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndex NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexList().
        fiel = NEW TempTableIndex("TempTableIndexName").
        Assert:IsNull(list:MovePrev()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.