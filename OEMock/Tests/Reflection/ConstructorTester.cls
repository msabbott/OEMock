/*------------------------------------------------------------------------
    File        : ConstructorTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.ConstructorTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        DEFINE VARIABLE meth AS Constructor NO-UNDO.
        
        meth = NEW Constructor('ClassName').
        
        Assert:AreEqual(meth:Name,'ClassName').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID DoesNotRequireForwardDeclaration():
        DEFINE VARIABLE meth AS Constructor NO-UNDO.
        
        meth = NEW Constructor('ClassName').
        
        Assert:AreEqual(meth:RequireForward,FALSE).
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateForwardReturnsBlank():
        DEFINE VARIABLE meth AS Constructor NO-UNDO.
        
        meth = NEW Constructor('ClassName').
        
        Assert:AreEqual(meth:GenerateForward(), '').
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesValidConstructor():
        DEFINE VARIABLE meth AS Constructor NO-UNDO.
        
        meth = NEW Constructor('ClassName').
        
        Assert:AreEqual(meth:Generate(), 'CONSTRUCTOR ClassName ():' + "~n" + "END CONSTRUCTOR.").
        
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIncludesParameters():
        DEFINE VARIABLE meth AS Constructor NO-UNDO.
        DEFINE VARIABLE parm1 AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE parm2 AS PrimitiveParameter NO-UNDO.
        
        meth  = NEW Constructor('ClassName').
        parm1 = NEW PrimitiveParameter('Param1', 'CHARACTER').
        parm2 = NEW PrimitiveParameter('Param2', 'CHARACTER').
        
        meth:Parameters:AddParameter(parm1).
        meth:Parameters:AddParameter(parm2).
        Assert:AreEqual(meth:Parameters:Count, 2).
        
        Assert:AreEqual(meth:Generate(), 'CONSTRUCTOR ClassName ('
                                         + "~n" + "INPUT Param1 AS CHARACTER,"
                                         + "~n" + "INPUT Param2 AS CHARACTER):"
                                         + "~n" + "END CONSTRUCTOR.").

        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
    END METHOD.

END CLASS.