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
                      
    DEFINE PROTECTED TEMP-TABLE ExpectedParamValue NO-UNDO
        FIELD ParamName  AS CHARACTER
        FIELD ParamValue AS CHARACTER
        FIELD Equal      AS LOGICAL INITIAL TRUE
            INDEX PriKey IS PRIMARY UNIQUE ParamName ASCENDING.
    
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
    
    METHOD PUBLIC VOID WithParameterValue(INPUT ParamName AS CHARACTER, INPUT ParamValue AS CHARACTER, INPUT Equal AS LOGICAL):
        FIND FIRST ExpectedParamValue
             WHERE ExpectedParamValue.ParamName = ParamName
                   EXCLUSIVE-LOCK NO-ERROR.
                   
        IF NOT AVAILABLE ExpectedParamValue THEN
        DO:
            CREATE ExpectedParamValue.
            ASSIGN ExpectedParamValue.ParamName = ParamName.
        END.
        
        ASSIGN ExpectedParamValue.ParamValue = ParamValue
               ExpectedParamValue.Equal      = Equal.
            
    END METHOD.
    
    METHOD PUBLIC VOID WithParameterValue(INPUT ParamName AS CHARACTER, INPUT ParamValue AS CHARACTER):
        WithParameterValue(ParamName, ParamValue, TRUE).
    END METHOD.
    
    METHOD PUBLIC VOID WithParameterValueNot(INPUT ParamName AS CHARACTER, INPUT ParamValue AS CHARACTER):
        WithParameterValue(ParamName, ParamValue, FALSE).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC VOID AssertIsSatisfied():
        
        DEFINE VARIABLE NumCalls   AS INTEGER NO-UNDO.
        DEFINE VARIABLE ParamCount AS INTEGER NO-UNDO.
        
        OEMockRegister:ReceiveMethodCallRegister(OUTPUT DATASET MethodCalls).
        
        /* Count number of expected parameters */
        FOR EACH ExpectedParamValue NO-LOCK:
            ASSIGN ParamCount = ParamCount + 1.
        END.
        
        /* If the number of expected parameters is 0, just
         * count the number of calls
         */
        IF ParamCount = 0 THEN
        DO:
            /* Count number of calls */
            FOR EACH MethodCall NO-LOCK
               WHERE MethodCall.MethodReference = MethodName:
                ASSIGN NumCalls = NumCalls + 1.
            END.
        END.
        ELSE
        DO:
            CallLoop:
            FOR EACH MethodCall NO-LOCK
               WHERE MethodCall.MethodReference = MethodName:
                   
                FOR EACH ExpectedParamValue NO-LOCK,
                    
                   FIRST MethodCallParam NO-LOCK 
                   WHERE MethodCallParam.CallNumber = MethodCall.CallNumber
                     AND MethodCallParam.ParamName  = ExpectedParamValue.ParamName:

                    /* Skip to the next method call if this one parameter does not match */    
                    IF (ExpectedParamValue.Equal EQ TRUE AND ExpectedParamValue.ParamValue NE MethodCallParam.ParamValue)
                    OR (ExpectedParamValue.Equal NE TRUE AND ExpectedParamValue.ParamValue EQ MethodCallParam.ParamValue) THEN
                    DO:
                        NEXT CallLoop.
                    END.
                END.
                
                ASSIGN NumCalls = NumCalls + 1.
            END.
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