 /*------------------------------------------------------------------------
    File        : TempTableFieldTester
    Purpose     : Unit tests for TempTableField class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.TempTableField.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.TempTableFieldTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        
        Assert:AreEqual(tfld:Name, "FieldName").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDataType():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        
        Assert:AreEqual(tfld:DataType, "CHARACTER").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsInitialBlank():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        
        Assert:AreEqual(tfld:Initial, "").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsExtentZero():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        
        Assert:AreEqual(tfld:Extent, 0).
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsSerializeHiddenFalse():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        
        Assert:IsFalse(tfld:SerializeHidden).
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsSerializeNameBlank():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        
        Assert:AreEqual(tfld:SerializeName, "").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsXMLDataTypeBlank():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        
        Assert:AreEqual(tfld:XMLDataType, "").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsXMLNodeTypeBlank():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        
        Assert:AreEqual(tfld:XMLNodeType, "").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsXMLNodeNameBlank():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        
        Assert:AreEqual(tfld:XMLNodeName, "").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ExtentPropertyResetsNullValue():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        tfld:Extent = ?.
        
        Assert:AreEqual(tfld:Extent, 0).
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ExtentPropertyResetsNegativeValue():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        tfld:Extent = -1.
        
        Assert:AreEqual(tfld:Extent, 0).
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesBasicField():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        
        AssertString:Contains(tfld:Generate(), "FIELD FieldName AS CHARACTER").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesInitial():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        tfld:INITIAL = "'Initial Value'".
        
        AssertString:Contains(tfld:Generate(), "INITIAL 'Initial Value'").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesExtents():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        tfld:EXTENT = 4.
        
        AssertString:Contains(tfld:Generate(), "EXTENT 4").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesSerializeHidden():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        tfld:SerializeHidden = TRUE.
        
        AssertString:Contains(tfld:Generate(), "SERIALIZE-HIDDEN").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesSerializeName():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        tfld:SerializeName = "SerializeName".
        
        AssertString:Contains(tfld:Generate(), "SERIALIZE-NAME ~"SerializeName~"").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesXMLDataType():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        tfld:XMLDataType = "XMLDataType".
        
        AssertString:Contains(tfld:Generate(), "XML-DATA-TYPE ~"XMLDataType~"").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.

    
    @Test.
    METHOD PUBLIC VOID GenerateObservesXMLNodeType ():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        tfld:XMLNodeType = "XMLNodeType".
        
        AssertString:Contains(tfld:Generate(), "XML-NODE-TYPE ~"XMLNodeType~"").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.

    
    @Test.
    METHOD PUBLIC VOID GenerateObservesXMLNodeName():
        
        DEFINE VARIABLE tfld AS OEMock.Reflection.TempTableField NO-UNDO.
        
        tfld = NEW OEMock.Reflection.TempTableField("FieldName", "CHARACTER").
        tfld:XMLNodeName = "XMLNodeName".
        
        AssertString:Contains(tfld:Generate(), "XML-NODE-NAME ~"XMLNodeName~"").
        
        IF VALID-OBJECT(tfld) THEN DELETE OBJECT tfld.
    END METHOD.

END CLASS.