/*------------------------------------------------------------------------
    File        : BaseExpectation
    Purpose     : Base class for Expectations 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Expectation.BaseExpectation:
    
    DEFINE PUBLIC PROPERTY IsSatisfied AS LOGICAL NO-UNDO INITIAL FALSE
        GET.
        PROTECTED SET.
    
    CONSTRUCTOR BaseExpectation():
        SUPER().
        
        /* Set Properties */
        ASSIGN IsSatisfied = FALSE.
    END CONSTRUCTOR.

	DESTRUCTOR PUBLIC BaseExpectation():

	END DESTRUCTOR.

END CLASS.