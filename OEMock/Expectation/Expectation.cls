/*------------------------------------------------------------------------
    File        : Expectation
    Purpose     : Basic Expectation class 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Expectation.BaseExpectation.
USING OEMock.OEMockRegister.
USING OEUnit.Assertion.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Expectation.Expectation INHERITS BaseExpectation:
    
    DEFINE PROTECTED TEMP-TABLE MethodCall NO-UNDO
        FIELD CallNumber      AS INTEGER
        FIELD MethodReference AS CHARACTER
        FIELD NumCalls        AS INTEGER
            INDEX PriKey  IS PRIMARY UNIQUE CallNumber      ASCENDING
            INDEX MethKey                   MethodReference ASCENDING.
            
    DEFINE PROTECTED TEMP-TABLE MethodCallParam NO-UNDO
        FIELD CallNumber AS INTEGER
        FIELD ParamName  AS CHARACTER
        FIELD ParamValue AS CHARACTER
            INDEX PriKey IS PRIMARY UNIQUE CallNumber ASCENDING ParamName ASCENDING
            INDEX ValKey                   CallNumber ASCENDING ParamName ASCENDING ParamValue.
            
    DEFINE PROTECTED DATASET MethodCalls
        FOR MethodCall, MethodCallParam
        DATA-RELATION callparams 
                  FOR MethodCall, MethodCallParam
                      RELATION-FIELDS (CallNumber,CallNumber).
    
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
    
    METHOD OVERRIDE PUBLIC VOID AssertIsSatisfied():
        
        DEFINE VARIABLE NumCalls AS INTEGER NO-UNDO.
        
        OEMockRegister:ReceiveMethodCallRegister(OUTPUT DATASET MethodCalls).
        
        /* Count number of calls */
        FOR EACH MethodCall NO-LOCK
           WHERE MethodCall.MethodReference = MethodName:
            ASSIGN NumCalls = NumCalls + 1.
        END.
        
        /* Verify against minimum number of calls */
        IF MinimumCalls NE ? THEN
            Assert:IsTrue(NumCalls >= MinimumCalls,
                          SUBSTITUTE("Expecting minimum of &2 calls to &1 but only &3 were made",
                                     MethodName,
                                     STRING(MinimumCalls),
                                     STRING(NumCalls))).
        
        /* Verify against maximum number of calls */
        IF MaximumCalls NE ? THEN
            Assert:IsTrue(NumCalls <= MaximumCalls,
                          SUBSTITUTE("Expecting maximum of &2 calls to &1 but &3 were made",
                                     MethodName,
                                     STRING(MaximumCalls),
                                     STRING(NumCalls))).
    END METHOD.
    
END CLASS.