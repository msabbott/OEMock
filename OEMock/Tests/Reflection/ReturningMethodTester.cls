/*------------------------------------------------------------------------
    File        : ReturningMethodTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.ReturningMethodTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        DEFINE VARIABLE meth AS ReturningMethod NO-UNDO.
        
        meth = NEW ReturningMethod('Method Name', 'CHARACTER').
        
        Assert:AreEqual(meth:Name,'Method Name').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsReturnType():
        DEFINE VARIABLE meth AS ReturningMethod NO-UNDO.
        
        meth = NEW ReturningMethod('Method Name', 'CHARACTER').
        
        Assert:AreEqual(meth:ReturnType,'CHARACTER').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsReturnType_ShortConstructor():
        DEFINE VARIABLE meth AS ReturningMethod NO-UNDO.
        
        meth = NEW ReturningMethod('Method Name').
        
        Assert:AreEqual(meth:ReturnType,'Method Name').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID DoesNotRequireForwardDeclaration():
        DEFINE VARIABLE meth AS ReturningMethod NO-UNDO.
        
        meth = NEW ReturningMethod('Method Name').
        
        Assert:AreEqual(meth:RequireForward,FALSE).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlank():
        DEFINE VARIABLE meth AS ReturningMethod NO-UNDO.
        
        meth = NEW ReturningMethod('Method Name').
        
        Assert:AreEqual(meth:Generate(), '').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateForwardReturnsBlank():
        DEFINE VARIABLE meth AS ReturningMethod NO-UNDO.
        
        meth = NEW ReturningMethod('Method Name').
        
        Assert:AreEqual(meth:GenerateForward(), '').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.

END CLASS.