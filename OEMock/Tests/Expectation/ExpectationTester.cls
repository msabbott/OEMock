/*------------------------------------------------------------------------
    File        : ExpectationTester
    Purpose     : Unit tests for Expectation class 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Expectation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Expectation.ExpectationTester: 
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsNotSatisfied():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        
        Assert:IsFalse(expect:IsSatisfied).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsMethodName():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        
        Assert:AreEqual(expect:MethodName, "MethodName").
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsMinimumCallsToNull():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        
        Assert:IsNull(expect:MinimumCalls, ?).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsMaximumCallsToNull():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        
        Assert:IsNull(expect:MaximumCalls, ?).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MaximumCallsResetsMinimumCallsIfLowerThan():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        
        expect:CalledAtLeast(9).
        expect:CalledAtMost(5).
        
        Assert:IsNull(expect:MinimumCalls, ?).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MaximumCallsSetToNegativeResetsToNull():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        
        expect:CalledAtMost(-5).
        
        Assert:IsNull(expect:MaximumCalls, ?).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MinimumCallsResetsMaximumCallsIfGreaterThan():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        
        expect:CalledAtMost(5).
        expect:CalledAtLeast(9).
        
        Assert:IsNull(expect:MaximumCalls, ?).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MinimumCallsSetToNegativeResetsToNull():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        
        expect:CalledAtLeast(-5).
        
        Assert:IsNull(expect:MinimumCalls, ?).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID CalledAtLeastSetsMinimumCalls():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        expect:CalledAtLeast(5).
        
        Assert:AreEqual(expect:MinimumCalls, 5).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID CalledAtLeastDoesNotSetMaximumCalls():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        expect:CalledAtLeast(5).
        
        Assert:IsNull(expect:MaximumCalls, ?).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID CalledAtMostSetMaximumCalls():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        expect:CalledAtMost(5).
        
        Assert:AreEqual(expect:MaximumCalls, 5).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID CalledAtMostDoesNotSetMaximumCalls():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        expect:CalledAtMost(5).
        
        Assert:IsNull(expect:MinimumCalls, ?).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID CalledExactlySetsMinimumCalls():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        expect:CalledExactly(5).
        
        Assert:AreEqual(expect:MinimumCalls, 5).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID CalledExactlySetsMaximumCalls():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        expect:CalledExactly(5).
        
        Assert:AreEqual(expect:MaximumCalls, 5).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID CalledOnlyOnceSetMinimumCallsToOne():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        expect:CalledOnlyOnce().
        
        Assert:AreEqual(expect:MinimumCalls, 1).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID CalledOnlyOnceSetMaximumCallsToOne():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        expect:CalledOnlyOnce().
        
        Assert:AreEqual(expect:MaximumCalls, 1).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID NeverCalledSetMaximumCallsToZero():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        expect:NeverCalled().
        
        Assert:AreEqual(expect:MaximumCalls, 0).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID NeverCalledSetMinimumCallsToZero():
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation("MethodName").
        expect:NeverCalled().
        
        Assert:AreEqual(expect:MinimumCalls, 0).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.

END CLASS.