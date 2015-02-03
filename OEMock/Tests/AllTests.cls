USING Progress.Lang.*.
USING OEUnit.Runner.TestSuite.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.AllTests INHERITS TestSuite:
  
  CONSTRUCTOR AllTests():
    AddTest(NEW OEMock.Tests.Reflection.AllTests()).
    AddTest(NEW OEMock.Tests.Util.AllTests()).
    AddTest(NEW OEMock.Tests.Inspection.AllTests()).
  END CONSTRUCTOR.

END CLASS.