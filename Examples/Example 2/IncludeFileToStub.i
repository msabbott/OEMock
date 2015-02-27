
/*------------------------------------------------------------------------
    File        : ProcedureToStub.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : Mark Abbott
    Created     : Fri Feb 27 13:28:39 GMT 2015
    Notes       :
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