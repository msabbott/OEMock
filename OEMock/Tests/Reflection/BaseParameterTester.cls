/*------------------------------------------------------------------------
    File        : BaseParameterTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.BaseParameterTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        
        parm = NEW BaseParameter('Parameter Name').
        
        Assert:AreEqual(parm:Name, 'Parameter Name').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlank():
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        
        parm = NEW BaseParameter('Parameter Name').
        
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlank():
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        
        parm = NEW BaseParameter('Parameter Name').
        
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.

END CLASS.