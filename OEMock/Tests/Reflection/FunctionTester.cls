/*------------------------------------------------------------------------
    File        : FunctionTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.
USING OEMock.Generation.*.

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
        DEFINE VARIABLE outp AS LONGCHAR NO-UNDO.
        
        meth = NEW Function('TestFunction', "CHARACTER").
        
        outp = meth:Generate().
        AssertString:Contains(outp, 'FUNCTION TestFunction RETURNS CHARACTER ():').
        AssertString:Contains(outp, "END FUNCTION.").
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateForwardCreatesValidFunctionForward():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        
        meth = NEW Function('TestFunction', "CHARACTER").
        
        Assert:AreEqual(meth:GenerateForward(),'FUNCTION TestFunction RETURNS CHARACTER () FORWARD.').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIncludesParameters():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        DEFINE VARIABLE parm1 AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE parm2 AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE outp  AS LONGCHAR NO-UNDO.
        
        meth  = NEW Function('TestFunction', "CHARACTER").
        parm1 = NEW PrimitiveParameter('Param1', 'CHARACTER').
        parm2 = NEW PrimitiveParameter('Param2', 'CHARACTER').
        
        meth:Parameters:AddParameter(parm1).
        meth:Parameters:AddParameter(parm2).
        Assert:AreEqual(meth:Parameters:Count, 2).
        
        outp = meth:Generate().
        AssertString:Contains(outp, 'FUNCTION TestFunction RETURNS CHARACTER ('
                                    + "~n" + "INPUT Param1 AS CHARACTER,"
                                    + "~n" + "INPUT Param2 AS CHARACTER):").
                                         
        AssertString:Contains(outp, "END FUNCTION.").

        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateForwardIncludesParameters():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        DEFINE VARIABLE parm1 AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE parm2 AS PrimitiveParameter NO-UNDO.
        
        meth  = NEW Function('TestFunction', "CHARACTER").
        parm1 = NEW PrimitiveParameter('Param1', 'CHARACTER').
        parm2 = NEW PrimitiveParameter('Param2', 'CHARACTER').
        
        meth:Parameters:AddParameter(parm1).
        meth:Parameters:AddParameter(parm2).
        Assert:AreEqual(meth:Parameters:Count, 2).
        
        Assert:AreEqual(meth:GenerateForward(), 'FUNCTION TestFunction RETURNS CHARACTER ('
                                                + "~n" + "INPUT Param1 AS CHARACTER,"
                                                + "~n" + "INPUT Param2 AS CHARACTER) FORWARD.").

        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCallsGenerators():
        DEFINE VARIABLE meth AS Function NO-UNDO.
        DEFINE VARIABLE gen  AS FunctionGenerator NO-UNDO.
        
        meth = NEW Function('TestFunction', "CHARACTER").
        gen  = NEW FunctionGenerator().
        gen:AttachTo(meth).
        
        AssertString:Contains(meth:Generate(), "RETURN res.").
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
    END METHOD.

END CLASS.