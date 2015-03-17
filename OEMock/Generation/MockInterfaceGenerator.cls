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

END CLASS.