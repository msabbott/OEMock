/*------------------------------------------------------------------------
    File        : TempTableFieldListTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.TempTableFieldListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddTempTableFieldIncrementsCounter():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        drel = NEW TempTableField("TempTableFieldName", "CHARACTER").
        list:AddTempTableField(drel).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        list:AddTempTableField(?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        drel = NEW TempTableField("TempTableFieldName", "CHARACTER").
        list:AddTempTableField(drel).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        drel = NEW TempTableField("TempTableFieldName", "CHARACTER").
        list:AddTempTableField(drel).
        Assert:IsNotNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        DEFINE VARIABLE drel AS TempTableField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        drel = NEW TempTableField("TempTableFieldName", "CHARACTER").
        Assert:IsNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        fiel = NEW TempTableField("TempTableFieldName", "CHARACTER").
        list:AddTempTableField(fiel).
        Assert:IsNotNull(list:MoveLast()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        fiel = NEW TempTableField("TempTableFieldName", "CHARACTER").
        Assert:IsNull(list:MoveLast()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        fiel = NEW TempTableField("TempTableFieldName", "CHARACTER").
        list:AddTempTableField(fiel).
        Assert:IsNotNull(list:MoveNext()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        fiel = NEW TempTableField("TempTableFieldName", "CHARACTER").
        Assert:IsNull(list:MoveNext()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextReturnsValidObjectsWithMultipleItemList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        DEFINE VARIABLE res  AS TempTableField NO-UNDO.
        
        list = NEW OEMock.Reflection.TempTableFieldList().
        list:AddTempTableField(NEW TempTableField("Field1", "CHARACTER")).
        list:AddTempTableField(NEW TempTableField("Field2", "CHARACTER")).
        list:AddTempTableField(NEW TempTableField("Field3", "CHARACTER")).

        res = list:MoveFirst().
        AssertString:Contains(res:GetClass():TypeName, 'TempTableField').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTableField')).
        Assert:AreEqual(res:Name, "Field1").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'TempTableField').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTableField')).
        Assert:AreEqual(res:Name, "Field2").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'TempTableField').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.TempTableField')).
        Assert:AreEqual(res:Name, "Field3").
        
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        fiel = NEW TempTableField("TempTableFieldName", "CHARACTER").
        list:AddTempTableField(fiel).
        Assert:IsNotNull(list:MovePrev()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.TempTableFieldList NO-UNDO.
        DEFINE VARIABLE fiel AS TempTableField NO-UNDO.
        list = NEW OEMock.Reflection.TempTableFieldList().
        fiel = NEW TempTableField("TempTableFieldName", "CHARACTER").
        Assert:IsNull(list:MovePrev()).
        IF VALID-OBJECT(fiel) THEN DELETE OBJECT fiel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.