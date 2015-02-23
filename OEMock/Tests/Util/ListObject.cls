/*------------------------------------------------------------------------
    File        : ListObject
    Purpose     : Small object for helping with tests
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Util.ListObject:
    
	DEFINE PUBLIC PROPERTY Name AS CHARACTER NO-UNDO 
	GET.
	SET. 
	
	CONSTRUCTOR ListObject(INPUT nam AS CHARACTER):
	    SUPER().
	    NAME = nam.
	END CONSTRUCTOR.
	
	METHOD PUBLIC CHARACTER ListObjectMethod(INPUT paramName AS CHARACTER):
	    RETURN "".
	END METHOD.

END CLASS.