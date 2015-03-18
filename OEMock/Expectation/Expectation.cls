/*------------------------------------------------------------------------
    File        : Expectation
    Purpose     : Basic Expectation class 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Expectation.BaseExpectation.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Expectation.Expectation INHERITS BaseExpectation:
    
	DEFINE PUBLIC PROPERTY MethodName AS CHARACTER NO-UNDO 
	GET.
	PROTECTED SET.

	DEFINE PUBLIC PROPERTY MinimumCalls AS INTEGER INITIAL ? NO-UNDO 
	GET.
	PROTECTED SET(INPUT arg AS INTEGER):
		IF arg = ? OR arg >= 0 THEN
		    MinimumCalls = arg.
        ELSE
            MinimumCalls = ?.
		  
		IF THIS-OBJECT:MaximumCalls NE ? AND arg > THIS-OBJECT:MaximumCalls THEN
		    THIS-OBJECT:MaximumCalls = ?.
	END SET.

    DEFINE PUBLIC PROPERTY MaximumCalls AS INTEGER INITIAL ? NO-UNDO 
    GET.
    PROTECTED SET(INPUT arg AS INTEGER):
        IF arg = ? OR arg >= 0 THEN
            MaximumCalls = arg.
        ELSE
            MaximumCalls = ?.
          
        IF THIS-OBJECT:MinimumCalls NE ? AND arg < THIS-OBJECT:MinimumCalls THEN
            THIS-OBJECT:MinimumCalls = ?.
    END SET.
	 
	CONSTRUCTOR PUBLIC Expectation(INPUT methName AS CHARACTER):
		SUPER().
		
		ASSIGN MethodName   = methName
		       MinimumCalls = ?
		       MaximumCalls = ?.
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC Expectation():

	END DESTRUCTOR.
	
	METHOD PUBLIC VOID CalledAtLeast(INPUT numCalls AS INTEGER):
	    MinimumCalls = numCalls.
	END METHOD.
    
    METHOD PUBLIC VOID CalledAtMost(INPUT numCalls AS INTEGER):
        MaximumCalls = numCalls.
    END METHOD.
    
    METHOD PUBLIC VOID CalledExactly(INPUT numCalls AS INTEGER):
        CalledAtLeast(numCalls).
        CalledAtMost(numCalls).
    END METHOD.
    
    METHOD PUBLIC VOID CalledOnlyOnce():
        CalledExactly(1).
    END METHOD.
    
    METHOD PUBLIC VOID NeverCalled():
        CalledExactly(0).
    END METHOD.

END CLASS.