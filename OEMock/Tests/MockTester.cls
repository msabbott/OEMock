 /*------------------------------------------------------------------------
    File        : MockTester
    Purpose     : Unit Tests for Mock test double class.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Mock.
USING OEMock.OEMockRegister.
USING OEMock.Reflection.*.
USING OEMock.Inspection.*.
USING OEMock.Expectation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.MockTester: 
    
    DEFINE PROTECTED VARIABLE TestDir AS CHARACTER NO-UNDO INITIAL "tests/".
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesExpectations():
        DEFINE VARIABLE mck AS Mock NO-UNDO.
        DEFINE VARIABLE fil AS ClassFile NO-UNDO.
        
        fil = NEW ClassFile('OEMock/Tests/Util/ListObject.cls', 'OEMock.Tests.Util.ListObject').
        mck = NEW Mock(fil, TestDir).
        
        Assert:IsTrue(VALID-OBJECT(mck:Expectations)).
        
        IF VALID-OBJECT(fil) THEN DELETE OBJECT(fil).
        IF VALID-OBJECT(mck) THEN DELETE OBJECT(mck).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsFile():
        DEFINE VARIABLE mck AS Mock NO-UNDO.
        DEFINE VARIABLE fil AS ClassFile NO-UNDO.
        
        fil = NEW ClassFile('OEMock/Tests/Util/ListObject.cls', 'OEMock.Tests.Util.ListObject').
        mck = NEW Mock(fil, TestDir).
        
        Assert:IsTrue(VALID-OBJECT(mck:File)).
        Assert:AreEqual(mck:File, fil).
        
        IF VALID-OBJECT(fil) THEN DELETE OBJECT(fil).
        IF VALID-OBJECT(mck) THEN DELETE OBJECT(mck).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesDirectory():
        DEFINE VARIABLE mck AS Mock NO-UNDO.
        DEFINE VARIABLE fil AS ClassFile  NO-UNDO.
        
        fil = NEW ClassFile('OEMock/Tests/Util/ListObject.cls', 'OEMock.Tests.Util.ListObject').
        mck = NEW Mock(fil, TestDir).
        
        mck:Generate().
        
        FILE-INFO:FILE-NAME = TestDir + "OEMock/Tests/Util/".
        Assert:AreEqual(FILE-INFO:FILE-TYPE, "DRW").

        IF VALID-OBJECT(fil) THEN DELETE OBJECT(fil).
        IF VALID-OBJECT(mck) THEN DELETE OBJECT(mck).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesFile():
        DEFINE VARIABLE mck  AS Mock NO-UNDO.
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        insp = NEW ClassInspector('OEMock/Tests/Util/ListObject.cls').
        mck = NEW Mock(insp:Inspect(), TestDir).
        
        mck:Generate().
        
        FILE-INFO:FILE-NAME = TestDir + "OEMock/Tests/Util/ListObject.cls".
        Assert:AreEqual(FILE-INFO:FILE-TYPE, "FRW").

        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(mck)  THEN DELETE OBJECT(mck).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesProcedureFile():
        DEFINE VARIABLE mck  AS Mock NO-UNDO.
        DEFINE VARIABLE insp AS ProcedureInspector NO-UNDO.
        
        insp = NEW ProcedureInspector('OEMock/Tests/Inspection/TestProcedure.p').
        mck = NEW Mock(insp:Inspect(), TestDir).

        mck:Generate().
        
        FILE-INFO:FILE-NAME = TestDir + "OEMock/Tests/Inspection/TestProcedure.p".
        Assert:AreEqual(FILE-INFO:FILE-TYPE, "FRW").

        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(mck)  THEN DELETE OBJECT(mck).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID DestructorDeletesFile():
        DEFINE VARIABLE mck  AS Mock NO-UNDO.
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        insp = NEW ClassInspector('OEMock/Tests/Util/ListObject.cls').
        mck = NEW Mock(insp:Inspect(), TestDir).
        
        mck:Generate().

        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(mck)  THEN DELETE OBJECT(mck).
        
        FILE-INFO:FILE-NAME = TestDir + "OEMock/Tests/Util/ListObject.cls".
        Assert:IsNull(FILE-INFO:FILE-TYPE).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID SetProcedureOutputParameterValueNoErrors():
        /* Assert that no errors are raised by this method */
        DEFINE VARIABLE mck  AS Mock NO-UNDO.
        DEFINE VARIABLE insp AS ProcedureInspector NO-UNDO.
        
        insp = NEW ProcedureInspector('OEMock/Tests/Inspection/TestProcedure.p').
        mck = NEW Mock(insp:Inspect(), TestDir).

        mck:SetProcedureOutputParameterValue("TestProcedureWithParams", "Param2", "MockOutputValue").

        mck:Generate().
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(mck)  THEN DELETE OBJECT(mck).
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID SetFunctionOutputParameterValueNoErrors():
        /* Assert that no errors are raised by this method */
        DEFINE VARIABLE mck  AS Mock NO-UNDO.
        DEFINE VARIABLE insp AS ProcedureInspector NO-UNDO.
        
        insp = NEW ProcedureInspector('OEMock/Tests/Inspection/TestProcedure.p').
        mck = NEW Mock(insp:Inspect(), TestDir).

        mck:SetFunctionOutputParameterValue("TestFunctionWithParams", "Param2", "MockOutputValue").

        mck:Generate().
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(mck)  THEN DELETE OBJECT(mck).
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID SetFunctionReturnValueNoErrors():
        /* Assert that no errors are raised by this method */
        DEFINE VARIABLE mck  AS Mock NO-UNDO.
        DEFINE VARIABLE insp AS ProcedureInspector NO-UNDO.
        
        insp = NEW ProcedureInspector('OEMock/Tests/Inspection/TestProcedure.p').
        mck = NEW Mock(insp:Inspect(), TestDir).

        mck:SetFunctionReturnValue("TestFunctionWithParams", "MockOutputValue").

        mck:Generate().
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(mck)  THEN DELETE OBJECT(mck).
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID SetMethodOutputParameterValueNoErrors():
        /* Assert that no errors are raised by this method */
        DEFINE VARIABLE mck  AS Mock NO-UNDO.
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        insp = NEW ClassInspector('OEMock/Util/StringList.cls').
        mck = NEW Mock(insp:Inspect(), TestDir).

        mck:SetMethodOutputParameterValue("MoveFirst", "Param1", "MockOutputValue").

        mck:Generate().
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(mck)  THEN DELETE OBJECT(mck).
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID SetMethodReturnValueNoErrors():
        /* Assert that no errors are raised by this method */
        DEFINE VARIABLE mck  AS Mock NO-UNDO.
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        insp = NEW ClassInspector('OEMock/Util/StringList.cls').
        mck = NEW Mock(insp:Inspect(), TestDir).

        mck:SetMethodReturnValue("MoveFirst", "MockOutputValue").

        mck:Generate().

        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(mck)  THEN DELETE OBJECT(mck).
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ExpectAddsToExpectations():
        DEFINE VARIABLE mck  AS Mock NO-UNDO.
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        insp = NEW ClassInspector('OEMock/Util/StringList.cls').
        mck = NEW Mock(insp:Inspect(), TestDir).

        Assert:AreEqual(mck:Expectations:Count, 0).
        mck:Expect("TestMethod").
        Assert:AreEqual(mck:Expectations:Count, 1).
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(mck)  THEN DELETE OBJECT(mck).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ExpectReturnsValidExpectation():
        DEFINE VARIABLE mck    AS Mock NO-UNDO.
        DEFINE VARIABLE insp   AS ClassInspector NO-UNDO.
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        insp = NEW ClassInspector('OEMock/Util/StringList.cls').
        mck = NEW Mock(insp:Inspect(), TestDir).

        expect = mck:Expect("TestMethod").
        
        Assert:IsTrue(VALID-OBJECT(expect)).
        Assert:IsTrue(expect:GetClass():IsA("OEMock.Expectation.Expectation")).  
        
        IF VALID-OBJECT(insp)   THEN DELETE OBJECT(insp).
        IF VALID-OBJECT(mck)    THEN DELETE OBJECT(mck).
        IF VALID-OBJECT(expect) THEN DELETE OBJECT(expect).
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AssertIsSatisfiedRaisesNoErrorOnExpectationSuccess():
        DEFINE VARIABLE mck    AS Mock NO-UNDO.
        DEFINE VARIABLE insp   AS ClassInspector NO-UNDO.
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        OEMockRegister:ClearMethodCallRegister().
        
        insp = NEW ClassInspector('OEMock/Util/StringList.cls').
        mck = NEW Mock(insp:Inspect(), TestDir).

        expect = mck:Expect("TestMethod").
        expect:CalledAtLeast(1).
        
        OEMockRegister:RegisterMethodCall("TestMethod").
        
        mck:AssertIsSatisfied().  
        
        FINALLY:
            IF VALID-OBJECT(insp)   THEN DELETE OBJECT(insp).
            IF VALID-OBJECT(mck)    THEN DELETE OBJECT(mck).
            IF VALID-OBJECT(expect) THEN DELETE OBJECT(expect).
        END.
    END METHOD.
    
    @Test(Expected="OEUnit.Assertion.AssertionFailureError"). @Ignore. /* Bad test - cannot override OEUnit Assert failure */
    METHOD PUBLIC VOID AssertIsSatisfiedRaisesErrorOnExpectationFailure():
        DEFINE VARIABLE mck    AS Mock NO-UNDO.
        DEFINE VARIABLE insp   AS ClassInspector NO-UNDO.
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        OEMockRegister:ClearMethodCallRegister().
        
        insp = NEW ClassInspector('OEMock/Util/StringList.cls').
        mck = NEW Mock(insp:Inspect(), TestDir).

        expect = mck:Expect("TestMethod").
        expect:CalledAtMost(1).
        
        OEMockRegister:RegisterMethodCall("TestMethod").
        OEMockRegister:RegisterMethodCall("TestMethod").
        
        mck:AssertIsSatisfied().  
        
        FINALLY:
            IF VALID-OBJECT(insp)   THEN DELETE OBJECT(insp).
            IF VALID-OBJECT(mck)    THEN DELETE OBJECT(mck).
            IF VALID-OBJECT(expect) THEN DELETE OBJECT(expect).
        END.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AssertIsSatisfiedRaisesNoErrorWhenNoExpectations():
        DEFINE VARIABLE mck  AS Mock NO-UNDO.
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        OEMockRegister:ClearMethodCallRegister().
        
        insp = NEW ClassInspector('OEMock/Util/StringList.cls').
        mck = NEW Mock(insp:Inspect(), TestDir).

        OEMockRegister:RegisterMethodCall("TestMethod").
        
        mck:AssertIsSatisfied().  
        
        FINALLY:
            IF VALID-OBJECT(insp) THEN DELETE OBJECT(insp).
            IF VALID-OBJECT(mck)  THEN DELETE OBJECT(mck).
        END.
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