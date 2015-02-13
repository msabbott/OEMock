USING Progress.Lang.*.
USING OEUnit.Runner.TestSuite.
USING OEMock.Tests.Util.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Util.AllTests INHERITS TestSuite:
  
  CONSTRUCTOR AllTests():
    AddTest(NEW BaseListTester()).
    AddTest(NEW ListTester()).
    AddTest(NEW StringListTester()).
    AddTest(NEW BaseNamedListTester()).
    AddTest(NEW WarningsTester()).
  END CONSTRUCTOR.

END CLASS.