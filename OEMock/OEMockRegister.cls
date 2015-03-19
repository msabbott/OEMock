 /*------------------------------------------------------------------------
    File        : OEMockRegister
    Purpose     : Registers calls to procedures, functions and methods and
                  allows data to be recalled. 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.OEMockRegister:
    
    DEFINE STATIC TEMP-TABLE MethodCall NO-UNDO
        FIELD CallNumber      AS INTEGER
        FIELD MethodReference AS CHARACTER
        FIELD NumCalls        AS INTEGER
            INDEX PriKey  IS PRIMARY UNIQUE CallNumber      ASCENDING
            INDEX MethKey                   MethodReference ASCENDING.
            
    DEFINE STATIC TEMP-TABLE MethodCallParam NO-UNDO
        FIELD CallNumber AS INTEGER
        FIELD ParamName  AS CHARACTER
        FIELD ParamValue AS CHARACTER
            INDEX PriKey IS PRIMARY UNIQUE CallNumber ASCENDING ParamName ASCENDING
            INDEX ValKey                   CallNumber ASCENDING ParamName ASCENDING ParamValue.
            
    DEFINE STATIC DATASET MethodCalls
        FOR MethodCall, MethodCallParam
        DATA-RELATION callparams 
                  FOR MethodCall, MethodCallParam
                      RELATION-FIELDS (CallNumber,CallNumber).
            
    METHOD STATIC PUBLIC INTEGER RegisterMethodCall(INPUT methRef AS CHARACTER):
        DEFINE VARIABLE callNo AS INTEGER NO-UNDO INITIAL 1.
        FIND LAST MethodCall NO-LOCK NO-ERROR.
        IF AVAILABLE MethodCall THEN ASSIGN callNo = MethodCall.CallNumber + 1.
        CREATE MethodCall.
        ASSIGN MethodCall.CallNumber      = callNo
               MethodCall.MethodReference = methRef
               MethodCall.NumCalls        = 1.
        RETURN callNo.
    END METHOD.
    
    METHOD STATIC PUBLIC VOID RegisterMethodCallParam(INPUT callNo AS INTEGER, INPUT parmName AS CHARACTER, INPUT parmValue AS CHARACTER):
        CREATE MethodCallParam.
        ASSIGN MethodCallParam.CallNumber = callNo
               MethodCallParam.ParamName  = parmName
               MethodCallParam.ParamValue = parmValue.
    END METHOD.
    
    METHOD STATIC PUBLIC VOID ClearMethodCallRegister():
        EMPTY TEMP-TABLE MethodCallParam.
        EMPTY TEMP-TABLE MethodCall.        
    END METHOD.
    
    METHOD STATIC PUBLIC VOID ReceiveMethodCallRegister(OUTPUT DATASET MethodCalls):
    END METHOD.

END CLASS.