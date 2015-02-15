 /*------------------------------------------------------------------------
    File        : BaseMethodGeneratorTester
    Purpose     : Unit tests for BaseMethodGenerator class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Generation.*.
USING OEMock.Reflection.*.

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
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        meth = NEW BaseMethod().
        parm = NEW PrimitiveParameter("Param1", "INTEGER").
        meth:Parameters:AddParameter(parm).
        
        gen = NEW BaseMethodGenerator().
        gen:AttachTo(meth).
        gen:SetParameterOutputValue("Param1", "1234").
        Assert:AreEqual(gen:ParameterOutputValues:GetValue("Param1"), "1234").
        
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID SetParameterOutputValueFormatsCharacterParams():
        DEFINE VARIABLE gen AS BaseMethodGenerator NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod NO-UNDO.
        DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
        
        meth = NEW BaseMethod().
        parm = NEW PrimitiveParameter("Param1", "CHARACTER").
        meth:Parameters:AddParameter(parm).
        
        gen = NEW BaseMethodGenerator().
        gen:AttachTo(meth).
        gen:SetParameterOutputValue("Param1", "Value1").
        Assert:AreEqual(gen:ParameterOutputValues:GetValue("Param1"), '"Value1"').
        
        gen:SetParameterOutputValue("Param1", "'Value2'").
        Assert:AreEqual(gen:ParameterOutputValues:GetValue("Param1"), "'Value2'").
        
        gen:SetParameterOutputValue("Param1", '"Value3"').
        Assert:AreEqual(gen:ParameterOutputValues:GetValue("Param1"), '"Value3"').
        
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(meth) THEN DELETE OBJECT meth.
        IF VALID-OBJECT(parm) THEN DELETE OBJECT parm.
        
    END METHOD.

END CLASS.