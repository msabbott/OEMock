 /*------------------------------------------------------------------------
    File        : DataSetRelationTester
    Purpose     : Unit tests for DataSet class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.DataSetRelation.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.DataSetRelationTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSetRelation NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSetRelation("dsName").
        
        Assert:AreEqual(dset:Name, "dsName").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesBasicRelation():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSetRelation NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSetRelation("dsName").
        
        gen = dset:Generate().
        
        AssertString:Contains(gen, "DATA-RELATION").
        AssertString:Contains(gen, "FOR").
        AssertString:Contains(gen, "RELATION-FIELDS").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIncludesName():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSetRelation NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSetRelation("dsName").
        
        gen = dset:Generate().
        
        AssertString:Contains(gen, "DATA-RELATION dsName ").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIgnoresBlankName():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSetRelation NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSetRelation("").
        
        gen = dset:Generate().
        
        AssertString:Contains(gen, "DATA-RELATION FOR ").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIgnoresNullName():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSetRelation NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSetRelation(?).
        
        gen = dset:Generate().
        
        AssertString:Contains(gen, "DATA-RELATION FOR ").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIncludesParentBuffer():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSetRelation NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSetRelation("dsName").
        dset:ParentBufferName = "ParentBuffer".
        
        gen = dset:Generate().
        
        AssertString:Contains(gen, "FOR ParentBuffer,").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIncludesChildBuffer():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSetRelation NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSetRelation("dsName").
        dset:ChildBufferName = "ChildBuffer".
        
        gen = dset:Generate().
        
        AssertString:Contains(gen, ",ChildBuffer").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIncludesRelationList():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSetRelation NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSetRelation("dsName").
        dset:RelationList = "FieldA,FieldB".
        
        gen = dset:Generate().
        
        AssertString:Contains(gen, "RELATION-FIELDS (FieldA,FieldB)").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
        
    END METHOD.

END CLASS.