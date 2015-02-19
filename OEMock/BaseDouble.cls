 /*------------------------------------------------------------------------
    File        : BaseDouble
    Purpose     : Holds common properties for all types of test doubles
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseFile.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.BaseDouble:
    
	DEFINE PUBLIC PROPERTY File AS BaseFile NO-UNDO
	GET.
	SET.
	
	CONSTRUCTOR BaseDouble(INPUT fil AS BaseFile):
	    SUPER().
	    
	    /* Assign values */
	    ASSIGN File = fil.
	END CONSTRUCTOR. 

END CLASS.