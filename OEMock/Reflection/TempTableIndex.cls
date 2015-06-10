 /*------------------------------------------------------------------------
    File        : TempTableIndex
    Purpose     : Represents a temp-table index 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.TempTableIndexField.
USING OEMock.Reflection.TempTableIndexFieldList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.TempTableIndex:
    
    DEFINE PUBLIC PROPERTY Fields AS OEMock.Reflection.TempTableIndexFieldList NO-UNDO
    GET.
    PROTECTED SET.
		
	DEFINE PUBLIC PROPERTY Name AS CHARACTER NO-UNDO 
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY Primary AS LOGICAL INITIAL FALSE NO-UNDO 
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY Unique AS LOGICAL INITIAL FALSE NO-UNDO 
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY WordIndex AS LOGICAL INITIAL FALSE NO-UNDO 
	GET.
	SET. 

	CONSTRUCTOR PUBLIC TempTableIndex(INPUT nam AS CHARACTER):
		SUPER ().
		
		ASSIGN THIS-OBJECT:Fields  = NEW TempTableIndexFieldList()
		       Name                = nam
		       THIS-OBJECT:Primary = FALSE
		       THIS-OBJECT:Unique  = FALSE
		       WordIndex           = FALSE.
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC TempTableIndex():
        IF VALID-OBJECT(THIS-OBJECT:Fields) THEN DELETE OBJECT THIS-OBJECT:Fields.
	END DESTRUCTOR.
	
	METHOD PUBLIC LONGCHAR Generate():
	    
	    DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
	    DEFINE VARIABLE fld AS TempTableIndexField NO-UNDO.
        
        ASSIGN res = "INDEX " + Name + " "
                   + (IF THIS-OBJECT:Primary OR THIS-OBJECT:Unique OR WordIndex THEN "IS " ELSE "")
                   + (IF THIS-OBJECT:Primary THEN "PRIMARY " ELSE "")
                   + (IF THIS-OBJECT:Unique  THEN "UNIQUE " ELSE "")
                   + (IF WordIndex           THEN "WORD-INDEX " ELSE "").
        
        /* Build field list */
        fld = THIS-OBJECT:Fields:MoveFirst().
        DO WHILE(VALID-OBJECT(fld)):
            res = res + " " + fld:Generate().
            fld = THIS-OBJECT:Fields:MoveNext().
        END.
        
        ASSIGN res = TRIM(res) + CHR(13).
	    
	    RETURN res.

	END METHOD.

END CLASS.