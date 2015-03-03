/*------------------------------------------------------------------------
    File        : StubClassExample
    Purpose     : Example showing how to use OEMock:StubProcedure. 
    Notes       : This example requires that OEMock and OEUnit are already
                  on the ProPath.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING "Examples.Example 3.*".
USING OEMock.*.
USING OEUnit.Assertion.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS "Examples.Example 3.StubClassExample": 

    @Test.
    METHOD PUBLIC VOID TestWithoutStub():
        
        DEFINE VARIABLE clsHello    AS ClassToTest NO-UNDO.
        DEFINE VARIABLE MessageText AS CHARACTER NO-UNDO.
        
        clsHello = NEW ClassToTest().
        
        /* The below test passes, however, we know that there are
         * some other code paths that are executed inside of SayHello
         * but because we cannot set the return value of GetUserName
         * in ClassToStub, then we cannot test them this way
         */
        MessageText = clsHello:SayHello().
        Assert:AreEqual(MessageText, "Hello, Joe Bloggs Jnr.").
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID TestWithStub():
        
        DEFINE VARIABLE stb         AS OEMock.Stub NO-UNDO.
        DEFINE VARIABLE clsHello    AS ClassToTest NO-UNDO.
        DEFINE VARIABLE MessageText AS CHARACTER NO-UNDO.
        
        clsHello = NEW ClassToTest().
        
        /* Ask OEMock to generate a stub object for the required class */
        stb = OEMock:StubClass("Examples/Example 3/ClassToStub.cls").

        /* Set the return value for the method "GetUserName". */
        stb:SetMethodReturnValue("GetUserName", "Mary Jones").
        
        /* Generate the Stub class */
        stb:Generate().

        MessageText = clsHello:SayHello().
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
        
        DEFINE VARIABLE stb         AS OEMock.Stub NO-UNDO.
        DEFINE VARIABLE clsHello    AS ClassToTest NO-UNDO.
        DEFINE VARIABLE MessageText AS CHARACTER NO-UNDO.
        
        clsHello = NEW ClassToTest().
        
        /* Ask OEMock to generate a stub object for the required class */
        stb = OEMock:StubClass("Examples/Example 3/ClassToStub.cls").

        /* Set the return value for the method "GetUserName". */
        stb:SetMethodReturnValue("GetUserName", "").
        
        /* Generate the Stub class */
        stb:Generate().

        MessageText = clsHello:SayHello().
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
        
        DEFINE VARIABLE stb         AS OEMock.Stub NO-UNDO.
        DEFINE VARIABLE clsHello    AS ClassToTest NO-UNDO.
        DEFINE VARIABLE MessageText AS CHARACTER NO-UNDO.
        
        clsHello = NEW ClassToTest().
        
        /* Ask OEMock to generate a stub object for the required class */
        stb = OEMock:StubClass("Examples/Example 3/ClassToStub.cls").

        /* Set the return value for the method "GetUserName". */
        stb:SetMethodReturnValue("GetUserName", ?).
        
        /* Generate the Stub class */
        stb:Generate().

        MessageText = clsHello:SayHello().
        Assert:AreEqual(MessageText, "Hello World").

        FINALLY:
            /* Stub object is no longer required so delete */
            IF VALID-OBJECT(stb) THEN DELETE OBJECT stb.
            
            /* Test completed, tell OEMock to run the clean-up process */
            OEMock:CleanUp().
        END.
    END METHOD.

END CLASS.