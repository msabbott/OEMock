USING Progress.Lang.*.
USING OEUnit.Runner.TestSuite.
USING OEMock.Tests.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.AllTests INHERITS TestSuite:
  
  CONSTRUCTOR AllTests():
    AddTest(NEW BaseMethodTester()).
    AddTest(NEW ReturningMethodTester()).
    AddTest(NEW FunctionTester()).
    AddTest(NEW MethodTester()).
    AddTest(NEW ProcedureTester()).
    AddTest(NEW ConstructorTester()).
    AddTest(NEW BaseParameterTester()).
    AddTest(NEW PrimitiveParameterTester()).
    AddTest(NEW BufferParameterTester()).
    AddTest(NEW TableParameterTester()).
    AddTest(NEW ParameterListTester()).
    AddTest(NEW BaseFileTester()).
    AddTest(NEW ProcedureFileTester()).
    AddTest(NEW ClassFileTester()).
    AddTest(NEW MethodListTester()).
    AddTest(NEW DataSetRelationTester()).
  END CONSTRUCTOR.

END CLASS.