USING Progress.Lang.*.
USING OEUnit.Runner.TestSuite.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.AllTests INHERITS TestSuite:
  
  CONSTRUCTOR AllTests():
    AddTest(NEW OEMock.Tests.Reflection.AllTests()).
  END CONSTRUCTOR.

END CLASS.