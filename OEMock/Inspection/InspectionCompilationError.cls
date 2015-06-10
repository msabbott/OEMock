/*------------------------------------------------------------------------
    File        : InspectionCompilationError
    Purpose     : Error raised when compilation fails during inspection 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Inspection.InspectionError.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Inspection.InspectionCompilationError INHERITS InspectionError: 

		
	CONSTRUCTOR PUBLIC InspectionCompilationError():
	    
	    DEFINE VARIABLE errorMsg AS CHARACTER NO-UNDO.
	    DEFINE VARIABLE msgCount AS INTEGER   NO-UNDO.
	    
	    SUPER().
	    
	    DO msgCount = 1 TO ERROR-STATUS:NUM-MESSAGES:
	        ASSIGN errorMsg = errorMsg + CHR(10)
	                        + ERROR-STATUS:GET-MESSAGE(msgCount).
	    END.
	    ASSIGN errorMsg = TRIM(errorMsg).
	    
		THIS-OBJECT:AddMessage(errorMsg,0).
		
	END CONSTRUCTOR.

END CLASS.