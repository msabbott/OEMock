/*------------------------------------------------------------------------
    File        : ProcedureToTest.p
    Purpose     : This file represents a file that is to be tested
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

ROUTINE-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

PROCEDURE SayHello:
    
    DEFINE OUTPUT PARAMETER MessageText AS CHARACTER NO-UNDO.
    
    DEFINE VARIABLE ProcHandle AS HANDLE NO-UNDO.
    
    RUN VALUE("Examples/Example 4/ProcedureToMock.p") PERSISTENT SET ProcHandle.
    
    RUN GetUserName IN ProcHandle (OUTPUT MessageText).
    
    IF VALID-HANDLE(ProcHandle) THEN DELETE OBJECT ProcHandle.
    
    CASE MessageText:

        WHEN ? THEN
        DO:
            ASSIGN MessageText = "Hello World".
        END.
        
        WHEN "" THEN
        DO:
            ASSIGN MessageText = "Hello, person with no name".
        END.
        
        OTHERWISE
        DO:
            ASSIGN MessageText = "Hello, " + MessageText.
        END.
    END CASE.
    
END PROCEDURE.