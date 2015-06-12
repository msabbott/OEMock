/*------------------------------------------------------------------------
    File        : PrimitiveParameterTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.PrimitiveParameterTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        
        Assert:AreEqual(parm:Name, 'Parameter Name').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD. 
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDataType():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        
        Assert:AreEqual(parm:DataType, 'CHARACTER').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsNoUndoToTrue():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        
        Assert:IsTrue(parm:AddNoUndo).
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsParameterTypeToInput():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        
        Assert:AreEqual(parm:ParameterType, 'INPUT').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsValidDefinition():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('ParamName', 'CHARACTER').
        
        Assert:AreEqual(parm:GenerateDefinition(), "~n" + 'DEFINE INPUT PARAMETER ParamName AS CHARACTER NO-UNDO.').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsValidDefinitionWithoutNoUndo():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('ParamName', 'CHARACTER').
        parm:AddNoUndo = FALSE.
        Assert:AreEqual(parm:GenerateDefinition(), "~n" + 'DEFINE INPUT PARAMETER ParamName AS CHARACTER .').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionObservesParameterType():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('ParamName', 'CHARACTER').
        parm:ParameterType = "OUTPUT".
        Assert:AreEqual(parm:GenerateDefinition(), "~n" + 'DEFINE OUTPUT PARAMETER ParamName AS CHARACTER NO-UNDO.').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithBlankName():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('', 'CHARACTER').
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithNullName():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter(?, 'CHARACTER').
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithBlankDataType():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', '').
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithNullDataType():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', ?).
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithBlankParameterType():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        parm:ParameterType = ''.
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinitionReturnsBlankWithNullParameterType():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        parm:ParameterType = ?.
        Assert:AreEqual(parm:GenerateDefinition(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsValidDefinition():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('ParamName', 'CHARACTER').
        
        Assert:AreEqual(parm:Generate(), "~n" + 'INPUT ParamName AS CHARACTER,').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIgnoresNoUndo():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('ParamName', 'CHARACTER').
        parm:AddNoUndo = FALSE.
        Assert:AreEqual(parm:Generate(), "~n" + 'INPUT ParamName AS CHARACTER,').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesParameterType():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('ParamName', 'CHARACTER').
        parm:ParameterType = "OUTPUT".
        Assert:AreEqual(parm:Generate(), "~n" + 'OUTPUT ParamName AS CHARACTER,').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithBlankName():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('', 'CHARACTER').
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithNullName():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter(?, 'CHARACTER').
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithBlankDataType():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', '').
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithNullDataType():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', ?).
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithBlankParameterType():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        parm:ParameterType = ''.
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithNullParameterType():
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        parm = NEW PrimitiveParameter('Parameter Name', 'CHARACTER').
        parm:ParameterType = ?.
        Assert:AreEqual(parm:Generate(), '').
        
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
    END METHOD.

END CLASS.