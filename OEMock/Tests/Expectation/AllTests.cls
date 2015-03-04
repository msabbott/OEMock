USING Progress.Lang.*.
USING OEUnit.Runner.TestSuite.
USING OEMock.Tests.Expectation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Expectation.AllTests INHERITS TestSuite:
  
  CONSTRUCTOR AllTests():
    AddTest(NEW BaseExpectationTester()).
    AddTest(NEW ExpectationTester()).
    AddTest(NEW ExpectationListTester()).
  END CONSTRUCTOR.

END CLASS.