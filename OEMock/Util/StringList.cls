/*------------------------------------------------------------------------
    File        : StringList
    Purpose     : Defines a basic string list using CHARACTER variables.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Util.StringList:
    
    DEFINE PROTECTED VARIABLE NextOrd AS INTEGER NO-UNDO INITIAL 1.
    
    DEFINE PROTECTED TEMP-TABLE ttItem NO-UNDO
        FIELD ord    AS INTEGER
        FIELD String AS CHARACTER
            INDEX PriKey IS PRIMARY UNIQUE ord ASCENDING.
    
    DEFINE PUBLIC PROPERTY Count AS INTEGER NO-UNDO 
    GET():
        DEFINE VARIABLE cnt AS INTEGER NO-UNDO.
        FOR EACH ttItem NO-LOCK:
            ASSIGN cnt = cnt + 1.
        END.
        RETURN cnt.
    END GET.

	CONSTRUCTOR PUBLIC StringList():
		SUPER().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC StringList():
	    EmptyList().
	END DESTRUCTOR.
	
	METHOD PUBLIC LOGICAL Add(INPUT str AS CHARACTER):
	    
	    IF str NE ? AND TRIM(str) NE "" THEN
	    DO:
            CREATE ttItem.
	        ASSIGN ttItem.String = str
	               ttItem.Ord    = NextOrd
	               NextOrd       = NextOrd + 1.
	        
	        RETURN TRUE.
	    END.
	    
	    RETURN FALSE.
	    
	END METHOD.
	
	METHOD PUBLIC VOID EmptyList():
        EMPTY TEMP-TABLE ttItem.
	END METHOD.
	
	METHOD PUBLIC CHARACTER MoveFirst():
	    DEFINE VARIABLE res AS CHARACTER NO-UNDO INITIAL "".
	    FIND FIRST ttItem NO-LOCK NO-ERROR.
	    IF AVAILABLE ttItem THEN
	    DO:
	        ASSIGN res = ttItem.String.
	    END.
	    RETURN res.
	END METHOD.
	
    METHOD PUBLIC CHARACTER MoveLast():
        DEFINE VARIABLE res AS CHARACTER NO-UNDO INITIAL "".
        FIND LAST ttItem NO-LOCK NO-ERROR.
        IF AVAILABLE ttItem THEN
        DO:
            ASSIGN res = ttItem.String.
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC CHARACTER MoveNext():
        DEFINE VARIABLE res AS CHARACTER NO-UNDO INITIAL "".
        FIND NEXT ttItem NO-LOCK NO-ERROR.
        IF AVAILABLE ttItem THEN
        DO:
            ASSIGN res = ttItem.String.
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC CHARACTER MovePrev():
        DEFINE VARIABLE res AS CHARACTER NO-UNDO INITIAL "".
        FIND PREV ttItem NO-LOCK NO-ERROR.
        IF AVAILABLE ttItem THEN
        DO:
            ASSIGN res = ttItem.String.
        END.
        RETURN res.
    END METHOD.
END CLASS.