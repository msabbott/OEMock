/*------------------------------------------------------------------------
    File        : MethodListTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.MethodListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddMethodIncrementsCounter():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW BaseMethod().
        list:AddMethod(meth).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        list:AddMethod(?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW BaseMethod().
        list:AddMethod(meth).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW BaseMethod().
        list:AddMethod(meth).
        Assert:IsNotNull(list:MoveFirst()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW BaseMethod().
        Assert:IsNull(list:MoveFirst()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS Method NO-UNDO.
        DEFINE VARIABLE res  AS BaseMethod NO-UNDO.
        
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW Method('Method Name', 'CHARACTER').
        
        list:AddMethod(meth).
        res = list:MoveFirst().
        
        AssertString:Contains(res:GetClass():TypeName, 'Method').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.Method')).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW BaseMethod().
        list:AddMethod(meth).
        Assert:IsNotNull(list:MoveLast()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW BaseMethod().
        Assert:IsNull(list:MoveLast()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS Method NO-UNDO.
        DEFINE VARIABLE res  AS BaseMethod NO-UNDO.
        
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW Method('Method Name', 'CHARACTER').
        
        list:AddMethod(meth).
        res = list:MoveLast().
        
        AssertString:Contains(res:GetClass():TypeName, 'Method').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.Method')).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW BaseMethod().
        list:AddMethod(meth).
        Assert:IsNotNull(list:MoveNext()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW BaseMethod().
        Assert:IsNull(list:MoveNext()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS Method NO-UNDO.
        DEFINE VARIABLE res  AS BaseMethod NO-UNDO.
        
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW Method('Method Name', 'CHARACTER').
        
        list:AddMethod(meth).
        res = list:MoveNext().
        
        AssertString:Contains(res:GetClass():TypeName, 'Method').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.Method')).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextReturnsValidObjectsWithMultipleItemList():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE res  AS BaseMethod NO-UNDO.
        
        list = NEW OEMock.Reflection.MethodList().
        list:AddMethod(NEW Method('Param1', 'CHARACTER')).
        list:AddMethod(NEW Method('Param2', 'CHARACTER')).
        list:AddMethod(NEW Method('Param3', 'CHARACTER')).

        res = list:MoveFirst().
        AssertString:Contains(res:GetClass():TypeName, 'Method').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.Method')).
        Assert:AreEqual(res:Name, "Param1").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'Method').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.Method')).
        Assert:AreEqual(res:Name, "Param2").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'Method').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.Method')).
        Assert:AreEqual(res:Name, "Param3").
        
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW BaseMethod().
        list:AddMethod(meth).
        Assert:IsNotNull(list:MovePrev()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW BaseMethod().
        Assert:IsNull(list:MovePrev()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Reflection.MethodList NO-UNDO.
        DEFINE VARIABLE meth AS Method NO-UNDO.
        DEFINE VARIABLE res  AS BaseMethod NO-UNDO.
        
        list = NEW OEMock.Reflection.MethodList().
        meth = NEW Method('Method Name', 'CHARACTER').
        
        list:AddMethod(meth).
        res = list:MovePrev().
        
        AssertString:Contains(res:GetClass():TypeName, 'Method').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.Method')).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.