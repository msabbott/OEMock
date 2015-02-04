/*------------------------------------------------------------------------
    File        : BufferParameterTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.BufferParameterTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter('BufferName', 'TableName').
        
        Assert:AreEqual(parm:Name, 'BufferName').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD. 
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsTableName():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter('BufferName', 'TableName').
        
        Assert:AreEqual(parm:TableName, 'TableName').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsValidDefinition():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter('ParamName', 'TableName').
        
        Assert:AreEqual(parm:GenerateDefinition(), CHR(10) + CHR(13) + 'DEFINE PARAMETER BUFFER ParamName FOR TableName.').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithBlankName():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter('', 'TableName').
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithNullName():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter(?, 'TableName').
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithBlankTableName():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter('BufferName', '').
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithNullTableName():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter('BufferName', ?).
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsValidDefinition():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter('ParamName', 'TableName').
        
        Assert:AreEqual(parm:Generate(), CHR(10) + CHR(13) + 'BUFFER ParamName FOR TableName,').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithBlankName():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter('', 'TableName').
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithNullName():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter(?, 'TableName').
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithBlankTableName():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter('BufferName', '').
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithNullTableName():
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter('BufferName', ?).
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.

END CLASS.