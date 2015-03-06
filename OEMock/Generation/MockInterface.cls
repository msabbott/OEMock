/*------------------------------------------------------------------------
    File        : MockInterface
    Purpose     : Interface added to Mock test doubles. 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

INTERFACE OEMock.Generation.MockInterface:
    
    DEFINE TEMP-TABLE OEMockExpectationMethodCall NO-UNDO
        FIELD CallNumber AS INTEGER
        FIELD MethodRef  AS CHARACTER
        FIELD NumCalls   AS INTEGER
            INDEX PriKey  IS PRIMARY UNIQUE CallNumber ASCENDING
            INDEX MethKey                   MethodRef  ASCENDING.
        
    DEFINE TEMP-TABLE OEMockExpectationMethodCallParam NO-UNDO
        FIELD CallNumber AS INTEGER
        FIELD ParamName  AS CHARACTER
        FIELD ParamValue AS CHARACTER
            INDEX PriKey IS PRIMARY UNIQUE CallNumber ASCENDING ParamName ASCENDING
            INDEX ValKey                   CallNumber ASCENDING ParamName ASCENDING ParamValue.
  
END INTERFACE.