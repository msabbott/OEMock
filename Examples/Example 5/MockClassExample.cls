/*------------------------------------------------------------------------
    File        : MockClassExample
    Purpose     : Example showing how to use OEMock:MockProcedure. 
    Notes       : This example requires that OEMock and OEUnit are already
                  on the ProPath.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING "Examples.Example 5.*".
USING OEMock.*.
USING OEUnit.Assertion.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS "Examples.Example 5.MockClassExample": 
    
    @Test.
    METHOD PUBLIC VOID TestGetUserNameIsCalled():
        
        DEFINE VARIABLE mck         AS OEMock.Mock NO-UNDO.
        DEFINE VARIABLE clsHello    AS ClassToTest NO-UNDO.
        DEFINE VARIABLE MessageText AS CHARACTER NO-UNDO.
        
        clsHello = NEW ClassToTest().
        
        /* Ask OEMock to generate a Mock object for the required class */
        mck = OEMock:MockClass("Examples/Example 5/ClassToMock.cls").

        /* Set the return value for the method "GetUserName". */
        mck:SetMethodReturnValue("GetUserName", "Mary Jones").
        
        /* Set expectation that the "GetUserName" method will be called at least once */
        mck:Expect("GetUserName"):CalledAtLeast(1).
        
        /* Generate the Mock class */
        mck:Generate().

        /* Call class method and verify returned value */
        MessageText = clsHello:SayHello().
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