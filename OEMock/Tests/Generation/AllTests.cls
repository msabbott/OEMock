USING Progress.Lang.*.
USING OEUnit.Runner.TestSuite.
USING OEMock.Tests.Generation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Generation.AllTests INHERITS TestSuite:
  
  CONSTRUCTOR AllTests():
    AddTest(NEW BaseGeneratorTester()).
    AddTest(NEW StubInterfaceGeneratorTester()).
    AddTest(NEW GeneratorListTester()).
  END CONSTRUCTOR.

END CLASS.