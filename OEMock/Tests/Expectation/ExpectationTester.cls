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
        
        expect = NEW Expectation().
        
        Assert:IsFalse(expect:IsSatisfied).
        
        IF VALID-OBJECT(expect) THEN DELETE OBJECT expect.
    END METHOD.

END CLASS.