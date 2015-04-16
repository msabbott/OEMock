 /*------------------------------------------------------------------------
    File        : TempTableIndex
    Purpose     : Represents a temp-table index 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.TempTableIndex:
    
    
		
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
		
		ASSIGN Name                = nam
		       THIS-OBJECT:Primary = FALSE
		       THIS-OBJECT:Unique  = FALSE
		       WordIndex           = FALSE.
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC TempTableIndex():

	END DESTRUCTOR.
	
	METHOD PUBLIC LONGCHAR Generate():
	    
	    DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
	    
	    ASSIGN res = SUBSTITUTE("INDEX &1 &2&3&4&5",
	                            Name,
	                            (IF THIS-OBJECT:Primary OR THIS-OBJECT:Unique OR WordIndex THEN "IS " ELSE ""),
	                            (IF THIS-OBJECT:Primary THEN "PRIMARY " ELSE ""),
	                            (IF THIS-OBJECT:Unique  THEN "UNIQUE " ELSE ""),
                                (IF WordIndex           THEN "WORD-INDEX " ELSE "")).
	    
	    RETURN res.

	END METHOD.

END CLASS.