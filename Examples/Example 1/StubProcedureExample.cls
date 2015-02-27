/*------------------------------------------------------------------------
    File        : StubProcedureExample
    Purpose     : Example showing how to use OEMock:StubProcedure. 
    Notes       : This example requires that OEMock and OEUnit are already
                  on the ProPath.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.*.
USING OEUnit.Assertion.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS "Examples.Example 1.StubProcedureExample":
    
    DEFINE PROTECTED VARIABLE TestHandle AS HANDLE NO-UNDO.
    
    @Before.
    METHOD PUBLIC VOID CreateTestHandle():
        RUN VALUE("Examples/Example 1/ProcedureToTest.p") PERSISTENT SET TestHandle.
    END METHOD.
    
    @After.
    METHOD PUBLIC VOID DeleteTestHandle():
        IF VALID-HANDLE(TestHandle) THEN DELETE OBJECT TestHandle.
    END METHOD.

    @Test.
    METHOD PUBLIC VOID TestWithoutStub():
        
        DEFINE VARIABLE MessageText AS CHARACTER NO-UNDO.
        
        /* The below test passes, however, we know that there are
         * some other code paths that are executed inside of SayHello
         * but because we cannot set the return value of GetUserName
         * in ProcedureToStub.p, then we cannot test them this way
         */
        RUN SayHello IN TestHandle(OUTPUT MessageText).
        Assert:AreEqual(MessageText, "Hello, Joe Bloggs Jnr.").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID TestWithStub():
        
        DEFINE VARIABLE MessageText AS CHARACTER NO-UNDO.
        DEFINE VARIABLE stb AS OEMock.Stub NO-UNDO.
        
        /* Ask OEMock to generate a stub object for the required procedure */
        stb = OEMock:StubProcedure("Examples/Example 1/ProcedureToStub.p").

        /* Set the output parameter value for parameter 'UserName' in the procedure "GetUserName". */
        stb:SetProcedureOutputParameterValue("GetUserName", "UserName", "Mary Jones").
        
        /* Generate the Stub procedure file */
        stb:Generate().

        RUN SayHello IN TestHandle(OUTPUT MessageText).
        Assert:AreEqual(MessageText, "Hello, Mary Jones").

        FINALLY:
            /* Stub object is no longer required so delete */
            IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
            
            /* Test completed, tell OEMock to run the clean-up process */
            OEMock:CleanUp().
        END.
    END METHOD.
    
    /* Using the same logic as 'TestWithStub', we can reinitialise and test
     * the effect of returning a blank string from 'GetUserName'
     */
    @Test.
    METHOD PUBLIC VOID TestWithStub_BlankOutput():
        
        DEFINE VARIABLE MessageText AS CHARACTER NO-UNDO.
        DEFINE VARIABLE stb AS OEMock.Stub NO-UNDO.
        
        /* Ask OEMock to generate a stub object for the required procedure */
        stb = OEMock:StubProcedure("Examples/Example 1/ProcedureToStub.p").

        /* Set the output parameter value for parameter 'UserName' in the procedure "GetUserName". */
        stb:SetProcedureOutputParameterValue("GetUserName", "UserName", "").
        
        /* Generate the Stub procedure file */
        stb:Generate().

        RUN SayHello IN TestHandle(OUTPUT MessageText).
        Assert:AreEqual(MessageText, "Hello, person with no name").

        FINALLY:
            /* Stub object is no longer required so delete */
            IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
            
            /* Test completed, tell OEMock to run the clean-up process */
            OEMock:CleanUp().
        END.
    END METHOD.
    
    /* Using the same logic as 'TestWithStub', we can reinitialise and test
     * the effect of returning a null value from 'GetUserName'
     */
    @Test.
    METHOD PUBLIC VOID TestWithStub_NullOutput():
        
        DEFINE VARIABLE MessageText AS CHARACTER NO-UNDO.
        DEFINE VARIABLE stb AS OEMock.Stub NO-UNDO.
        
        /* Ask OEMock to generate a stub object for the required procedure */
        stb = OEMock:StubProcedure("Examples/Example 1/ProcedureToStub.p").

        /* Set the output parameter value for parameter 'UserName' in the procedure "GetUserName". */
        stb:SetProcedureOutputParameterValue("GetUserName", "UserName", ?).
        
        /* Generate the Stub procedure file */
        stb:Generate().

        RUN SayHello IN TestHandle(OUTPUT MessageText).
        Assert:AreEqual(MessageText, "Hello World").

        FINALLY:
            /* Stub object is no longer required so delete */
            IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
            
            /* Test completed, tell OEMock to run the clean-up process */
            OEMock:CleanUp().
        END.
    END METHOD.

END CLASS.