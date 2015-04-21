 /*------------------------------------------------------------------------
    File        : TempTableIndexField
    Purpose     : Class representing a field in a temp-table index.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.TempTableIndexField:
		
	DEFINE PUBLIC PROPERTY Descending AS LOGICAL NO-UNDO INITIAL FALSE
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY Name AS CHARACTER NO-UNDO 
	GET.
	SET. 

	CONSTRUCTOR PUBLIC TempTableIndexField(INPUT nam AS CHARACTER):
		SUPER().
		
		ASSIGN Name                   = nam
		       THIS-OBJECT:Descending = FALSE.
	END CONSTRUCTOR.
	
	METHOD PUBLIC LONGCHAR Generate():
	    
	    DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
	    
	    ASSIGN res = SUBSTITUTE("&1 &2",
	                            Name,
	                            (IF THIS-OBJECT:DESCENDING THEN "DESCENDING " ELSE "ASCENDING ")).
	    
	    RETURN res.
	END METHOD.

END CLASS.