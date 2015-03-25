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
    PROTECTED SET.
        
    DEFINE PUBLIC PROPERTY ChildBufferName AS CHARACTER NO-UNDO 
    GET.
    PROTECTED SET.
        
    DEFINE PUBLIC PROPERTY RelationList AS CHARACTER NO-UNDO 
    GET.
    PROTECTED SET.
		
    CONSTRUCTOR PUBLIC DataSetRelation(INPUT nam AS CHARACTER):
        SUPER().
        
        ASSIGN Name = nam.
    END CONSTRUCTOR.

	DESTRUCTOR PUBLIC DataSetRelation():
	END DESTRUCTOR.

END CLASS.