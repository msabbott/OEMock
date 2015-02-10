/*------------------------------------------------------------------------
    File        : StubInterfaceGenerator
    Purpose     : Generates code for class interface for Stub doubles
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.BaseGenerator.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.StubInterfaceGenerator INHERITS BaseGenerator: 

	CONSTRUCTOR PUBLIC StubInterfaceGenerator():
		SUPER().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC StubInterfaceGenerator():

	END DESTRUCTOR.

END CLASS.