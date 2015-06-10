/*------------------------------------------------------------------------
    File        : MockMethodGenerator
    Purpose     : Generator for injecting stub Methodality into Methods 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.MethodGenerator.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.MockMethodGenerator INHERITS MethodGenerator: 

    CONSTRUCTOR PUBLIC MockMethodGenerator():
        SUPER ().
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC MockMethodGenerator():

    END DESTRUCTOR.
    
    METHOD OVERRIDE PROTECTED LONGCHAR GenerateAdditionalContents():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO INITIAL "".
        DEFINE VARIABLE parm AS BaseParameter NO-UNDO. 
        
        res = SUPER:GenerateAdditionalContents() + "~n".
        
        IF res = ? THEN res = "".
        
        ASSIGN res = res
                   + "DEFINE VARIABLE OEMockRegisterMethodCallNo AS INTEGER NO-UNDO.~n"
                   + "OEMockRegisterMethodCallNo = OEMockRegister:RegisterMethodCall('" + Method:Name + "').~n".
        
        /* Iterate through parameters and make call to log parameter value */    
        parm = Method:Parameters:MoveFirst().
        DO WHILE VALID-OBJECT(parm):
            /* Only convert primitive parameter types */
            IF(parm:GetClass():IsA("OEMock.Reflection.PrimitiveParameter")) THEN
                res = res 
                    + 'OEMockRegister:RegisterMethodCallParam(OEMockRegisterMethodCallNo, "' + parm:Name + '", STRING(' + parm:Name + ')).~n'.
            parm = Method:Parameters:MoveNext().
        END.
        
        RETURN res.
    END METHOD.
    
END CLASS.