 /*------------------------------------------------------------------------
    File        : TempTableIndexTester
    Purpose     : Unit tests for TempTableIndex class 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.TempTableIndex.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.TempTableIndexTester: 
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesFields():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndex NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndex("FieldName").
        
        Assert:IsTrue(VALID-OBJECT(tfld:Fields)).
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndex NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndex("FieldName").
        
        Assert:AreEqual(tfld:Name, "FieldName").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsPrimaryFalse():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndex NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndex("FieldName").
        
        Assert:IsFalse(tfld:Primary).
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsUniqueFalse():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndex NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndex("FieldName").
        
        Assert:IsFalse(tfld:Unique).
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsWordIndexFalse():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndex NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndex("FieldName").
        
        Assert:IsFalse(tfld:WordIndex).
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesBasicIndex():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndex NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndex("FieldName").
        
        AssertString:Contains(tfld:Generate(), "INDEX FieldName ").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesPrimary():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndex NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndex("FieldName").
        tfld:Primary = TRUE.
        
        AssertString:Contains(tfld:Generate(), "INDEX FieldName IS PRIMARY ").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesUnique():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndex NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndex("FieldName").
        tfld:Unique = TRUE.
        
        AssertString:Contains(tfld:Generate(), "INDEX FieldName IS UNIQUE ").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesWordIndex():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndex NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndex("FieldName").
        tfld:WordIndex = TRUE.
        
        AssertString:Contains(tfld:Generate(), "INDEX FieldName IS WORD-INDEX ").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesCompoundFlags():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndex NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndex("FieldName").
        tfld:Primary   = TRUE.
        tfld:Unique    = TRUE.
        tfld:WordIndex = TRUE.
        
        AssertString:Contains(tfld:Generate(), "INDEX FieldName IS PRIMARY UNIQUE WORD-INDEX ").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesIndexes():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableIndex NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                         NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableIndex("Index").
        tfld:Fields:AddTempTableIndexField(NEW OEMock.Reflection.TempTableIndexField("Field1")).
        
        gen = tfld:Generate().

        AssertString:Contains(gen, "Field1 ASCENDING").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.

END CLASS.