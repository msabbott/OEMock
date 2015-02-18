/*------------------------------------------------------------------------
    File        : StubFunctionGenerator
    Purpose     : Generator for injecting stub functionality into Functions 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.FunctionGenerator.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.StubFunctionGenerator INHERITS FunctionGenerator: 

	CONSTRUCTOR PUBLIC StubFunctionGenerator():
		SUPER ().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC StubFunctionGenerator():

	END DESTRUCTOR.

END CLASS.