/*------------------------------------------------------------------------
    File        : BaseList
    Purpose     : Defines a basic list. Methods are protected so that they
                  can be exposed by child classes 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Util.BaseList:
    
    DEFINE PROTECTED TEMP-TABLE ttItem NO-UNDO
        FIELD Item AS Progress.Lang.Object.
    
    DEFINE PUBLIC PROPERTY Count AS INTEGER NO-UNDO 
    GET():
        DEFINE VARIABLE cnt AS INTEGER NO-UNDO.
        FOR EACH ttItem NO-LOCK:
            ASSIGN cnt = cnt + 1.
        END.
        RETURN cnt.
    END GET.
		
	DEFINE PUBLIC PROPERTY DestroyOnDestruct AS LOGICAL NO-UNDO INITIAL TRUE 
	GET.
	SET.

	CONSTRUCTOR PUBLIC BaseList():
		SUPER().
		ASSIGN DestroyOnDestruct = TRUE.
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC BaseList():
	    EmptyList().
	END DESTRUCTOR.
	
	METHOD PROTECTED LOGICAL AddItem(INPUT pItem AS Progress.Lang.Object):
	    
	    IF VALID-OBJECT(pItem) THEN
	    DO:
            CREATE ttItem.
	        ASSIGN ttItem.Item = pItem.
	        
	        RETURN TRUE.
	    END.
	    
	    RETURN FALSE.
	    
	END METHOD.
	
	METHOD PROTECTED VOID EmptyList():
        IF DestroyOnDestruct THEN
        DO:
            FOR EACH ttItem EXCLUSIVE-LOCK:
                IF VALID-OBJECT(ttItem.Item) THEN
                    DELETE OBJECT ttItem.Item.
                DELETE ttItem.
            END.
        END.
	END METHOD.
	
	METHOD PROTECTED Progress.Lang.Object GetFirst():
	    DEFINE VARIABLE res AS Progress.Lang.Object NO-UNDO.
	    FIND FIRST ttItem NO-LOCK NO-ERROR.
	    IF AVAILABLE ttItem THEN
	    DO:
	        ASSIGN res = ttItem.Item.
	    END.
	    RETURN res.
	END METHOD.
	
    METHOD PROTECTED Progress.Lang.Object GetLast():
        DEFINE VARIABLE res AS Progress.Lang.Object NO-UNDO.
        FIND LAST ttItem NO-LOCK NO-ERROR.
        IF AVAILABLE ttItem THEN
        DO:
            ASSIGN res = ttItem.Item.
        END.
        RETURN res.
    END METHOD.
    
    METHOD PROTECTED Progress.Lang.Object GetNext():
        DEFINE VARIABLE res AS Progress.Lang.Object NO-UNDO.
        FIND NEXT ttItem NO-LOCK NO-ERROR.
        IF AVAILABLE ttItem THEN
        DO:
            ASSIGN res = ttItem.Item.
        END.
        RETURN res.
    END METHOD.
    
    METHOD PROTECTED Progress.Lang.Object GetPrev():
        DEFINE VARIABLE res AS Progress.Lang.Object NO-UNDO.
        FIND PREV ttItem NO-LOCK NO-ERROR.
        IF AVAILABLE ttItem THEN
        DO:
            ASSIGN res = ttItem.Item.
        END.
        RETURN res.
    END METHOD.
END CLASS.