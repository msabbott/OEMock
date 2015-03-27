 /*------------------------------------------------------------------------
    File        : DataSetTester
    Purpose     : Unit tests for DataSet class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.DataSet.
USING OEMock.Reflection.DataSetRelation.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.DataSetTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSet NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSet("dsName").
        
        Assert:AreEqual(dset:Name, "dsName").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsNotStatic():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSet NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSet("dsName").
        
        Assert:IsFalse(dset:Static).
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesDataSetRelations():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSet NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSet("dsName").
        
        Assert:IsTrue(VALID-OBJECT(dset:DataSetRelations)).
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateDefinesBasicDataset():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSet NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                  NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSet("dsName").
        
        gen = dset:Generate().
        
        AssertString:Contains(gen, "DEFINE DATASET ").
        AssertString:Contains(gen, " FOR ").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesStatic():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSet NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                  NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSet("dsName").
        dset:Static = TRUE.
        
        gen = dset:Generate().
        
        AssertString:Contains(gen, "DEFINE STATIC DATASET dsName FOR ").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIncludesName():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSet NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                  NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSet("dsName").
        
        gen = dset:Generate().
        
        AssertString:Contains(gen, "DEFINE DATASET dsName FOR ").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIncludesBuffers():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSet NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                  NO-UNDO.
        
        dset = NEW OEMock.Reflection.DataSet("dsName").
        dset:Buffers = "TableA,TableB".
        gen = dset:Generate().
        
        AssertString:Contains(gen, " FOR TableA,TableB ").
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIncludesRelations():
        
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSet         NO-UNDO.
        DEFINE VARIABLE drel AS OEMock.Reflection.DataSetRelation NO-UNDO.
        DEFINE VARIABLE gen  AS LONGCHAR                          NO-UNDO.
        
        drel = NEW DataSetRelation("Relation1").
        drel:ParentBufferName = "TableA".
        drel:ChildBufferName  = "TableB".
        drel:RelationList = "FieldA,FieldA".
        
        dset = NEW OEMock.Reflection.DataSet("dsName").
        dset:Buffers = "TableA,TableB".
        dset:DataSetRelations:AddDataSetRelation(drel).
        gen = dset:Generate().
        
        AssertString:Contains(gen, STRING(drel:Generate())).
        
        IF VALID-OBJECT(dset) THEN DELETE OBJECT dset.
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
    END METHOD.

END CLASS.