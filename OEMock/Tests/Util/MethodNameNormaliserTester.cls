/*------------------------------------------------------------------------
    File        : MethodNameNormaliserTester
    Purpose     : Unit tests for MethodNameNormaliser class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.
USING OEMock.Util.MethodNameNormaliser.
USING OEMock.Util.MethodNameNormaliserError.

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
    
    @Test.
    METHOD PUBLIC VOID Sanitise():
        
        MethodNameNormaliser:Sanitise("MethName").
        MethodNameNormaliser:Sanitise("MethName(INPUT CHARACTER)").
        
        MethodNameNormaliser:Sanitise("MethName Someshit").
        
        MethodNameNormaliser:Sanitise("MethName Someshit(INPUT CHARACTER)").
        
        MethodNameNormaliser:Sanitise("MethName(CHARACTER)").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_JustMethodName():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName"), "MethName").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_OneParam():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName(INPUT CHARACTER)"), "MethName(INPUT CHARACTER)").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_InputOutputParam():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName(INPUT-OUTPUT CHARACTER)"), "MethName(INPUT-OUTPUT CHARACTER)").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_OutputParam():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName(OUTPUT CHARACTER)"), "MethName(OUTPUT CHARACTER)").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_ImplicitInputParam():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName(CHARACTER)"), "MethName(INPUT CHARACTER)").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_MultiParams():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName(INPUT CHARACTER,INPUT CHARACTER)"), "MethName(INPUT CHARACTER,INPUT CHARACTER)").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_NoParams():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName()"), "MethName").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_BufferParam():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName(INPUT BUFFER buf)"), "MethName(INPUT BUFFER buf)").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_DataSetParam():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName(INPUT DATASET dSet)"), "MethName(INPUT DATASET dSet)").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_TableParam():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName(INPUT TABLE tab)"), "MethName(INPUT TABLE tab)").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_ObjectParam():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName(INPUT OEMock.Util.MethodNameNormaliser)"), "MethName(INPUT OEMock.Util.MethodNameNormaliser)").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_BadMethodName():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName Something Else"), "MethName").
    END METHOD.
    
    @Test(expected="OEMock.Util.MethodNameNormaliserError").
    METHOD PUBLIC VOID Sanitise_BadDataType():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName(INPUT BadTypeName)"), "MethName").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_TrailingJunk():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName(INPUT CHARACTER)Trailer"), "MethName(INPUT CHARACTER)").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID Sanitise_BadParameterParenthesis():
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName ("), "MethName").
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName )"), "MethName").
        Assert:AreEqual(MethodNameNormaliser:Sanitise("MethName )("), "MethName").
    END METHOD.
    
END CLASS.