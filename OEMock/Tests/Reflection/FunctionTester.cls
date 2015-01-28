/*------------------------------------------------------------------------
    File        : FunctionTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.FunctionTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('Method Name', 'CHARACTER').
        
        Assert:AreEqual(meth:Name,'Method Name').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsReturnType():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('Method Name', 'CHARACTER').
        
        Assert:AreEqual(meth:ReturnType,'CHARACTER').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsReturnType_ShortConstructor():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('Method Name').
        
        Assert:AreEqual(meth:ReturnType,'Method Name').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsRequiresForwardDeclaration():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('Method Name').
        
        Assert:AreEqual(meth:RequireForward,TRUE).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWhenNameIsBlank():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('').
        
        Assert:AreEqual(meth:Generate(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWhenNameIsNull():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function(?).
        
        Assert:AreEqual(meth:Generate(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWhenReturnTypeIsBlank():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('Method Name').
        
        Assert:AreEqual(meth:Generate(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWhenReturnTypeIsNull():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('Method Name', ?).
        
        Assert:AreEqual(meth:Generate(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateForwardReturnsBlankWhenNameIsBlank():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('').
        
        Assert:AreEqual(meth:GenerateForward(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateForwardReturnsBlankWhenNameIsNull():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function(?).
        
        Assert:AreEqual(meth:GenerateForward(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateForwardReturnsBlankWhenReturnTypeIsBlank():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('Method Name').
        
        Assert:AreEqual(meth:GenerateForward(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateForwardReturnsBlankWhenReturnTypeIsNull():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('Method Name', ?).
        
        Assert:AreEqual(meth:GenerateForward(),'').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesValidFunction():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('TestFunction', "CHARACTER").
        
        Assert:AreEqual(meth:Generate(),'FUNCTION TestFunction RETURNS CHARACTER ():' + CHR(10) + CHR(13) + "END FUNCTION.").
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateForwardCreatesValidFunctionForward():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('TestFunction', "CHARACTER").
        
        Assert:AreEqual(meth:GenerateForward(),'FUNCTION TestFunction RETURNS CHARACTER () FORWARD.').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        
    END METHOD.

END CLASS.