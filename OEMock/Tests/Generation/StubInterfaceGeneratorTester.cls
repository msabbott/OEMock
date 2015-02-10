/*------------------------------------------------------------------------
    File        : StubInterfaceGeneratorTester
    Purpose     : Unit tests for StubInterfaceGenerator 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Generation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Generation.StubInterfaceGeneratorTester:
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlank():
        DEFINE VARIABLE gen AS StubInterfaceGenerator NO-UNDO.
        
        gen = NEW StubInterfaceGenerator().

        Assert:AreEqual(gen:Generate(), "").
        
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateProceduralReturnsBlank():
        DEFINE VARIABLE gen AS StubInterfaceGenerator NO-UNDO.
        
        gen = NEW StubInterfaceGenerator().

        Assert:AreEqual(gen:GenerateProcedural(), "").
        
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.

END CLASS.