/*------------------------------------------------------------------------
    File        : ProcedureToStub.p
    Purpose     : Procedure that will be stubbed out in tests.
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

ROUTINE-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

PROCEDURE GetUserName:
    
    DEFINE OUTPUT PARAMETER UserName AS CHARACTER NO-UNDO.
    
    /* For the purposes of this example, this is set to a simple string */
    ASSIGN UserName = "Joe Bloggs Jnr.".
    
END PROCEDURE.