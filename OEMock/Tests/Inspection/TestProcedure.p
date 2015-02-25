/*------------------------------------------------------------------------
    File        : TestProcedure.p
    Purpose     : A basic procedure used in testing. No required logic
                  should be contained in this file.
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

ROUTINE-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */

/* ************************  Function Prototypes ********************** */


FUNCTION TestFunction RETURNS CHARACTER () FORWARD.
FUNCTION TestFunctionWithParams RETURNS CHARACTER(INPUT        Param1 AS CHARACTER,
                                                  OUTPUT       Param2 AS CHARACTER,
                                                  INPUT-OUTPUT Param3 AS CHARACTER) FORWARD.
FUNCTION PrivateFunction RETURNS CHARACTER PRIVATE() FORWARD.

/* *************************** Procedure Implementations  *************************** */

PROCEDURE TestProcedure:
END PROCEDURE.

PROCEDURE TestProcedureWithParams :
    
    DEFINE INPUT PARAMETER        Param1 AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER       Param2 AS CHARACTER NO-UNDO.
    DEFINE INPUT-OUTPUT PARAMETER Param3 AS CHARACTER NO-UNDO.
    
END PROCEDURE.

PROCEDURE PrivateProcedure PRIVATE:
END PROCEDURE.


/* ***************************  Function Implementations *************************** */

FUNCTION TestFunction RETURNS CHARACTER():
    RETURN "TestFunction Return Value".
END FUNCTION.

FUNCTION TestFunctionWithParams RETURNS CHARACTER(INPUT        Param1 AS CHARACTER,
                                                  OUTPUT       Param2 AS CHARACTER,
                                                  INPUT-OUTPUT Param3 AS CHARACTER):
    RETURN "".
END FUNCTION.

FUNCTION PrivateFunction RETURNS CHARACTER PRIVATE():
    RETURN "".
END FUNCTION.