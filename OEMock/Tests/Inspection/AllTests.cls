USING Progress.Lang.*.
USING OEUnit.Runner.TestSuite.
USING OEMock.Tests.Inspection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Inspection.AllTests INHERITS TestSuite:
  
  CONSTRUCTOR AllTests():
    AddTest(NEW BaseInspectorTester()).
    AddTest(NEW ClassInspectorTester()).
    AddTest(NEW ProcedureInspectorTester()).
  END CONSTRUCTOR.

END CLASS.