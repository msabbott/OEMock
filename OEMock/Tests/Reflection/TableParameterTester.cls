/*------------------------------------------------------------------------
    File        : TableParameterTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.TableParameterTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('TableName').
        
        Assert:AreEqual(parm:Name, 'TableName').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD. 
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsParameterTypeToInput():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('TableName').
        
        Assert:AreEqual(parm:ParameterType, 'INPUT').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsValidDefinition():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('TableName').
        
        Assert:AreEqual(parm:GenerateDefinition(), CHR(13) + 'DEFINE INPUT PARAMETER TABLE FOR TableName.').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionObservesParameterType():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('TableName').
        parm:ParameterType = "OUTPUT".
        Assert:AreEqual(parm:GenerateDefinition(), CHR(13) + 'DEFINE OUTPUT PARAMETER TABLE FOR TableName.').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithBlankName():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('').
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithNullName():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter(?).
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithBlankParameterType():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('TableName').
        parm:ParameterType = ''.
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithNullParameterType():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('TableName').
        parm:ParameterType = ?.
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsValidDefinition():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('TableName').
        
        Assert:AreEqual(parm:Generate(), CHR(13) + 'INPUT FOR TABLE TableName,').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesParameterType():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('TableName').
        parm:ParameterType = "OUTPUT".
        Assert:AreEqual(parm:Generate(), CHR(13) + 'OUTPUT FOR TABLE TableName,').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithBlankName():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('').
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithNullName():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter(?).
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithBlankParameterType():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('TableName').
        parm:ParameterType = ''.
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithNullParameterType():
        DEFINE VARIABLE parm AS TableParameter NO-UNDO.
        
        parm = NEW TableParameter('TableName').
        parm:ParameterType = ?.
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.

END CLASS.