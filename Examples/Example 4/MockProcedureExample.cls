/*------------------------------------------------------------------------
    File        : MockProcedureExample
    Purpose     : Example showing how to use OEMock:MockProcedure. 
    Notes       : This example requires that OEMock and OEUnit are already
                  on the ProPath.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.*.
USING OEUnit.Assertion.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS "Examples.Example 4.MockProcedureExample":
    
    DEFINE PROTECTED VARIABLE TestHandle AS HANDLE NO-UNDO.
    
    @Before.
    METHOD PUBLIC VOID CreateTestHandle():
        RUN VALUE("Examples/Example 4/ProcedureToTest.p") PERSISTENT SET TestHandle.
    END METHOD.
    
    @After.
    METHOD PUBLIC VOID DeleteTestHandle():
        IF VALID-HANDLE(TestHandle) THEN DELETE OBJECT TestHandle.
    END METHOD.

    @Test.
    METHOD PUBLIC VOID TestGetUserNameIsCalled():
        
        DEFINE VARIABLE MessageText AS CHARACTER NO-UNDO.
        DEFINE VARIABLE mck         AS OEMock.Mock NO-UNDO.
        
        /* Ask OEMock to generate a Mock object for the required procedure */
        mck = OEMock:MockProcedure("Examples/Example 4/ProcedureToMock.p").

        /* Set the output parameter value for parameter 'UserName' in the procedure "GetUserName". */
        mck:SetProcedureOutputParameterValue("GetUserName", "UserName", "Mary Jones").
        
        /* Set expectation that the "GetUserName" procedure will be run at least once */
        mck:Expect("GetUserName"):CalledAtLeast(1).
        
        /* Generate the Mock procedure file */
        mck:Generate().

        /* Run procedure and verify the expected outcome */
        RUN SayHello IN TestHandle(OUTPUT MessageText).
        Assert:AreEqual(MessageText, "Hello, Mary Jones").
        
        /* Assert that any expectations were met */
        mck:AssertIsSatisfied().

        FINALLY:
            /* Mock object is no longer required so delete */
            IF VALID-OBJECT(mck) THEN DELETE OBJECT mck.
            
            /* Test completed, tell OEMock to run the clean-up process */
            OEMock:CleanUp().
        END.
    END METHOD.

END CLASS.