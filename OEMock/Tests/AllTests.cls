USING Progress.Lang.*.
USING OEUnit.Runner.TestSuite.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.AllTests INHERITS TestSuite:
  
  CONSTRUCTOR AllTests():
    /* Tests for packages */
    AddTest(NEW OEMock.Tests.Reflection.AllTests()).
    AddTest(NEW OEMock.Tests.Util.AllTests()).
    AddTest(NEW OEMock.Tests.Inspection.AllTests()).
    AddTest(NEW OEMock.Tests.Generation.AllTests()).
    AddTest(NEW OEMock.Tests.Expectation.AllTests()).
    
    /* Tests for root level objects */
    AddTest(NEW OEMock.Tests.BaseDoubleTester()).
    AddTest(NEW OEMock.Tests.StubTester()).
    AddTest(NEW OEMock.Tests.OEMockTester()).
  END CONSTRUCTOR.

END CLASS.