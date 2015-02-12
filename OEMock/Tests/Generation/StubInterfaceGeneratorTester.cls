/*------------------------------------------------------------------------
    File        : StubInterfaceGeneratorTester
    Purpose     : Unit tests for StubInterfaceGenerator 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Generation.*.
USING OEMock.Reflection.*.

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
    
    @Test.
    METHOD PUBLIC VOID AttachToClassFileAddsToGenerators():
        DEFINE VARIABLE gen AS StubInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE cls AS ClassFile NO-UNDO.
        
        gen = NEW StubInterfaceGenerator().
        cls = NEW ClassFile("OEMock/Tests/Util/ListObject.cls", "OEMock.Tests.Util.ListObject").
        
        gen:AttachTo(cls).
        
        Assert:AreEqual(gen,cls:Generators:MoveFirst()).
        
        IF VALID-OBJECT(cls) THEN DELETE OBJECT cls.
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AttachToProcedureFileAddsToGenerators():
        DEFINE VARIABLE gen  AS StubInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE proc AS ProcedureFile NO-UNDO.
        
        gen  = NEW StubInterfaceGenerator().
        proc = NEW ProcedureFile("OEMock/Tests/Inspection/TestProcedure.p").
        
        gen:AttachTo(proc).
        
        Assert:AreEqual(proc:Generators:MoveFirst(), gen).
        
        IF VALID-OBJECT(proc) THEN DELETE OBJECT proc.
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AttachToClassFileAddsToInterfaces():
        DEFINE VARIABLE gen AS StubInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE cls AS ClassFile NO-UNDO.
        
        gen = NEW StubInterfaceGenerator().
        cls = NEW ClassFile("OEMock/Tests/Util/ListObject.cls", "OEMock.Tests.Util.ListObject").
        
        gen:AttachTo(cls).
        
        AssertString:Contains(cls:Interfaces:MoveFirst(), "OEMock.Generation.StubInterface").
        
        IF VALID-OBJECT(cls) THEN DELETE OBJECT cls.
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AttachToClassFileAddsToUsingList():
        DEFINE VARIABLE gen AS StubInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE cls AS ClassFile NO-UNDO.
        
        gen = NEW StubInterfaceGenerator().
        cls = NEW ClassFile("OEMock/Tests/Util/ListObject.cls", "OEMock.Tests.Util.ListObject").
        
        gen:AttachTo(cls).
        
        AssertString:Contains(cls:UsingList:MoveFirst(), "OEMock.Generation.StubInterface").
        
        IF VALID-OBJECT(cls) THEN DELETE OBJECT cls.
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
END CLASS.