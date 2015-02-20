 /*------------------------------------------------------------------------
    File        : StubTester
    Purpose     : Unit Tests for Stub test double class.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Stub.
USING OEMock.Reflection.*.
USING OEMock.Inspection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.StubTester: 
    
    DEFINE PROTECTED VARIABLE TestDir AS CHARACTER NO-UNDO INITIAL "tests/".
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsFile():
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        DEFINE VARIABLE fil AS ClassFile NO-UNDO.
        
        fil = NEW ClassFile('OEMock/Tests/Util/ListObject.cls', 'OEMock.Tests.Util.ListObject').
        stb = NEW Stub(fil, TestDir).
        
        Assert:IsTrue(VALID-OBJECT(stb:File)).
        Assert:AreEqual(stb:File, fil).
        
        IF VALID-OBJECT(fil) THEN DELETE OBJECT(fil).
        IF VALID-OBJECT(stb) THEN DELETE OBJECT(stb).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesDirectory():
        DEFINE VARIABLE stb AS Stub NO-UNDO.
        DEFINE VARIABLE fil AS ClassFile  NO-UNDO.
        
        fil = NEW ClassFile('OEMock/Tests/Util/ListObject.cls', 'OEMock.Tests.Util.ListObject').
        stb = NEW Stub(fil, TestDir).
        
        stb:Generate().
        
        FILE-INFO:FILE-NAME = TestDir + "OEMock/Tests/Util/".
        Assert:AreEqual(FILE-INFO:FILE-TYPE, "DRW").

        IF VALID-OBJECT(fil) THEN DELETE OBJECT(fil).
        IF VALID-OBJECT(stb) THEN DELETE OBJECT(stb).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesFile():
        DEFINE VARIABLE stb  AS Stub NO-UNDO.
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        insp = NEW ClassInspector('OEMock/Tests/Util/ListObject.cls').
        stb = NEW Stub(insp:Inspect(), TestDir).
        
        stb:Generate().
        
        FILE-INFO:FILE-NAME = TestDir + "OEMock/Tests/Util/ListObject.cls".
        Assert:AreEqual(FILE-INFO:FILE-TYPE, "FRW").

        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(stb)  THEN DELETE OBJECT(stb).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID DestructorDeletesFile():
        DEFINE VARIABLE stb  AS Stub NO-UNDO.
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        insp = NEW ClassInspector('OEMock/Tests/Util/ListObject.cls').
        stb = NEW Stub(insp:Inspect(), TestDir).
        
        stb:Generate().

        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(stb)  THEN DELETE OBJECT(stb).
        
        FILE-INFO:FILE-NAME = TestDir + "OEMock/Tests/Util/ListObject.cls".
        Assert:IsNull(FILE-INFO:FILE-TYPE).
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