/*------------------------------------------------------------------------
    File        : ExpectationListTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Expectation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Expectation.ExpectationListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddExpectationIncrementsCounter():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS BaseExpectation NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW BaseExpectation().
        list:AddExpectation(meth).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        list:AddExpectation(?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS BaseExpectation NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW BaseExpectation().
        list:AddExpectation(meth).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNotNull():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS BaseExpectation NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW BaseExpectation().
        list:AddExpectation(meth).
        Assert:IsNotNull(list:MoveFirst()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS BaseExpectation NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW BaseExpectation().
        Assert:IsNull(list:MoveFirst()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS Expectation NO-UNDO.
        DEFINE VARIABLE res  AS BaseExpectation NO-UNDO.
        
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW Expectation("MethodName").
        
        list:AddExpectation(meth).
        res = list:MoveFirst().
        
        AssertString:Contains(res:GetClass():TypeName, 'Expectation').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Expectation.Expectation')).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNotNull():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS BaseExpectation NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW BaseExpectation().
        list:AddExpectation(meth).
        Assert:IsNotNull(list:MoveLast()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS BaseExpectation NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW BaseExpectation().
        Assert:IsNull(list:MoveLast()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS Expectation NO-UNDO.
        DEFINE VARIABLE res  AS BaseExpectation NO-UNDO.
        
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW Expectation("MethodName").
        
        list:AddExpectation(meth).
        res = list:MoveLast().
        
        AssertString:Contains(res:GetClass():TypeName, 'Expectation').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Expectation.Expectation')).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNotNull():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS BaseExpectation NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW BaseExpectation().
        list:AddExpectation(meth).
        Assert:IsNotNull(list:MoveNext()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS BaseExpectation NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW BaseExpectation().
        Assert:IsNull(list:MoveNext()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS Expectation NO-UNDO.
        DEFINE VARIABLE res  AS BaseExpectation NO-UNDO.
        
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW Expectation("MethodName").
        
        list:AddExpectation(meth).
        res = list:MoveNext().
        
        AssertString:Contains(res:GetClass():TypeName, 'Expectation').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Expectation.Expectation')).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNotNull():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS BaseExpectation NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW BaseExpectation().
        list:AddExpectation(meth).
        Assert:IsNotNull(list:MovePrev()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS BaseExpectation NO-UNDO.
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW BaseExpectation().
        Assert:IsNull(list:MovePrev()).
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Expectation.ExpectationList NO-UNDO.
        DEFINE VARIABLE meth AS Expectation NO-UNDO.
        DEFINE VARIABLE res  AS BaseExpectation NO-UNDO.
        
        list = NEW OEMock.Expectation.ExpectationList().
        meth = NEW Expectation("MethodName").
        
        list:AddExpectation(meth).
        res = list:MovePrev().
        
        AssertString:Contains(res:GetClass():TypeName, 'Expectation').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Expectation.Expectation')).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.