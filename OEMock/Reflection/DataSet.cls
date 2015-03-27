/*------------------------------------------------------------------------
    File        : DataSet
    Purpose     : Represents a DataSet in code. 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Util.StringList.
USING OEMock.Reflection.DataSetRelationList.
USING OEMOck.Reflection.DataSetRelation.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.DataSet:
    
    DEFINE PUBLIC PROPERTY Buffers AS CHARACTER NO-UNDO
    GET.
    SET.
    
    DEFINE PUBLIC PROPERTY DataSetRelations AS OEMock.Reflection.DataSetRelationList NO-UNDO
    GET.
    PROTECTED SET.
		
	DEFINE PUBLIC PROPERTY Name AS CHARACTER NO-UNDO 
	GET.
	PROTECTED SET.
	
	DEFINE PUBLIC PROPERTY Static AS LOGICAL NO-UNDO INITIAL FALSE
	GET.
	SET.
	
	CONSTRUCTOR PUBLIC DataSet(INPUT nam AS CHARACTER):
		SUPER().
		
		ASSIGN Name   = nam
		       Static = FALSE.
		
		/* Create objects */
		ASSIGN DataSetRelations = NEW OEMock.Reflection.DataSetRelationList().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC DataSet():
        IF VALID-OBJECT(DataSetRelations) THEN DELETE OBJECT DataSetRelations.
	END DESTRUCTOR.
	
	METHOD PUBLIC LONGCHAR Generate():
	    
	    DEFINE VARIABLE res AS LONGCHAR        NO-UNDO.
	    DEFINE VARIABLE rel AS DataSetRelation NO-UNDO.
	    
	    res = SUBSTITUTE("DEFINE &1DATASET &2 FOR &3 ",
	                     (IF THIS-OBJECT:Static THEN "STATIC " ELSE ""),
	                     Name,
	                     Buffers).
	    
	    /* Build list of data relations */
	    rel = DataSetRelations:MoveFirst().
	    DO WHILE(VALID-OBJECT(rel)):
	        res = res + " " + rel:Generate().
	        rel = DataSetRelations:MoveNext().
	    END.
	    
	    RETURN res.
	    
	END METHOD.

END CLASS.