/*------------------------------------------------------------------------
    File        : ProcedureToTest.p
    Purpose     : This file represents a file that is to be tested
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

ROUTINE-LEVEL ON ERROR UNDO, THROW.

{"Examples/Example 2/IncludeFileToStub.i"}

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

PROCEDURE SayHello:
    
    DEFINE OUTPUT PARAMETER MessageText AS CHARACTER NO-UNDO.
    
    RUN GetUserName (OUTPUT MessageText).
    
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