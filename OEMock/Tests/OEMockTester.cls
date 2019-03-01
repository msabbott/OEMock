/*------------------------------------------------------------------------
    File        : OEMockTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.OEMockTester:
    
    DEFINE PROTECTED TEMP-TABLE ttTempTable NO-UNDO
        FIELD KeyField AS INTEGER
        INDEX PriKey IS PRIMARY UNIQUE KeyField ASCENDING.
    
    DEFINE PROTECTED TEMP-TABLE ttChildTable NO-UNDO
        FIELD KeyField AS INTEGER
        FIELD ChildField AS CHARACTER
        FIELD DataField  AS CHARACTER
        INDEX PriKey IS PRIMARY UNIQUE KeyField ASCENDING ChildField ASCENDING.

    // MethodCall, MethodCallParam and MethodCalls all used for testing OEMock:CleanUp
    DEFINE TEMP-TABLE MethodCall NO-UNDO
        FIELD CallNumber      AS INTEGER
        FIELD MethodReference AS CHARACTER
        FIELD NumCalls        AS INTEGER
            INDEX PriKey  IS PRIMARY UNIQUE CallNumber      ASCENDING
            INDEX MethKey                   MethodReference ASCENDING.
            
    DEFINE TEMP-TABLE MethodCallParam NO-UNDO
        FIELD CallNumber AS INTEGER
        FIELD ParamName  AS CHARACTER
        FIELD ParamValue AS CHARACTER
            INDEX PriKey IS PRIMARY UNIQUE CallNumber ASCENDING ParamName ASCENDING
            INDEX ValKey                   CallNumber ASCENDING ParamName ASCENDING ParamValue.
            
    DEFINE DATASET MethodCalls
        FOR MethodCall, MethodCallParam
        DATA-RELATION callparams 
                  FOR MethodCall, MethodCallParam
                      RELATION-FIELDS (CallNumber,CallNumber).        
    
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
    
    METHOD PRIVATE INTEGER CountMethodCalls(INPUT methRef AS CHARACTER):
        
        DEFINE VARIABLE counter AS INTEGER NO-UNDO INITIAL 0.
        
        FOR EACH MethodCall NO-LOCK
           WHERE MethodCall.MethodReference = methRef:
        
            ASSIGN counter = counter + 1.      
         
        END.
        
        RETURN counter.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID CleanUpClearsOEMockCallRegister():
        
        OEMockRegister:ClearMethodCallRegister().
        OEMockRegister:RegisterMethodCall("test method").
        
        OEMockRegister:ReceiveMethodCallRegister(OUTPUT DATASET MethodCalls).
        Assert:AreEqual(CountMethodCalls("test method"), 1).
        
        OEMock:CleanUp().
        
        OEMockRegister:ReceiveMethodCallRegister(OUTPUT DATASET MethodCalls).
        Assert:AreEqual(CountMethodCalls("test method"), 0).
        
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
        stb:AddTempTable(TEMP-TABLE ttTempTable:HANDLE).
        stb:AddTempTable(TEMP-TABLE ttChildTable:HANDLE).
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
        mck:AddTempTable(TEMP-TABLE ttTempTable:HANDLE).
        mck:AddTempTable(TEMP-TABLE ttChildTable:HANDLE).
        mck:Generate().

        RUN VALUE(procName) PERSISTENT SET hProc.

        Assert:AreEqual(DYNAMIC-FUNCTION("TestFunction" IN hProc), "").        
       
        IF VALID-OBJECT(mck)   THEN DELETE OBJECT mck.
        IF VALID-HANDLE(hProc) THEN DELETE OBJECT hProc.
        OEMock:CleanUp().
    END.
    
END CLASS.