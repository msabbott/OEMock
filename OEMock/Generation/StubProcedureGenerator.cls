/*------------------------------------------------------------------------
    File        : StubProcedureGenerator
    Purpose     : Generator for injecting stub functionality into Procedures
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.ProcedureGenerator.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.StubProcedureGenerator INHERITS ProcedureGenerator: 

	CONSTRUCTOR PUBLIC StubProcedureGenerator():
		SUPER ().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC StubProcedureGenerator():

	END DESTRUCTOR.

END CLASS.