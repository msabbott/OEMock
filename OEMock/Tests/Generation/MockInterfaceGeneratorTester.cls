/*------------------------------------------------------------------------
    File        : MockInterfaceGeneratorTester
    Purpose     : Unit tests for MockInterfaceGenerator 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Generation.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Generation.MockInterfaceGeneratorTester:
    
    @Test.
    METHOD PUBLIC VOID GenerateGeneratesTempTableOEMockExpectationMethodCall():
        DEFINE VARIABLE gen AS MockInterfaceGenerator NO-UNDO.
        
        gen = NEW MockInterfaceGenerator().

        AssertString:Contains(gen:Generate(), "DEFINE TEMP-TABLE OEMockExpectationMethodCall NO-UNDO").

        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateGeneratesTempTableOEMockExpectationMethodCallParam():
        DEFINE VARIABLE gen AS MockInterfaceGenerator NO-UNDO.
        
        gen = NEW MockInterfaceGenerator().

        AssertString:Contains(gen:Generate(), "DEFINE TEMP-TABLE OEMockExpectationMethodCallParam NO-UNDO").

        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateGeneratesMethodOEMockRegisterMethodCall():
        DEFINE VARIABLE gen AS MockInterfaceGenerator NO-UNDO.
        
        gen = NEW MockInterfaceGenerator().

        AssertString:Contains(gen:Generate(), "METHOD PRIVATE INTEGER OEMockRegisterMethodCall(INPUT methRef AS CHARACTER):").

        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateGeneratesMethodOEMockRegisterMethodCallParam():
        DEFINE VARIABLE gen AS MockInterfaceGenerator NO-UNDO.
        
        gen = NEW MockInterfaceGenerator().

        AssertString:Contains(gen:Generate(), "METHOD PRIVATE VOID OEMockRegisterMethodCallParam(INPUT callNo AS INTEGER, INPUT parmName AS CHARACTER, INPUT parmValue AS CHARACTER):").

        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateProceduralGeneratesTempTableOEMockExpectationMethodCall():
        DEFINE VARIABLE gen AS MockInterfaceGenerator NO-UNDO.
        
        gen = NEW MockInterfaceGenerator().

        AssertString:Contains(gen:GenerateProcedural(), "DEFINE TEMP-TABLE OEMockExpectationMethodCall NO-UNDO").

        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateProceduralGeneratesTempTableOEMockExpectationMethodCallParam():
        DEFINE VARIABLE gen AS MockInterfaceGenerator NO-UNDO.
        
        gen = NEW MockInterfaceGenerator().

        AssertString:Contains(gen:GenerateProcedural(), "DEFINE TEMP-TABLE OEMockExpectationMethodCallParam NO-UNDO").

        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateProceduralGeneratesFunctionOEMockRegisterMethodCall():
        DEFINE VARIABLE gen AS MockInterfaceGenerator NO-UNDO.
        
        gen = NEW MockInterfaceGenerator().

        AssertString:Contains(gen:GenerateProcedural(), "FUNCTION OEMockRegisterMethodCall RETURNS INTEGER (INPUT methRef AS CHARACTER):").

        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateProceduralGeneratesFunctionOEMockRegisterMethodCallParam():
        DEFINE VARIABLE gen AS MockInterfaceGenerator NO-UNDO.
        
        gen = NEW MockInterfaceGenerator().

        AssertString:Contains(gen:GenerateProcedural(), "FUNCTION OEMockRegisterMethodCallParam RETURNS INTEGER (INPUT callNo AS INTEGER, INPUT parmName AS CHARACTER, INPUT parmValue AS CHARACTER):").

        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AttachToClassFileAddsToGenerators():
        DEFINE VARIABLE gen AS MockInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE cls AS ClassFile NO-UNDO.
        
        gen = NEW MockInterfaceGenerator().
        cls = NEW ClassFile("OEMock/Tests/Util/ListObject.cls", "OEMock.Tests.Util.ListObject").
        
        gen:AttachTo(cls).
        
        Assert:AreEqual(gen,cls:Generators:MoveFirst()).
        
        IF VALID-OBJECT(cls) THEN DELETE OBJECT cls.
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AttachToProcedureFileAddsToGenerators():
        DEFINE VARIABLE gen  AS MockInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE proc AS ProcedureFile NO-UNDO.
        
        gen  = NEW MockInterfaceGenerator().
        proc = NEW ProcedureFile("OEMock/Tests/Inspection/TestProcedure.p").
        
        gen:AttachTo(proc).
        
        Assert:AreEqual(proc:Generators:MoveFirst(), gen).
        
        IF VALID-OBJECT(proc) THEN DELETE OBJECT proc.
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AttachToClassFileAddsToInterfaces():
        DEFINE VARIABLE gen AS MockInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE cls AS ClassFile NO-UNDO.
        
        gen = NEW MockInterfaceGenerator().
        cls = NEW ClassFile("OEMock/Tests/Util/ListObject.cls", "OEMock.Tests.Util.ListObject").
        
        gen:AttachTo(cls).
        
        AssertString:Contains(cls:Interfaces:MoveFirst(), "OEMock.Generation.MockInterface").
        
        IF VALID-OBJECT(cls) THEN DELETE OBJECT cls.
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AttachToClassFileAddsToUsingList():
        DEFINE VARIABLE gen AS MockInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE cls AS ClassFile NO-UNDO.
        
        gen = NEW MockInterfaceGenerator().
        cls = NEW ClassFile("OEMock/Tests/Util/ListObject.cls", "OEMock.Tests.Util.ListObject").
        
        gen:AttachTo(cls).
        
        AssertString:Contains(cls:UsingList:MoveFirst(), "OEMock.Generation.MockInterface").
        
        IF VALID-OBJECT(cls) THEN DELETE OBJECT cls.
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
END CLASS.