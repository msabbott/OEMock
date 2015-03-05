/*------------------------------------------------------------------------
    File        : MockFunctionGenerator
    Purpose     : Generator for injecting stub functionality into Functions 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.FunctionGenerator.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.MockFunctionGenerator INHERITS FunctionGenerator: 

	CONSTRUCTOR PUBLIC MockFunctionGenerator():
		SUPER ().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC MockFunctionGenerator():

	END DESTRUCTOR.

END CLASS.