/*------------------------------------------------------------------------
    File        : OEMockTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.OEMockTester:
    
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
    METHOD PUBLIC VOID StubClassSetsOutputDirectory():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        
        stb = OEMock:StubClass('OEMock/Tests/Util/ListObject.cls').
        
        Assert:IsNotNull(OEMock:OutputDir).
        
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
        OEMock:DebugMode = TRUE.
        stb = OEMock:StubProcedure('OEMock/Tests/Inspection/TestProcedure.p').
        
        Assert:IsNotNull(OEMock:OutputDir).
        
        IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
        OEMock:CleanUp().
    END.
    
    @Test.
    METHOD PUBLIC VOID StubProcedureReturnsValidClass():
        
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        OEMock:DebugMode = TRUE.
        stb = OEMock:StubProcedure('OEMock/Tests/Inspection/TestProcedure.p').
        
        Assert:IsTrue(VALID-OBJECT(stb)).
        stb:Generate().
        IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
        OEMock:CleanUp().
        
    END METHOD.
    
END CLASS.