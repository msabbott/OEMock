/*------------------------------------------------------------------------
    File        : BaseExpectationTester
    Purpose     : Unit tests for BaseExpectation class 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Expectation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Expectation.BaseExpectationTester: 
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsNotSatisfied():
        DEFINE VARIABLE expect AS BaseExpectation NO-UNDO.
        
        expect = NEW BaseExpectation().
        
        Assert:IsFalse(expect:IsSatisfied).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.

END CLASS.