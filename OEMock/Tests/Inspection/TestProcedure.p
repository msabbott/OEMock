/*------------------------------------------------------------------------
    File        : TestProcedure.p
    Purpose     : A basic procedure used in testing. No required logic
                  should be contained in this file.
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

ROUTINE-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE ttTempTable NO-UNDO
    FIELD KeyField AS INTEGER
    INDEX PriKey IS PRIMARY UNIQUE KeyField ASCENDING.
    
DEFINE TEMP-TABLE ttChildTable NO-UNDO
    FIELD KeyField AS INTEGER
    FIELD ChildField AS CHARACTER
    FIELD DataField  AS CHARACTER
    INDEX PriKey IS PRIMARY UNIQUE KeyField ASCENDING ChildField ASCENDING.
    
DEFINE DATASET dsTempData
    FOR ttTempTable, ttChildTable
    DATA-RELATION FOR ttTempTable, ttChildTable
        RELATION-FIELDS(KeyField,KeyField).

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