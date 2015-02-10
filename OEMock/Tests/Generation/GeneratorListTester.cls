/*------------------------------------------------------------------------
    File        : GeneratorListTester
    Purpose     : Unit tests for GeneratorList class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Generation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Generation.GeneratorListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddGeneratorIncrementsCounter():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator(gen).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        list:AddGenerator(?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator(gen).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNotNull():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator(gen).
        Assert:IsNotNull(list:MoveFirst()).
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW BaseGenerator().
        Assert:IsNull(list:MoveFirst()).
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS StubInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE res  AS BaseGenerator NO-UNDO.
        
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW StubInterfaceGenerator().
        
        list:AddGenerator(gen).
        res = list:MoveFirst().
        
        AssertString:Contains(res:GetClass():TypeName, 'StubInterfaceGenerator').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Generation.StubInterfaceGenerator')).
        
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNotNull():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator(gen).
        Assert:IsNotNull(list:MoveLast()).
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW BaseGenerator().
        Assert:IsNull(list:MoveLast()).
        IF VALID-OBJECT(gen)  THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS StubInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE res  AS BaseGenerator NO-UNDO.
        
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW StubInterfaceGenerator().
        
        list:AddGenerator(gen).
        res = list:MoveLast().
        
        AssertString:Contains(res:GetClass():TypeName, 'StubInterfaceGenerator').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Generation.StubInterfaceGenerator')).
        
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

    @Test.
    METHOD PUBLIC VOID MoveNextIsNotNull():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator(gen).
        Assert:IsNotNull(list:MoveNext()).
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW BaseGenerator().
        Assert:IsNull(list:MoveNext()).
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS StubInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE res  AS BaseGenerator NO-UNDO.
        
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW StubInterfaceGenerator().
        
        list:AddGenerator(gen).
        res = list:MoveNext().
        
        AssertString:Contains(res:GetClass():TypeName, 'StubInterfaceGenerator').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Generation.StubInterfaceGenerator')).
        
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

    @Test.
    METHOD PUBLIC VOID MoveNextReturnsValidObjectsWithMultipleItemList():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE res  AS BaseGenerator NO-UNDO.
        
        list = NEW OEMock.Generation.GeneratorList().
        list:AddGenerator(NEW StubInterfaceGenerator()).
        list:AddGenerator(NEW StubInterfaceGenerator()).
        list:AddGenerator(NEW StubInterfaceGenerator()).

        res = list:MoveFirst().
        AssertString:Contains(res:GetClass():TypeName, 'StubInterfaceGenerator').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Generation.StubInterfaceGenerator')).

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'StubInterfaceGenerator').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Generation.StubInterfaceGenerator')).

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'StubInterfaceGenerator').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Generation.StubInterfaceGenerator')).
        
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

    @Test.
    METHOD PUBLIC VOID MovePrevIsNotNull():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW BaseGenerator().
        list:AddGenerator(gen).
        Assert:IsNotNull(list:MovePrev()).
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS BaseGenerator NO-UNDO.
        list = NEW OEMock.Generation.GeneratorList().
        gen = NEW BaseGenerator().
        Assert:IsNull(list:MovePrev()).
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevReturnsSubClass():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE gen  AS StubInterfaceGenerator NO-UNDO.
        DEFINE VARIABLE res  AS BaseGenerator NO-UNDO.
        
        list = NEW OEMock.Generation.GeneratorList().
        gen  = NEW StubInterfaceGenerator().
        
        list:AddGenerator(gen).
        res = list:MovePrev().
        
        AssertString:Contains(res:GetClass():TypeName, 'StubInterfaceGenerator').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Generation.StubInterfaceGenerator')).
        
        IF VALID-OBJECT(gen) THEN DELETE OBJECT gen.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsBlankWithEmptyList():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        
        list = NEW OEMock.Generation.GeneratorList().
        
        Assert:AreEqual(list:Generate(), "").
        
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateProceduralReturnsBlankWithEmptyList():
        DEFINE VARIABLE list AS OEMock.Generation.GeneratorList NO-UNDO.
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        
        list = NEW OEMock.Generation.GeneratorList().
        
        Assert:AreEqual(list:GenerateProcedural(), "").
        
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.