/*------------------------------------------------------------------------
    File        : BaseInspectorTester
    Purpose     : Unit tests for BaseInspector class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Inspection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Inspection.BaseInspectorTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsFileName():
        DEFINE VARIABLE insp AS BaseInspector NO-UNDO.
        
        insp = NEW BaseInspector("FileName").
        
        Assert:AreEqual(insp:FileName, "FileName").
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT insp.
    END METHOD.

END CLASS.