/*------------------------------------------------------------------------
    File        : Expectation
    Purpose     : Basic Expectation class 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Expectation.BaseExpectation.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Expectation.Expectation INHERITS BaseExpectation: 
		
	CONSTRUCTOR PUBLIC Expectation():
		SUPER().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC Expectation():

	END DESTRUCTOR.

END CLASS.