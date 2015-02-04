/*------------------------------------------------------------------------
    File        : ProcedureInspectorTester
    Purpose     : Unit tests for ProcedureInspector class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Inspection.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Inspection.ProcedureInspectorTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsFileName():
        DEFINE VARIABLE insp AS ProcedureInspector NO-UNDO.
        
        insp = NEW ProcedureInspector("FileName").
        
        Assert:AreEqual(insp:FileName, "FileName").
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT insp.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID InspectReturnsProcedureFile():
        DEFINE VARIABLE insp AS ProcedureInspector NO-UNDO.
        DEFINE VARIABLE proc AS BaseFile       NO-UNDO.
        
        insp = NEW ProcedureInspector("OEMock/Tests/Inspection/TestProcedure.p").
        proc = insp:Inspect().
        
        Assert:IsTrue(VALID-OBJECT(proc), "Invalid object returned").
        Assert:IsTrue(proc:GetClass():IsA("OEMock.Reflection.ProcedureFile"), proc:GetClass():TypeName).
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT insp.
        IF VALID-OBJECT(proc)  THEN DELETE OBJECT proc.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID InspectReturnsClassWithProcedures():
        DEFINE VARIABLE insp AS ProcedureInspector NO-UNDO.
        DEFINE VARIABLE base AS BaseFile           NO-UNDO.
        DEFINE VARIABLE proc AS ProcedureFile      NO-UNDO.
        
        insp = NEW ProcedureInspector("OEMock/Tests/Inspection/TestProcedure.p").
        base = insp:Inspect().
        
        Assert:IsTrue(VALID-OBJECT(base), "Invalid object returned").
        
        IF base:GetClass():IsA("OEMock.Reflection.ProcedureFile") THEN
        DO:
            proc = DYNAMIC-CAST(base, base:GetClass():TypeName).
            Assert:IsTrue(proc:Procedures:Count > 0).
        END.
        ELSE
        DO:
            Assert:Fail("Incompatible object type returned").
        END.
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT insp.
        IF VALID-OBJECT(base) THEN DELETE OBJECT base.
        IF VALID-OBJECT(proc) THEN DELETE OBJECT proc.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID InspectReturnsClassWithFunctions():
        DEFINE VARIABLE insp AS ProcedureInspector NO-UNDO.
        DEFINE VARIABLE base AS BaseFile           NO-UNDO.
        DEFINE VARIABLE proc AS ProcedureFile      NO-UNDO.
        
        insp = NEW ProcedureInspector("OEMock/Tests/Inspection/TestProcedure.p").
        base = insp:Inspect().
        
        Assert:IsTrue(VALID-OBJECT(base), "Invalid object returned").
        
        IF base:GetClass():IsA("OEMock.Reflection.ProcedureFile") THEN
        DO:
            proc = DYNAMIC-CAST(base, base:GetClass():TypeName).
            Assert:IsTrue(proc:Functions:Count > 0).
        END.
        ELSE
        DO:
            Assert:Fail("Incompatible object type returned").
        END.
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT insp.
        IF VALID-OBJECT(base) THEN DELETE OBJECT base.
        IF VALID-OBJECT(proc) THEN DELETE OBJECT proc.
    END METHOD.

END CLASS.