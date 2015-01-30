/*------------------------------------------------------------------------
    File        : ParameterListTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.ParameterListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddParameterIncrementsCounter():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW BaseParameter().
        list:AddParameter(parm).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        list:AddParameter(?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW BaseParameter().
        list:AddParameter(parm).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW BaseParameter().
        list:AddParameter(parm).
        Assert:IsNotNull(list:MoveFirst()).
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW BaseParameter().
        Assert:IsNull(list:MoveFirst()).
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE res  AS BaseParameter NO-UNDO.
        
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        
        list:AddParameter(parm).
        res = list:MoveFirst().
        
        AssertString:Contains(res:GetClass():TypeName, 'PrimitiveParameter').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.PrimitiveParameter')).
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW BaseParameter().
        list:AddParameter(parm).
        Assert:IsNotNull(list:MoveLast()).
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW BaseParameter().
        Assert:IsNull(list:MoveLast()).
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE res  AS BaseParameter NO-UNDO.
        
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        
        list:AddParameter(parm).
        res = list:MoveLast().
        
        AssertString:Contains(res:GetClass():TypeName, 'PrimitiveParameter').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.PrimitiveParameter')).
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW BaseParameter().
        list:AddParameter(parm).
        Assert:IsNotNull(list:MoveNext()).
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW BaseParameter().
        Assert:IsNull(list:MoveNext()).
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE res  AS BaseParameter NO-UNDO.
        
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        
        list:AddParameter(parm).
        res = list:MoveNext().
        
        AssertString:Contains(res:GetClass():TypeName, 'PrimitiveParameter').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.PrimitiveParameter')).
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW BaseParameter().
        list:AddParameter(parm).
        Assert:IsNotNull(list:MovePrev()).
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW BaseParameter().
        Assert:IsNull(list:MovePrev()).
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Reflection.ParameterList NO-UNDO.
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE res  AS BaseParameter NO-UNDO.
        
        list = NEW OEMock.Reflection.ParameterList().
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        
        list:AddParameter(parm).
        res = list:MovePrev().
        
        AssertString:Contains(res:GetClass():TypeName, 'PrimitiveParameter').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.PrimitiveParameter')).
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.