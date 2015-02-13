 /*------------------------------------------------------------------------
    File        : BaseMethodGeneratorTester
    Purpose     : Unit tests for BaseMethodGenerator class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Generation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Generation.BaseMethodGeneratorTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesParameterOutputValues():
        DEFINE VARIABLE gen AS BaseMethodGenerator NO-UNDO.
        
        gen = NEW BaseMethodGenerator().
        
        Assert:IsTrue(VALID-OBJECT(gen:ParameterOutputValues)).
        
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlank():
        DEFINE VARIABLE gen AS BaseMethodGenerator NO-UNDO.
        
        gen = NEW BaseMethodGenerator().
        
        Assert:AreEqual(gen:Generate(), "").
        
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateProceduralReturnsBlank():
        DEFINE VARIABLE gen AS BaseMethodGenerator NO-UNDO.
        
        gen = NEW BaseMethodGenerator().
        
        Assert:AreEqual(gen:GenerateProcedural(), "").
        
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID SetParameterOutputValueSetsItemInList():
        DEFINE VARIABLE gen AS BaseMethodGenerator NO-UNDO.
        
        gen = NEW BaseMethodGenerator().
        gen:SetParameterOutputValue("Param1", "Value1").
        Assert:AreEqual(gen:ParameterOutputValues:GetValue("Param1"), "Value1").
        
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
        
    END METHOD.

END CLASS.