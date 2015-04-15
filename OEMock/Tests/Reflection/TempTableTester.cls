 /*------------------------------------------------------------------------
    File        : TempTableTester
    Purpose     : Unit tests for TempTable class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.TempTable.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.TempTableTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesFields():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        
        Assert:IsTrue(VALID-OBJECT(ttab:Fields)).
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        
        Assert:AreEqual(ttab:Name, "ttTempTable").
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsBlankNamespacePrefix():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        
        Assert:AreEqual(ttab:NamespacePrefix, "").
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsBlankNamespaceURI():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        
        Assert:AreEqual(ttab:NamespaceURI, "").
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsNotStatic():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        
        Assert:IsFalse(ttab:Static).
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsNoUndo():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        
        Assert:IsTrue(ttab:NoUndo).
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinesBasicTempTable():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                  NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        
        gen = ttab:Generate().
        
        AssertString:Contains(gen, "DEFINE TEMP-TABLE ttTempTable ").
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesStatic():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                  NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        ttab:Static = TRUE.
        
        gen = ttab:Generate().
        
        AssertString:Contains(gen, "DEFINE STATIC TEMP-TABLE ttTempTable ").
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesNoUndo():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                  NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        ttab:NoUndo = TRUE.
        
        gen = ttab:Generate().
        
        AssertString:Contains(gen, "NO-UNDO").
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesUndo():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                  NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        ttab:NoUndo = FALSE.
        
        gen = ttab:Generate().
        
        AssertString:DoesNotContain(gen, " NO-UNDO ").
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesNamespacePrefix():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                  NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        ttab:NamespacePrefix = "MyNameSpacePrefix".
        
        gen = ttab:Generate().
        
        AssertString:Contains(gen, " NAMESPACE-PREFIX ~"MyNameSpacePrefix~"").
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesNamespaceURI():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                  NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        ttab:NamespaceURI = "MyNameSpaceURI".
        
        gen = ttab:Generate().

        AssertString:Contains(gen, " NAMESPACE-URI ~"MyNameSpaceURI~"").
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesFields():
        
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                  NO-UNDO.
        
        ttab = NEW OEMock.Reflection.TempTable("ttTempTable").
        ttab:Fields:AddTempTableField(NEW OEMock.Reflection.TempTableField("Field1", "CHARACTER")).
        
        gen = ttab:Generate().

        AssertString:Contains(gen, "FIELD Field1 AS CHARACTER").
        
        IF VALID-OBJECT(ttab) THEN DELETE OBJECT ttab.
    END METHOD.

END CLASS.