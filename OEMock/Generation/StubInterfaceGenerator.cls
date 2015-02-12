/*------------------------------------------------------------------------
    File        : StubInterfaceGenerator
    Purpose     : Generates code for class interface for Stub doubles
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.BaseGenerator.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.StubInterfaceGenerator INHERITS BaseGenerator: 

	CONSTRUCTOR PUBLIC StubInterfaceGenerator():
		SUPER().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC StubInterfaceGenerator():

	END DESTRUCTOR.
	
	METHOD PUBLIC VOID AttachTo(INPUT clsfile AS OEMock.Reflection.ClassFile):
	   IF VALID-OBJECT(clsfile) THEN
	   DO:
	       clsfile:UsingList:Add("OEMock.Generation.StubInterface").
	       clsfile:Interfaces:Add("OEMock.Generation.StubInterface").
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