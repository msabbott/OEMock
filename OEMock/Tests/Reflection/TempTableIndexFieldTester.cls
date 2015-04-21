 /*------------------------------------------------------------------------
    File        : TempTableIndexFieldTester
    Purpose     : Unit tests for TempTableIndexField class 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.TempTableIndexField.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.TempTableIndexFieldTester: 
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndexField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndexField("FieldName").
        
        Assert:AreEqual(tfld:Name, "FieldName").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDescendingFalse():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndexField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndexField("FieldName").
        
        Assert:IsFalse(tfld:Descending).
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesAscendingField():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndexField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndexField("FieldName").
        
        AssertString:Contains(tfld:Generate(), "FieldName ASCENDING").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesDescending():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndexField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndexField("FieldName").
        tfld:Descending = TRUE.
        
        AssertString:Contains(tfld:Generate(), "FieldName DESCENDING").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.

END CLASS.