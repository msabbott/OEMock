/*------------------------------------------------------------------------
    File        : BaseDoubleTester
    Purpose     : Unit test for BaseDouble class. 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.BaseDouble.
USING OEMock.Reflection.*.
USING OEMock.Inspection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.BaseDoubleTester:
    
    DEFINE PROTECTED VARIABLE TestDir AS CHARACTER NO-UNDO INITIAL "tests/".
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsFile():
        DEFINE VARIABLE dbl AS BaseDouble NO-UNDO.
        DEFINE VARIABLE fil AS ClassFile  NO-UNDO.
        
        fil = NEW ClassFile('OEMock/Tests/Util/ListObject.cls', 'OEMock.Tests.Util.ListObject').
        dbl = NEW BaseDouble(fil, TestDir).
        
        Assert:IsTrue(VALID-OBJECT(dbl:File)).
        Assert:AreEqual(dbl:File, fil).
        
        IF VALID-OBJECT(fil) THEN DELETE OBJECT(fil).
        IF VALID-OBJECT(dbl) THEN DELETE OBJECT(dbl).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDeleteOnDestruct():
        DEFINE VARIABLE dbl AS BaseDouble NO-UNDO.
        DEFINE VARIABLE fil AS ClassFile  NO-UNDO.
        
        fil = NEW ClassFile('OEMock/Tests/Util/ListObject.cls', 'OEMock.Tests.Util.ListObject').
        dbl = NEW BaseDouble(fil, TestDir).
        
        Assert:IsTrue(dbl:DeleteOnDestruct).

        IF VALID-OBJECT(fil) THEN DELETE OBJECT(fil).
        IF VALID-OBJECT(dbl) THEN DELETE OBJECT(dbl).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesDirectory():
        DEFINE VARIABLE dbl AS BaseDouble NO-UNDO.
        DEFINE VARIABLE fil AS ClassFile  NO-UNDO.
        
        fil = NEW ClassFile('OEMock/Tests/Util/ListObject.cls', 'OEMock.Tests.Util.ListObject').
        dbl = NEW BaseDouble(fil, TestDir).
        
        dbl:Generate().
        
        FILE-INFO:FILE-NAME = TestDir + "OEMock/Tests/Util/".
        Assert:AreEqual(FILE-INFO:FILE-TYPE, "DRW").

        IF VALID-OBJECT(fil) THEN DELETE OBJECT(fil).
        IF VALID-OBJECT(dbl) THEN DELETE OBJECT(dbl).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesFile():
        DEFINE VARIABLE dbl  AS BaseDouble NO-UNDO.
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        insp = NEW ClassInspector('OEMock/Tests/Util/ListObject.cls').
        dbl = NEW BaseDouble(insp:Inspect(), TestDir).
        
        dbl:Generate().
        
        FILE-INFO:FILE-NAME = TestDir + "OEMock/Tests/Util/ListObject.cls".
        Assert:AreEqual(FILE-INFO:FILE-TYPE, "FRW").

        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(dbl)  THEN DELETE OBJECT(dbl).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID DestructorDeletesFile():
        DEFINE VARIABLE dbl  AS BaseDouble NO-UNDO.
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        insp = NEW ClassInspector('OEMock/Tests/Util/ListObject.cls').
        dbl = NEW BaseDouble(insp:Inspect(), TestDir).
        
        dbl:Generate().

        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(dbl)  THEN DELETE OBJECT(dbl).
        
        FILE-INFO:FILE-NAME = TestDir + "OEMock/Tests/Util/ListObject.cls".
        Assert:IsNull(FILE-INFO:FILE-TYPE).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID DestructorLeavesFileWhenDeleteOnDestructIsFalse():
        DEFINE VARIABLE dbl  AS BaseDouble NO-UNDO.
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        insp = NEW ClassInspector('OEMock/Tests/Util/ListObject.cls').
        dbl = NEW BaseDouble(insp:Inspect(), TestDir).
        dbl:DeleteOnDestruct = FALSE.
        
        dbl:Generate().

        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(dbl)  THEN DELETE OBJECT(dbl).
        
        FILE-INFO:FILE-NAME = TestDir + "OEMock/Tests/Util/ListObject.cls".
        Assert:IsNotNull(FILE-INFO:FILE-TYPE).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddProcedureParameterAddsToProcedureFileParameters():
        DEFINE VARIABLE dbl AS BaseDouble NO-UNDO.
        DEFINE VARIABLE insp AS ProcedureInspector NO-UNDO.
        DEFINE VARIABLE procFile AS ProcedureFile NO-UNDO.
        
        insp = NEW ProcedureInspector('OEMock/Tests/Inspection/TestProcedure.p').
        dbl = NEW BaseDouble(insp:Inspect(), TestDir).
        
        dbl:AddProcedureParameter(INPUT "INPUT", INPUT "ProcParam", INPUT "CHARACTER").
        
        procFile = DYNAMIC-CAST(dbl:File, dbl:File:GetClass():TypeName).
        
        Assert:AreEqual(procFile:Parameters:Count, 1).
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(dbl)  THEN DELETE OBJECT(dbl). 
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddProcedureBufferParameterAddsToProcedureFileParameters():
        DEFINE VARIABLE dbl AS BaseDouble NO-UNDO.
        DEFINE VARIABLE insp AS ProcedureInspector NO-UNDO.
        DEFINE VARIABLE procFile AS ProcedureFile NO-UNDO.
        
        insp = NEW ProcedureInspector('OEMock/Tests/Inspection/TestProcedure.p').
        dbl = NEW BaseDouble(insp:Inspect(), TestDir).
        
        dbl:AddProcedureBufferParameter(INPUT "BufferName", INPUT "TableName").
        
        procFile = DYNAMIC-CAST(dbl:File, dbl:File:GetClass():TypeName).
        
        Assert:AreEqual(procFile:Parameters:Count, 1).
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(dbl)  THEN DELETE OBJECT(dbl). 
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddProcedureDatasetParameterAddsToProcedureFileParameters():
        DEFINE VARIABLE dbl AS BaseDouble NO-UNDO.
        DEFINE VARIABLE insp AS ProcedureInspector NO-UNDO.
        DEFINE VARIABLE procFile AS ProcedureFile NO-UNDO.
        
        insp = NEW ProcedureInspector('OEMock/Tests/Inspection/TestProcedure.p').
        dbl = NEW BaseDouble(insp:Inspect(), TestDir).
        
        dbl:AddProcedureDataSetParameter(INPUT "DataSetName").
        
        procFile = DYNAMIC-CAST(dbl:File, dbl:File:GetClass():TypeName).
        
        Assert:AreEqual(procFile:Parameters:Count, 1).
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(dbl)  THEN DELETE OBJECT(dbl). 
    END METHOD.
    
    @AfterClass.
    METHOD PUBLIC VOID DeleteTestDirectory():
        FILE-INFO:FILE-NAME = TestDir.
        IF FILE-INFO:FILE-TYPE MATCHES "D*W*" THEN
        DO:
            OS-DELETE VALUE(TestDir) RECURSIVE.
        END.
    END METHOD.
    

END CLASS.