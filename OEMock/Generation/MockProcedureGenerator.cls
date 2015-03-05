/*------------------------------------------------------------------------
    File        : MockProcedureGenerator
    Purpose     : Generator for injecting stub functionality into Procedures
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.ProcedureGenerator.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.MockProcedureGenerator INHERITS ProcedureGenerator: 

	CONSTRUCTOR PUBLIC MockProcedureGenerator():
		SUPER ().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC MockProcedureGenerator():

	END DESTRUCTOR.

END CLASS.