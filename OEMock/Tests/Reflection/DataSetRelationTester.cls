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

END CLASS.