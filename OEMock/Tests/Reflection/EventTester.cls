/*------------------------------------------------------------------------
    File        : EventTester
    Purpose     : Unit tests for event class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.EventTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsName():
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        
        evnt = NEW Event("EventName").
        
        Assert:AreEqual(evnt:Name,"EventName").
        
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsStaticFalse():
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        
        evnt = NEW Event("EventName").
        
        Assert:IsFalse(evnt:Static,"EventName").
        
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsAbstractFalse():
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        
        evnt = NEW Event("EventName").
        
        Assert:IsFalse(evnt:Abstract,"EventName").
        
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsOverrideFalse():
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        
        evnt = NEW Event("EventName").
        
        Assert:IsFalse(evnt:Override,"EventName").
        
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesParameterList():
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        
        evnt = NEW Event("EventName").
        
        Assert:IsTrue(VALID-OBJECT(evnt:Parameters)).
        
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateReturnsValidEvent():
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        
        evnt = NEW Event("EventName").
        
        AssertString:Contains(evnt:Generate(), "DEFINE PUBLIC EVENT EventName SIGNATURE VOID ().").
        
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID SettingStaticSetsAbstractToFalse():
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        
        evnt = NEW Event('EventName').
        
        /* Set Abstract to True, then Static to True. Abstract
         * should then be set to False
         */
        evnt:Abstract = TRUE.
        evnt:Static   = TRUE.
        
        Assert:IsFalse(evnt:Abstract).
        
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID SettingAbstractSetsStaticToFalse():
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        
        evnt = NEW Event('EventName').
        
        /* Set Static to True, then Abstract to True. Static
         * should then be set to False
         */
        evnt:Static   = TRUE.
        evnt:Abstract = TRUE.
        
        Assert:IsFalse(evnt:Static).
        
        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateIncludesParameters():
        DEFINE VARIABLE evnt  AS Event NO-UNDO.
        DEFINE VARIABLE parm1 AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE parm2 AS PrimitiveParameter NO-UNDO.
        DEFINE VARIABLE outp  AS LONGCHAR NO-UNDO.
        
        evnt  = NEW Event('TestEvent').
        parm1 = NEW PrimitiveParameter('Param1', 'CHARACTER').
        parm2 = NEW PrimitiveParameter('Param2', 'CHARACTER').
        
        evnt:Parameters:AddParameter(parm1).
        evnt:Parameters:AddParameter(parm2).
        Assert:AreEqual(evnt:Parameters:Count, 2).
        
        outp = evnt:Generate().
        
        AssertString:Contains(outp, 'DEFINE PUBLIC EVENT TestEvent SIGNATURE VOID ('
                                    + CHR(13) + "INPUT Param1 AS CHARACTER,"
                                    + CHR(13) + "INPUT Param2 AS CHARACTER).").

        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesStaticMarker():
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        
        evnt = NEW Event('TestEvent').
        evnt:Static = TRUE.
        
        AssertString:Contains(evnt:Generate(), 'DEFINE PUBLIC STATIC EVENT TestEvent').

        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesAbstractMarker():
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        
        evnt = NEW Event('TestEvent').
        evnt:Abstract = TRUE.
        
        AssertString:Contains(evnt:Generate(), 'DEFINE PUBLIC ABSTRACT EVENT TestEvent').

        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesOverrideMarker():
        DEFINE VARIABLE evnt AS Event NO-UNDO.
        
        evnt = NEW Event('TestEvent').
        evnt:Override = TRUE.
        
        AssertString:Contains(evnt:Generate(), ' OVERRIDE ').

        IF VALID-OBJECT(evnt) THEN DELETE OBJECT evnt.
    END METHOD.

END CLASS.