/*------------------------------------------------------------------------
    File        : MockFunctionGenerator
    Purpose     : Generator for injecting stub functionality into Functions 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.FunctionGenerator.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.MockFunctionGenerator INHERITS FunctionGenerator: 

	CONSTRUCTOR PUBLIC MockFunctionGenerator():
		SUPER ().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC MockFunctionGenerator():

	END DESTRUCTOR.
    
    METHOD OVERRIDE PROTECTED LONGCHAR GenerateAdditionalContents():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO INITIAL "".
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO. 
        
        res = SUPER:GenerateAdditionalContents() + "~n".
        
        IF res = ? THEN res = "".
        
        ASSIGN res = res
                   + "DEFINE VARIABLE OEMockRegisterMethodCallNo AS INTEGER NO-UNDO.~n"
                   + "OEMockRegisterMethodCallNo = OEMockRegisterMethodCall('" + Function:Name + "').~n".
        
        /* Iterate through parameters and make call to log parameter value */    
        parm = Function:Parameters:MoveFirst().
        DO WHILE VALID-OBJECT(parm):
            res = res 
                + 'OEMockRegisterMethodCallParam(OEMockRegisterMethodCallNo, "' + parm:Name + '", STRING(' + parm:Name + ')).~n'.
            parm = Function:Parameters:MoveNext().
        END.
        
        RETURN res.
    END METHOD.

END CLASS.