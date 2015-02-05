/*------------------------------------------------------------------------
    File        : Warnings
    Purpose     : Suppress specific warnings on demand 
    Notes       : This code is based on similar code in OEUnit framework.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Util.Warnings:
    
    DEFINE PRIVATE STATIC VARIABLE CodesSuppressed AS CHARACTER NO-UNDO.
    DEFINE PRIVATE STATIC VARIABLE IsSuppressed    AS LOGICAL   NO-UNDO INITIAL FALSE.

    DEFINE PRIVATE STATIC PROPERTY SuppressCodes AS CHARACTER NO-UNDO INITIAL "6430," 
    GET.
 
    METHOD PUBLIC STATIC VOID Suppress():

        IF NOT IsSuppressed THEN
            ASSIGN CodesSuppressed                = SESSION:SUPPRESS-WARNINGS-LIST
                   SESSION:SUPPRESS-WARNINGS-LIST = SuppressCodes + CodesSuppressed
                   IsSuppressed                   = TRUE.

    END METHOD.

    METHOD PUBLIC STATIC VOID Restore():
        
        IF IsSuppressed THEN
            ASSIGN SESSION:SUPPRESS-WARNINGS-LIST = CodesSuppressed
                   IsSuppressed                   = FALSE.
            
    END METHOD.

END CLASS.