/*------------------------------------------------------------------------
    File        : MockInterfaceGenerator
    Purpose     : Generates code for class interface for Mock doubles
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.BaseGenerator.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.MockInterfaceGenerator INHERITS BaseGenerator: 

		
	CONSTRUCTOR PUBLIC MockInterfaceGenerator():
        SUPER().
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC MockInterfaceGenerator():

    END DESTRUCTOR.
    
    METHOD PUBLIC VOID AttachTo(INPUT clsfile AS OEMock.Reflection.ClassFile):
       IF VALID-OBJECT(clsfile) THEN
       DO:
           clsfile:UsingList:Add("OEMock.Generation.MockInterface").
           clsfile:Interfaces:Add("OEMock.Generation.MockInterface").
           clsfile:Generators:AddGenerator(THIS-OBJECT).
       END.
    END METHOD.
    
    METHOD PUBLIC VOID AttachTo(INPUT procfile AS OEMock.Reflection.ProcedureFile):
        IF VALID-OBJECT(procfile) THEN
        DO:
            procfile:Generators:AddGenerator(THIS-OBJECT).
        END.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC LONGCHAR Generate():
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
        res = SUPER:Generate().
        
        res = res + "~n"
            + "DEFINE TEMP-TABLE OEMockExpectationMethodCall NO-UNDO~n"
            + "FIELD CallNumber AS INTEGER~n"
            + "FIELD MethodRef  AS CHARACTER~n"
            + "FIELD NumCalls   AS INTEGER~n"
            + "INDEX PriKey  IS PRIMARY UNIQUE CallNumber ASCENDING~n"
            + "INDEX MethKey                   MethodRef  ASCENDING.~n~n"
            
            + "DEFINE TEMP-TABLE OEMockExpectationMethodCallParam NO-UNDO~n"
            + "FIELD CallNumber AS INTEGER~n"
            + "FIELD ParamName  AS CHARACTER~n"
            + "FIELD ParamValue AS CHARACTER~n"
            + "INDEX PriKey IS PRIMARY UNIQUE CallNumber ASCENDING ParamName ASCENDING~n"
            + "INDEX ValKey                   CallNumber ASCENDING ParamName ASCENDING ParamValue.~n~n".
            
        RETURN res.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC LONGCHAR GenerateProcedural():
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
        res = SUPER:GenerateProcedural().
        RETURN res.
    END METHOD.

END CLASS.