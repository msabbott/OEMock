USING Progress.Lang.*.
USING OEUnit.Runner.TestSuite.
USING OEMock.Tests.Generation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Generation.AllTests INHERITS TestSuite:
  
  CONSTRUCTOR AllTests():
    AddTest(NEW BaseGeneratorTester()).
    AddTest(NEW StubInterfaceGeneratorTester()).
    AddTest(NEW MockInterfaceGeneratorTester()).
    AddTest(NEW GeneratorListTester()).
    AddTest(NEW BaseMethodGeneratorTester()).
    AddTest(NEW ProcedureGeneratorTester()).
    AddTest(NEW ReturningMethodGeneratorTester()).
    AddTest(NEW FunctionGeneratorTester()).
    AddTest(NEW MethodGeneratorTester()).
    AddTest(NEW StubProcedureGeneratorTester()).
  END CONSTRUCTOR.

END CLASS.