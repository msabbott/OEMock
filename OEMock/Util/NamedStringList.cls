/*------------------------------------------------------------------------
    File        : NamedStringList
    Purpose     : Base class for storing name/pair values 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Util.NamedStringList:
    
    DEFINE PROTECTED TEMP-TABLE ttItem NO-UNDO
        FIELD Name AS CHARACTER
        FIELD Item AS CHARACTER
            INDEX PriKey IS PRIMARY UNIQUE Name ASCENDING.
    
    DEFINE PUBLIC PROPERTY Count AS INTEGER NO-UNDO 
    GET():
        DEFINE VARIABLE cnt AS INTEGER NO-UNDO.
        FOR EACH ttItem NO-LOCK:
            ASSIGN cnt = cnt + 1.
        END.
        RETURN cnt.
    END GET.
        
	CONSTRUCTOR PUBLIC NamedStringList():
		SUPER().
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC NamedStringList():
        EmptyList().
    END DESTRUCTOR.
    
    METHOD PUBLIC VOID EmptyList():
        EMPTY TEMP-TABLE ttItem.
    END METHOD.
    
    METHOD PUBLIC CHARACTER GetValue(INPUT nam AS CHARACTER):
        DEFINE VARIABLE res AS CHARACTER NO-UNDO INITIAL ?.
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
    
    METHOD PUBLIC VOID AddValue(INPUT nam AS CHARACTER, INPUT txt AS CHARACTER):
        ASSIGN nam = TRIM(nam).
        IF nam NE ? AND nam NE "" AND txt NE ? THEN
        DO: 
            FIND FIRST ttItem
                 WHERE ttItem.Name = nam
                       NO-LOCK NO-ERROR.
            IF NOT AVAILABLE ttItem THEN
            DO:
                CREATE ttItem.
                ASSIGN ttItem.Name = nam.
            END.
            ASSIGN ttItem.Item = txt.
        END.
    END METHOD.

END CLASS.