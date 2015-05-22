/*------------------------------------------------------------------------
    File        : MethodNameNormaliserTester
    Purpose     : Unit tests for MethodNameNormaliser class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.
USING OEMock.Util.MethodNameNormaliser.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Util.MethodNameNormaliserTester:
    
    @Test.
    METHOD PUBLIC VOID NormaliseReturnsMethodName():
        
        DEFINE VARIABLE meth AS OEMock.Reflection.Method NO-UNDO.
        
        meth = NEW OEMock.Reflection.Method("MethodName").
        
        AssertString:Contains(MethodNameNormaliser:Normalise(meth), "MethodName").
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID NormaliseDoesNotAddParenthesisWithNoParams():
        
        DEFINE VARIABLE meth AS OEMock.Reflection.Method NO-UNDO.
        
        meth = NEW OEMock.Reflection.Method("MethodName").
        
        Assert:AreEqual(MethodNameNormaliser:Normalise(meth), "MethodName").
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID NormaliseObservesParameters():
        
        DEFINE VARIABLE meth AS OEMock.Reflection.Method NO-UNDO.
        
        meth = NEW OEMock.Reflection.Method("MethodName").
        meth:Parameters:AddParameter(NEW OEMock.Reflection.PrimitiveParameter("MyParam", "CHARACTER")).
        
        Assert:AreEqual(MethodNameNormaliser:Normalise(meth), "MethodName(INPUT CHARACTER)").
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        
    END METHOD.
    
END CLASS.