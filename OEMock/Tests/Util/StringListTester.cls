/*------------------------------------------------------------------------
    File        : StringListTester
    Purpose     : Unit tests for StringList class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Util.StringList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Util.StringListTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesBlankStringList():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        Assert:AreEqual(StringList:Count,0).
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddIncrementsCounter():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        StringList:Add("String 1").
        Assert:AreEqual(StringList:Count,1).
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID AddDoesNotIncrementCounterWhenNull():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        StringList:Add(?).
        Assert:AreEqual(StringList:Count,0).
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID EmptyStringListClearsStringList():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        StringList:Add("String 1").
        Assert:AreEqual(StringList:Count,1).
        StringList:EmptyList().
        Assert:AreEqual(StringList:Count,0).
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsNotNull():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        StringList:Add("String 1").
        Assert:IsNotNull(StringList:MoveFirst()).
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveFirstIsBlankOnBlankStringList():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        Assert:AreEqual(StringList:MoveFirst(), "").
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsNotNull():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        StringList:Add("String 1").
        Assert:IsNotNull(StringList:MoveLast()).
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveLastIsBlankOnBlankStringList():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        Assert:AreEqual(StringList:MoveLast(), "").
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsNotNull():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        StringList:Add("String 1").
        Assert:IsNotNull(StringList:MoveNext()).
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MoveNextIsBlankOnBlankStringList():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        Assert:AreEqual(StringList:MoveNext(), "").
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsNotNull():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        StringList:Add("String 1").
        Assert:IsNotNull(StringList:MovePrev()).
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID MovePrevIsBlankOnBlankStringList():
        DEFINE VARIABLE StringList AS StringList NO-UNDO.
        StringList = NEW StringList().
        Assert:AreEqual(StringList:MovePrev(), "").
        IF VALID-OBJECT(StringList) THEN DELETE OBJECT StringList.
    END METHOD.
    
END CLASS.