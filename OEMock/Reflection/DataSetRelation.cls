/*------------------------------------------------------------------------
    File        : DataSetRelation
    Purpose     : Represents a relation in a DataSet
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.DataSetRelation:
    
    DEFINE PUBLIC PROPERTY Name AS CHARACTER NO-UNDO 
    GET.
    PROTECTED SET.
        
    DEFINE PUBLIC PROPERTY ParentBufferName AS CHARACTER NO-UNDO 
    GET.
    SET.
        
    DEFINE PUBLIC PROPERTY ChildBufferName AS CHARACTER NO-UNDO 
    GET.
    SET.
        
    DEFINE PUBLIC PROPERTY RelationList AS CHARACTER NO-UNDO 
    GET.
    SET.
		
    CONSTRUCTOR PUBLIC DataSetRelation(INPUT nam AS CHARACTER):
        SUPER().
        
        ASSIGN Name = nam.
    END CONSTRUCTOR.

	DESTRUCTOR PUBLIC DataSetRelation():
	END DESTRUCTOR.
	
	METHOD PUBLIC LONGCHAR Generate():
	    
	    DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
	    
	    ASSIGN res = "DATA-RELATION "
	               + (IF Name NE "" AND Name NE ? THEN Name + " " ELSE "")
	               + "FOR " + ParentBufferName + "," + ChildBufferName + " "
	               + "RELATION-FIELDS (" + RelationList + ")".

	    RETURN res.
	END METHOD.

END CLASS.