/*------------------------------------------------------------------------
    File        : MockProcedureGenerator
    Purpose     : Generator for injecting stub functionality into Procedures
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.ProcedureGenerator.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.MockProcedureGenerator INHERITS ProcedureGenerator: 

	CONSTRUCTOR PUBLIC MockProcedureGenerator():
		SUPER ().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC MockProcedureGenerator():

	END DESTRUCTOR.
    
    METHOD OVERRIDE PROTECTED LONGCHAR GenerateAdditionalContents():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO INITIAL "".
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO. 
        
        res = SUPER:GenerateAdditionalContents() + "~n".
        
        IF res = ? THEN res = "".
        
        ASSIGN res = res
                   + "DEFINE VARIABLE OEMockRegisterMethodCallNo AS INTEGER NO-UNDO.~n"
                   + "OEMockRegisterMethodCallNo = OEMockRegister:RegisterMethodCall('" + Procedure:Name + "').~n".
        
        /* Iterate through parameters and make call to log parameter value */    
        parm = Procedure:Parameters:MoveFirst().
        DO WHILE VALID-OBJECT(parm):
            res = res 
                + 'OEMockRegister:RegisterMethodCallParam(OEMockRegisterMethodCallNo, "' + parm:Name + '", STRING(' + parm:Name + ')).~n'.
            parm = Procedure:Parameters:MoveNext().
        END.
        
        RETURN res.
    END METHOD.
    
    METHOD OVERRIDE PROTECTED LONGCHAR GenerateProceduralAdditionalContents():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO INITIAL "".
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
        
        res = SUPER:GenerateProceduralAdditionalContents() + "~n".
        
        IF res = ? THEN res = "".
        
        ASSIGN res = res
                   + "DEFINE VARIABLE OEMockRegisterMethodCallNo AS INTEGER NO-UNDO.~n"
                   + "OEMockRegisterMethodCallNo = OEMockRegister:RegisterMethodCall('" + Procedure:NAME + "').~n".
        
        /* Iterate through parameters and make call to log parameter value */    
        parm = Procedure:Parameters:MoveFirst().
        DO WHILE VALID-OBJECT(parm):
            res = res 
                + 'OEMockRegister:RegisterMethodCallParam(OEMockRegisterMethodCallNo, "' + parm:Name + '", STRING(' + parm:Name + ')).~n'.
            parm = Procedure:Parameters:MoveNext().
        END.
        
        RETURN res.
    END METHOD.

END CLASS.