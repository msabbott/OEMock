/*------------------------------------------------------------------------
    File        : DataSetRelationListTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.DataSetRelationListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddDataSetRelationIncrementsCounter():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        DEFINE VARIABLE drel AS DataSetRelation NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        drel = NEW DataSetRelation("Relation").
        list:AddDataSetRelation(drel).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        list:AddDataSetRelation(?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        DEFINE VARIABLE drel AS DataSetRelation NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        drel = NEW DataSetRelation("Relation").
        list:AddDataSetRelation(drel).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        DEFINE VARIABLE drel AS DataSetRelation NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        drel = NEW DataSetRelation("Relation").
        list:AddDataSetRelation(drel).
        Assert:IsNotNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        DEFINE VARIABLE drel AS DataSetRelation NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        drel = NEW DataSetRelation("Relation").
        Assert:IsNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        DEFINE VARIABLE meth AS DataSetRelation NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        meth = NEW DataSetRelation("Relation").
        list:AddDataSetRelation(meth).
        Assert:IsNotNull(list:MoveLast()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        DEFINE VARIABLE meth AS DataSetRelation NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        meth = NEW DataSetRelation("Relation").
        Assert:IsNull(list:MoveLast()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        DEFINE VARIABLE meth AS DataSetRelation NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        meth = NEW DataSetRelation("Relation").
        list:AddDataSetRelation(meth).
        Assert:IsNotNull(list:MoveNext()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        DEFINE VARIABLE meth AS DataSetRelation NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        meth = NEW DataSetRelation("Relation").
        Assert:IsNull(list:MoveNext()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextReturnsValidObjectsWithMultipleItemList():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        DEFINE VARIABLE res  AS DataSetRelation NO-UNDO.
        
        list = NEW OEMock.Reflection.DataSetRelationList().
        list:AddDataSetRelation(NEW DataSetRelation('Relation1')).
        list:AddDataSetRelation(NEW DataSetRelation('Relation2')).
        list:AddDataSetRelation(NEW DataSetRelation('Relation3')).

        res = list:MoveFirst().
        AssertString:Contains(res:GetClass():TypeName, 'DataSetRelation').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.DataSetRelation')).
        Assert:AreEqual(res:Name, "Relation1").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'DataSetRelation').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.DataSetRelation')).
        Assert:AreEqual(res:Name, "Relation2").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'DataSetRelation').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.DataSetRelation')).
        Assert:AreEqual(res:Name, "Relation3").
        
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        DEFINE VARIABLE meth AS DataSetRelation NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        meth = NEW DataSetRelation("Relation").
        list:AddDataSetRelation(meth).
        Assert:IsNotNull(list:MovePrev()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.DataSetRelationList NO-UNDO.
        DEFINE VARIABLE meth AS DataSetRelation NO-UNDO.
        list = NEW OEMock.Reflection.DataSetRelationList().
        meth = NEW DataSetRelation("Relation").
        Assert:IsNull(list:MovePrev()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.