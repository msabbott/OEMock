/*------------------------------------------------------------------------
    File        : MethodTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.MethodTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('Method Name', 'CHARACTER').
        
        Assert:AreEqual(meth:Name,'Method Name').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsReturnType():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('Method Name', 'CHARACTER').
        
        Assert:AreEqual(meth:ReturnType,'CHARACTER').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsReturnType_ShortConstructor():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('Method Name').
        
        Assert:AreEqual(meth:ReturnType,'VOID').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsRequiresForwardDeclaration():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('Method Name').
        
        Assert:AreEqual(meth:RequireForward,FALSE).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWhenNameIsBlank():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('').
        
        Assert:AreEqual(meth:Generate(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWhenNameIsNull():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method(?).
        
        Assert:AreEqual(meth:Generate(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWhenReturnTypeIsBlank():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('Method Name', '').
        
        Assert:AreEqual(meth:Generate(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWhenReturnTypeIsNull():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('Method Name', ?).
        
        Assert:AreEqual(meth:Generate(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateForwardReturnsBlank():
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        
        meth = NEW BaseMethod('Method Name').
        
        Assert:AreEqual(meth:GenerateForward(), '').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesValidMethod():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('TestMethod', "CHARACTER").
        
        Assert:AreEqual(meth:Generate(),'METHOD PUBLIC CHARACTER TestMethod ():' + CHR(10) + CHR(13) + "END METHOD.").
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        
    END METHOD.

END CLASS.