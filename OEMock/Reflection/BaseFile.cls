/*------------------------------------------------------------------------
    File        : BaseFile
    Purpose     : Holds information on a code file
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.BaseFile:
    
	DEFINE PUBLIC PROPERTY FileName AS CHARACTER NO-UNDO 
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY FileType AS CHARACTER NO-UNDO 
	GET.
	SET.
	
	CONSTRUCTOR BaseFile(INPUT fname AS CHARACTER):
	    SUPER().
	    ASSIGN FileName = fname.
    END CONSTRUCTOR. 
    
    DESTRUCTOR BaseFile():
    END DESTRUCTOR.

END CLASS.