/*------------------------------------------------------------------------
    File        : OEMockTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.OEMockTester:
    
    @Before.
    METHOD PUBLIC VOID ResetDebugMode():
        OEMock:DebugMode = FALSE.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID CleanUpClearsOutputDirectory():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        
        stb = OEMock:StubClass('OEMock/Tests/Util/ListObject.cls').
        
        OEMock:CleanUp().
        
        Assert:IsNull(OEMock:OutputDir).
        
        IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
    END.
    
    @Test.
    METHOD PUBLIC VOID CleanUpDeletesOutputDirectory():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        DEFINE VARIABLE tmpDir AS CHARACTER NO-UNDO.
        
        stb = OEMock:StubClass('OEMock/Tests/Util/ListObject.cls').
        
        tmpDir = OEMock:OutputDir.
        
        OEMock:CleanUp().
        
        FILE-INFO:FILE-NAME = tmpDir.
        Assert:IsNull(FILE-INFO:FILE-TYPE).
        
        IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
    END.
    
    @Test.
    METHOD PUBLIC VOID CleanUpRemovesFromPropath():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        DEFINE VARIABLE tmpDir AS CHARACTER NO-UNDO.
        
        stb = OEMock:StubClass('OEMock/Tests/Util/ListObject.cls').
        
        tmpDir = OEMock:OutputDir.
        
        OEMock:CleanUp().
        
        Assert:AreEqual(LOOKUP(PROPATH, tmpDir), 0).
        
        IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
        
    END.
    
    @Test.
    METHOD PUBLIC VOID StubClassSetsOutputDirectory():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        
        stb = OEMock:StubClass('OEMock/Tests/Util/ListObject.cls').
        
        Assert:IsNotNull(OEMock:OutputDir).
        
        IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
        OEMock:CleanUp().
    END.
    
    @Test.
    METHOD PUBLIC VOID StubClassSetsPropath():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        DEFINE VARIABLE tmpDir AS CHARACTER NO-UNDO.
        
        stb = OEMock:StubClass('OEMock/Tests/Util/ListObject.cls').
        
        tmpDir = OEMock:OutputDir.
        
        Assert:AreNotEqual(LOOKUP(tmpDir, PROPATH), 0).
        
        IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
        OEMock:CleanUp().
    END.
    
    @Test.
    METHOD PUBLIC VOID StubClassReturnsValidClass():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        
        stb = OEMock:StubClass('OEMock/Tests/Util/ListObject.cls').
        
        Assert:IsTrue(VALID-OBJECT(stb)).
        
        IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
        OEMock:CleanUp().
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID StubProcedureSetsOutputDirectory():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.

        stb = OEMock:StubProcedure('OEMock/Tests/Inspection/TestProcedure.p').
        
        Assert:IsNotNull(OEMock:OutputDir).
        
        IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
        OEMock:CleanUp().
    END.
    
    @Test.
    METHOD PUBLIC VOID StubProcedureReturnsValidClass():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        
        stb = OEMock:StubProcedure('OEMock/Tests/Inspection/TestProcedure.p').
        
        Assert:IsTrue(VALID-OBJECT(stb)).
        
        IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
        OEMock:CleanUp().
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID StubProcedureSetsPropath():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        DEFINE VARIABLE tmpDir AS CHARACTER NO-UNDO.
        
        stb = OEMock:StubProcedure('OEMock/Tests/Inspection/TestProcedure.p').
        
        tmpDir = OEMock:OutputDir.
        
        Assert:AreNotEqual(LOOKUP(tmpDir, PROPATH), 0).

        IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
        OEMock:CleanUp().
    END.
    
    @Test.
    METHOD PUBLIC VOID CodeIsLoadedFromStubProcedure():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        DEFINE VARIABLE procName AS CHARACTER NO-UNDO INITIAL 'OEMock/Tests/Inspection/TestProcedure.p'.
        DEFINE VARIABLE hProc AS HANDLE NO-UNDO.
        
        stb = OEMock:StubProcedure(procName).
        stb:Generate().

        RUN VALUE(procName) PERSISTENT SET hProc.

        Assert:AreEqual(DYNAMIC-FUNCTION("TestFunction" IN hProc), "").        
        
        IF VALID-OBJECT(stb)   THEN DELETE OBJECT stb.
        IF VALID-HANDLE(hProc) THEN DELETE OBJECT hProc.
        OEMock:CleanUp().
    END.
    
    @Test.
    METHOD PUBLIC VOID MockClassSetsOutputDirectory():
        
        DEFINE VARIABLE mck AS Mock NO-UNDO.
        
        mck = OEMock:MockClass('OEMock/Tests/Util/ListObject.cls').
        
        Assert:IsNotNull(OEMock:OutputDir).
        
        IF VALID-OBJECT(mck) THEN DELETE OBJECT mck.
        OEMock:CleanUp().
    END.
    
    @Test.
    METHOD PUBLIC VOID MockClassSetsPropath():
        
        DEFINE VARIABLE mck AS Mock NO-UNDO.
        DEFINE VARIABLE tmpDir AS CHARACTER NO-UNDO.
        
        mck = OEMock:MockClass('OEMock/Tests/Util/ListObject.cls').
        
        tmpDir = OEMock:OutputDir.
        
        Assert:AreNotEqual(LOOKUP(tmpDir, PROPATH), 0).
        
        IF VALID-OBJECT(mck) THEN DELETE OBJECT mck.
        OEMock:CleanUp().
    END.
    
    @Test.
    METHOD PUBLIC VOID MockClassReturnsValidClass():
        
        DEFINE VARIABLE mck AS Mock NO-UNDO.
        
        mck = OEMock:MockClass('OEMock/Tests/Util/ListObject.cls').
        
        Assert:IsTrue(VALID-OBJECT(mck)).
        
        IF VALID-OBJECT(mck) THEN DELETE OBJECT mck.
        OEMock:CleanUp().
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MockProcedureSetsOutputDirectory():
        
        DEFINE VARIABLE mck AS Mock NO-UNDO.

        mck = OEMock:MockProcedure('OEMock/Tests/Inspection/TestProcedure.p').
        
        Assert:IsNotNull(OEMock:OutputDir).
        
        IF VALID-OBJECT(mck) THEN DELETE OBJECT mck.
        OEMock:CleanUp().
    END.
    
    @Test.
    METHOD PUBLIC VOID MockProcedureReturnsValidClass():
        
        DEFINE VARIABLE mck AS Mock NO-UNDO.
        
        mck = OEMock:MockProcedure('OEMock/Tests/Inspection/TestProcedure.p').
        
        Assert:IsTrue(VALID-OBJECT(mck)).
        
        IF VALID-OBJECT(mck) THEN DELETE OBJECT mck.
        OEMock:CleanUp().
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MockProcedureSetsPropath():
        
        DEFINE VARIABLE mck AS Mock NO-UNDO.
        DEFINE VARIABLE tmpDir AS CHARACTER NO-UNDO.
        
        mck = OEMock:MockProcedure('OEMock/Tests/Inspection/TestProcedure.p').
        
        tmpDir = OEMock:OutputDir.
        
        Assert:AreNotEqual(LOOKUP(tmpDir, PROPATH), 0).

        IF VALID-OBJECT(mck) THEN DELETE OBJECT mck.
        OEMock:CleanUp().
    END.
    
    @Test.
    METHOD PUBLIC VOID CodeIsLoadedFromMockProcedure():
        
        DEFINE VARIABLE mck AS Mock NO-UNDO.
        DEFINE VARIABLE procName AS CHARACTER NO-UNDO INITIAL 'OEMock/Tests/Inspection/TestProcedure.p'.
        DEFINE VARIABLE hProc AS HANDLE NO-UNDO.

        mck = OEMock:MockProcedure(procName).
        mck:Generate().

        RUN VALUE(procName) PERSISTENT SET hProc.

        Assert:AreEqual(DYNAMIC-FUNCTION("TestFunction" IN hProc), "").        
       
        IF VALID-OBJECT(mck)   THEN DELETE OBJECT mck.
        IF VALID-HANDLE(hProc) THEN DELETE OBJECT hProc.
        OEMock:CleanUp().
    END.
    
END CLASS.