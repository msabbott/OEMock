/*------------------------------------------------------------------------
    File        : ListTester
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Tests.Util.ListObject.
USING OEMock.Util.List.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Util.ListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsDestroyOnDestructToTrue():
        DEFINE VARIABLE list AS List NO-UNDO.
        list = NEW List().
        Assert:IsTrue(list:DestroyOnDestruct).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankList():
        DEFINE VARIABLE list AS List NO-UNDO.
        list = NEW List().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemIncrementsCounter():
        DEFINE VARIABLE list AS List NO-UNDO.
        DEFINE VARIABLE obj  AS ListObject NO-UNDO.
        list = NEW List().
        obj  = NEW ListObject("Test Object").
        list:AddItem(obj).
        Assert:AreEqual(list:Count,1).
        IF VALID-OBJECT(obj) THEN DELETE OBJECT obj.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddItemDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE list AS List NO-UNDO.
        list = NEW List().
        list:AddItem(?).
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyListClearsList():
        DEFINE VARIABLE list AS List NO-UNDO.
        DEFINE VARIABLE obj  AS ListObject NO-UNDO.
        list = NEW List().
        obj  = NEW ListObject("Test Object").
        list:AddItem(obj).
        Assert:AreEqual(list:Count,1).
        list:EmptyList().
        Assert:AreEqual(list:Count,0).
        IF VALID-OBJECT(obj) THEN DELETE OBJECT obj.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetFirstIsNotNull():
        DEFINE VARIABLE list AS List NO-UNDO.
        DEFINE VARIABLE obj  AS ListObject NO-UNDO.
        list = NEW List().
        obj  = NEW ListObject("Test Object").
        list:AddItem(obj).
        Assert:IsNotNull(list:GetFirst()).
        IF VALID-OBJECT(obj) THEN DELETE OBJECT obj.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetFirstIsNullOnBlankList():
        DEFINE VARIABLE list AS List NO-UNDO.
        DEFINE VARIABLE obj  AS ListObject NO-UNDO.
        list = NEW List().
        obj  = NEW ListObject("Test Object").
        Assert:IsNull(list:GetFirst()).
        IF VALID-OBJECT(obj) THEN DELETE OBJECT obj.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetLastIsNotNull():
        DEFINE VARIABLE list AS List NO-UNDO.
        DEFINE VARIABLE obj  AS ListObject NO-UNDO.
        list = NEW List().
        obj  = NEW ListObject("Test Object").
        list:AddItem(obj).
        Assert:IsNotNull(list:GetLast()).
        IF VALID-OBJECT(obj) THEN DELETE OBJECT obj.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetLastIsNullOnBlankList():
        DEFINE VARIABLE list AS List NO-UNDO.
        DEFINE VARIABLE obj  AS ListObject NO-UNDO.
        list = NEW List().
        obj  = NEW ListObject("Test Object").
        Assert:IsNull(list:GetLast()).
        IF VALID-OBJECT(obj) THEN DELETE OBJECT obj.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetNextIsNotNull():
        DEFINE VARIABLE list AS List NO-UNDO.
        DEFINE VARIABLE obj  AS ListObject NO-UNDO.
        list = NEW List().
        obj  = NEW ListObject("Test Object").
        list:AddItem(obj).
        Assert:IsNotNull(list:GetNext()).
        IF VALID-OBJECT(obj) THEN DELETE OBJECT obj.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetNextIsNullOnBlankList():
        DEFINE VARIABLE list AS List NO-UNDO.
        DEFINE VARIABLE obj  AS ListObject NO-UNDO.
        list = NEW List().
        obj  = NEW ListObject("Test Object").
        Assert:IsNull(list:GetNext()).
        IF VALID-OBJECT(obj) THEN DELETE OBJECT obj.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetNextReturnsValidObjectsWithMultipleItemList():
        DEFINE VARIABLE list AS List NO-UNDO.
        DEFINE VARIABLE obj  AS ListObject NO-UNDO.
        
        list = NEW List().
        list:AddItem(NEW ListObject("Object 1")).
        list:AddItem(NEW ListObject("Object 2")).
        list:AddItem(NEW ListObject("Object 3")).
        
        Assert:AreEqual(list:Count, 3).
        
        obj = CAST(list:GetFirst(), "OEMock.Tests.Util.ListObject").
        Assert:IsTrue(VALID-OBJECT(obj)).
        Assert:AreEqual(obj:Name, "Object 1").
        
        obj = CAST(list:GetNext(), "OEMock.Tests.Util.ListObject").
        Assert:IsTrue(VALID-OBJECT(obj)).
        Assert:AreEqual(obj:Name, "Object 2").
        
        obj = CAST(list:GetNext(), "OEMock.Tests.Util.ListObject").
        Assert:IsTrue(VALID-OBJECT(obj)).
        Assert:AreEqual(obj:Name, "Object 3").

        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetPrevIsNotNull():
        DEFINE VARIABLE list AS List NO-UNDO.
        DEFINE VARIABLE obj  AS ListObject NO-UNDO.
        list = NEW List().
        obj  = NEW ListObject("Test Object").
        list:AddItem(obj).
        Assert:IsNotNull(list:GetPrev()).
        IF VALID-OBJECT(obj) THEN DELETE OBJECT obj.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GetPrevIsNullOnBlankList():
        DEFINE VARIABLE list AS List NO-UNDO.
        DEFINE VARIABLE obj  AS ListObject NO-UNDO.
        list = NEW List().
        obj  = NEW ListObject("Test Object").
        Assert:IsNull(list:GetPrev()).
        IF VALID-OBJECT(obj) THEN DELETE OBJECT obj.
        IF VALID-OBJECT(list) THEN DELETE OBJECT list.
    END METHOD.

END CLASS.