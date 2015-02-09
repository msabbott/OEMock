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
    
    @Test.
    METHOD PUBLIC VOID GenerateIncludesParameters():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        DEFINE VARIABLE parm1 AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE parm2 AS PrimitiveParameter NO-UNDO.
        
        meth  = NEW Method('TestMethod', "CHARACTER").
        parm1 = NEW PrimitiveParameter('Param1', 'CHARACTER').
        parm2 = NEW PrimitiveParameter('Param2', 'CHARACTER').
        
        meth:Parameters:AddParameter(parm1).
        meth:Parameters:AddParameter(parm2).
        Assert:AreEqual(meth:Parameters:Count, 2).
        
        Assert:AreEqual(meth:Generate(), 'METHOD PUBLIC CHARACTER TestMethod ('
                                         + CHR(10) + CHR(13) + "INPUT Param1 AS CHARACTER,"
                                         + CHR(10) + CHR(13) + "INPUT Param2 AS CHARACTER):"
                                         + CHR(10) + CHR(13) + "END METHOD.").

        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesStaticMarker():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('TestMethod', "CHARACTER").
        meth:Static = TRUE.
        
        Assert:AreEqual(meth:Generate(), 'METHOD PUBLIC STATIC CHARACTER TestMethod ():'
                                         + CHR(10) + CHR(13) + "END METHOD.").

        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesAbstractMarker():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('TestMethod', "CHARACTER").
        meth:Abstract = TRUE.
        
        Assert:AreEqual(meth:Generate(), 'METHOD PUBLIC ABSTRACT CHARACTER TestMethod ():'
                                         + CHR(10) + CHR(13) + "END METHOD.").

        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID SettingStaticSetsAbstractToFalse():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('Method Name').
        
        /* Set Abstract to True, then Static to True. Abstract
         * should then be set to False
         */
        meth:Abstract = TRUE.
        meth:Static   = TRUE.
        
        Assert:IsFalse(meth:Abstract).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID SettingAbstractSetsStaticToFalse():
        DEFINE VARIABLE meth AS Method NO-UNDO.
        
        meth = NEW Method('Method Name').
        
        /* Set Static to True, then Abstract to True. Static
         * should then be set to False
         */
        meth:Static   = TRUE.
        meth:Abstract = TRUE.
        
        Assert:IsFalse(meth:Static).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.

END CLASS.