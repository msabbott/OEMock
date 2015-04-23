/*------------------------------------------------------------------------
    File        : EventListTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.EventListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddEventIncrementsCounter():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        DEFINE VARIABLE drel AS Event NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        drel = NEW Event("EventName").
        list:AddEvent(drel).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        list:AddEvent(?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        DEFINE VARIABLE drel AS Event NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        drel = NEW Event("EventName").
        list:AddEvent(drel).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        DEFINE VARIABLE drel AS Event NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        drel = NEW Event("EventName").
        list:AddEvent(drel).
        Assert:IsNotNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        DEFINE VARIABLE drel AS Event NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        drel = NEW Event("EventName").
        Assert:IsNull(list:MoveFirst()).
        IF VALID-OBJECT(drel) THEN DELETE OBJECT drel.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        evnt = NEW Event("EventName").
        list:AddEvent(evnt).
        Assert:IsNotNull(list:MoveLast()).
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        evnt = NEW Event("EventName").
        Assert:IsNull(list:MoveLast()).
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        evnt = NEW Event("EventName").
        list:AddEvent(evnt).
        Assert:IsNotNull(list:MoveNext()).
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        evnt = NEW Event("EventName").
        Assert:IsNull(list:MoveNext()).
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextReturnsValidObjectsWithMultipleItemList():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        DEFINE VARIABLE res  AS Event NO-UNDO.
        
        list = NEW OEMock.Reflection.EventList().
        list:AddEvent(NEW Event('Relation1')).
        list:AddEvent(NEW Event('Relation2')).
        list:AddEvent(NEW Event('Relation3')).

        res = list:MoveFirst().
        AssertString:Contains(res:GetClass():TypeName, 'Event').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.Event')).
        Assert:AreEqual(res:Name, "Relation1").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'Event').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.Event')).
        Assert:AreEqual(res:Name, "Relation2").

        res = list:MoveNext().
        AssertString:Contains(res:GetClass():TypeName, 'Event').
        Assert:IsTrue(res:GetClass():IsA('OEMock.Reflection.Event')).
        Assert:AreEqual(res:Name, "Relation3").
        
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNotNull():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        evnt = NEW Event("EventName").
        list:AddEvent(evnt).
        Assert:IsNotNull(list:MovePrev()).
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNullOnBlankList():
        DEFINE VARIABLE list AS OEMock.Reflection.EventList NO-UNDO.
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        list = NEW OEMock.Reflection.EventList().
        evnt = NEW Event("EventName").
        Assert:IsNull(list:MovePrev()).
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.