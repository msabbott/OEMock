/*------------------------------------------------------------------------
    File        : TempTableIndexFieldListTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.TempTableIndexFieldListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddTempTableIndexFieldIncrementsCounter():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableIndexField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        drel = NEW TempTableIndexField("TempTableIndexFieldName").
        list:AddTempTableIndexField(drel).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        list:AddTempTableIndexField(?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableIndexField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        drel = NEW TempTableIndexField("TempTableIndexFieldName").
        list:AddTempTableIndexField(drel).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableIndexField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        drel = NEW TempTableIndexField("TempTableIndexFieldName").
        list:AddTempTableIndexField(drel).
        Assert:IsNotNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableIndexField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        drel = NEW TempTableIndexField("TempTableIndexFieldName").
        Assert:IsNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndexField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        fiel = NEW TempTableIndexField("TempTableIndexFieldName").
        list:AddTempTableIndexField(fiel).
        Assert:IsNotNull(list:MoveLast()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndexField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        fiel = NEW TempTableIndexField("TempTableIndexFieldName").
        Assert:IsNull(list:MoveLast()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndexField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        fiel = NEW TempTableIndexField("TempTableIndexFieldName").
        list:AddTempTableIndexField(fiel).
        Assert:IsNotNull(list:MoveNext()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndexField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        fiel = NEW TempTableIndexField("TempTableIndexFieldName").
        Assert:IsNull(list:MoveNext()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextReturnsValidObjectsWithMultipleItemList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        DEFINE VARIABLE res  AS TempTableIndexField NO-UNDO.
        
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        list:AddTempTableIndexField(NEW TempTableIndexField("Index1")).
        list:AddTempTableIndexField(NEW TempTableIndexField("Index2")).
        list:AddTempTableIndexField(NEW TempTableIndexField("Index3")).

        res = list:MoveFirst().
        AssertString:Contains(res:GetClass():TypeName, 'TempTableIndexField').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTableIndexField')).
        Assert:AreEqual(res:Name, "Index1").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'TempTableIndexField').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTableIndexField')).
        Assert:AreEqual(res:Name, "Index2").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'TempTableIndexField').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTableIndexField')).
        Assert:AreEqual(res:Name, "Index3").
        
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndexField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        fiel = NEW TempTableIndexField("TempTableIndexFieldName").
        list:AddTempTableIndexField(fiel).
        Assert:IsNotNull(list:MovePrev()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableIndexField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableIndexFieldList().
        fiel = NEW TempTableIndexField("TempTableIndexFieldName").
        Assert:IsNull(list:MovePrev()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.