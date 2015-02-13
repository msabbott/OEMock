/*------------------------------------------------------------------------
    File        : BaseNamedList
    Purpose     : Base class for storing name/pair values 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Util.BaseNamedList:
    
    DEFINE PROTECTED TEMP-TABLE ttItem NO-UNDO
        FIELD Name AS CHARACTER
        FIELD Item AS Progress.Lang.Object
            INDEX PriKey IS PRIMARY UNIQUE Name ASCENDING.
    
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
		
	CONSTRUCTOR PUBLIC BaseNamedList():
		SUPER().
        ASSIGN DestroyOnDestruct = TRUE.
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC BaseNamedList():
        EmptyList().
    END DESTRUCTOR.
    
    METHOD PROTECTED VOID EmptyList():
        FOR EACH ttItem EXCLUSIVE-LOCK:
            IF DestroyOnDestruct AND VALID-OBJECT(ttItem.Item) THEN
                DELETE OBJECT ttItem.Item.
            DELETE ttItem.
        END.
    END METHOD.
    
    METHOD PROTECTED Progress.Lang.Object GetValue(INPUT nam AS CHARACTER):
        DEFINE VARIABLE res AS Progress.Lang.Object NO-UNDO.
        ASSIGN nam = TRIM(nam).
        FIND FIRST ttItem
             WHERE ttItem.Name = nam
                   NO-LOCK NO-ERROR.
        IF AVAILABLE ttItem THEN
            res = ttItem.Item.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC LOGICAL HasValue(INPUT nam AS CHARACTER):
        ASSIGN nam = TRIM(nam).
        FIND FIRST ttItem
             WHERE ttItem.Name = nam
                   NO-LOCK NO-ERROR.
        RETURN AVAILABLE ttItem.
    END METHOD.
    
    METHOD PROTECTED VOID AddValue(INPUT nam AS CHARACTER, INPUT obj AS Progress.Lang.Object):
        ASSIGN nam = TRIM(nam).
        IF nam NE "" AND nam NE ? THEN
        DO:
            FIND FIRST ttItem
                 WHERE ttItem.Name = nam
                       NO-LOCK NO-ERROR.
            IF NOT AVAILABLE ttItem THEN
            DO:
                CREATE ttItem.
                ASSIGN ttItem.Name = nam.
            END.
            ASSIGN ttItem.Item = obj.
        END.
    END METHOD.

END CLASS.