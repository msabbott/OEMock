 /*------------------------------------------------------------------------
    File        : ProcedureFileTester
    Purpose     : Unit tests for ProcedureFile class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.ProcedureFileTester: 
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesFunctionList():
        DEFINE VARIABLE procfile AS ProcedureFile NO-UNDO.
        
        procfile = NEW ProcedureFile("FileName").
        
        Assert:IsTrue(VALID-OBJECT(procfile:Functions)).
        
        IF VALID-OBJECT(procfile) THEN DELETE OBJECT procfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesProcedureList():
        DEFINE VARIABLE procfile AS ProcedureFile NO-UNDO.
        
        procfile = NEW ProcedureFile("FileName").
        
        Assert:IsTrue(VALID-OBJECT(procfile:Procedures)).
        
        IF VALID-OBJECT(procfile) THEN DELETE OBJECT procfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesProcedures():
        DEFINE VARIABLE procfile AS ProcedureFile NO-UNDO.
        
        procfile = NEW ProcedureFile("FileName").
        procfile:Procedures:AddMethod(NEW Procedure('ProcName')).
        
        AssertString:Contains(procfile:Generate(), 
                              "PROCEDURE ProcName :" + CHR(10) + CHR(13) + "END PROCEDURE.").
        
        IF VALID-OBJECT(procfile) THEN DELETE OBJECT procfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesFunctionForwards():
        DEFINE VARIABLE procfile AS ProcedureFile NO-UNDO.
        
        procfile = NEW ProcedureFile("FileName").
        procfile:Functions:AddMethod(NEW Function('FuncName', 'CHARACTER')).
        
        AssertString:Contains(procfile:Generate(), 
                              "FUNCTION FuncName RETURNS CHARACTER () FORWARD.").
        
        IF VALID-OBJECT(procfile) THEN DELETE OBJECT procfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesFunctions():
        DEFINE VARIABLE procfile AS ProcedureFile NO-UNDO.
        
        procfile = NEW ProcedureFile("FileName").
        procfile:Functions:AddMethod(NEW Function('FuncName', 'CHARACTER')).
        
        AssertString:Contains(procfile:Generate(), 
                              "FUNCTION FuncName RETURNS CHARACTER ():" + CHR(10) + CHR(13) + "END FUNCTION.").
        
        IF VALID-OBJECT(procfile) THEN DELETE OBJECT procfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesForwardsBeforeFunctions():
        DEFINE VARIABLE procfile AS ProcedureFile NO-UNDO.
        DEFINE VARIABLE procres  AS LONGCHAR NO-UNDO.
        
        procfile = NEW ProcedureFile("FileName").
        procfile:Functions:AddMethod(NEW Function('FuncName', 'CHARACTER')).
        
        procres = procfile:Generate().
        
        /* Verify both forward declaration and declaration are generated */
        AssertString:Contains(procres, "FUNCTION FuncName RETURNS CHARACTER () FORWARD.").
        AssertString:Contains(procres, "FUNCTION FuncName RETURNS CHARACTER ():" + CHR(10) + CHR(13) + "END FUNCTION.").
        
        Assert:IsTrue(INDEX(procres, "FUNCTION FuncName RETURNS CHARACTER () FORWARD.")
                      LT
                      INDEX(procres, "FUNCTION FuncName RETURNS CHARACTER ():")).
        
        IF VALID-OBJECT(procfile) THEN DELETE OBJECT procfile.
    END METHOD.

END CLASS.