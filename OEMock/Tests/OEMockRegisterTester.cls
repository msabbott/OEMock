/*------------------------------------------------------------------------
    File        : OEMockRegisterTester
    Purpose     : Unit tests for OEMockRegister class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.OEMockRegisterTester:
    
    @Test.
    METHOD PUBLIC VOID RegisterMethodCallReturnsFirstCallNumber():
        DEFINE VARIABLE testVal AS LOGICAL NO-UNDO.
        
        OEMockRegister:ClearMethodCallRegister().
        Assert:AreEqual(OEMockRegister:RegisterMethodCall("Dummy Method"), 1).
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID RegisterMethodCallIncrementsCallNumber():
        DEFINE VARIABLE testVal AS LOGICAL NO-UNDO.
        
        OEMockRegister:ClearMethodCallRegister().
        Assert:AreEqual(OEMockRegister:RegisterMethodCall("Dummy Method"), 1).
        Assert:AreEqual(OEMockRegister:RegisterMethodCall("Dummy Method"), 2).
        
    END METHOD.
    
    @AfterClass.
    METHOD PUBLIC VOID ClearMethodCallRegister():
        OEMockRegister:ClearMethodCallRegister().
    END METHOD.

END CLASS.