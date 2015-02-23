/*------------------------------------------------------------------------
    File        : ClassInspectorTester
    Purpose     : Unit tests for ClassInspector class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Inspection.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Inspection.ClassInspectorTester:
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsFileName():
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        
        insp = NEW ClassInspector("FileName").
        
        Assert:AreEqual(insp:FileName, "FileName").
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT insp.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID InspectReturnsClassFile():
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        DEFINE VARIABLE cls  AS BaseFile       NO-UNDO.
        
        insp = NEW ClassInspector("OEMock/Tests/Util/ListObject.cls").
        cls  = insp:Inspect().
        
        Assert:IsTrue(VALID-OBJECT(cls), "Invalid object returned").
        Assert:IsTrue(cls:GetClass():IsA("OEMock.Reflection.ClassFile"), cls:GetClass():TypeName).
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT insp.
        IF VALID-OBJECT(cls)  THEN DELETE OBJECT cls.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID InspectReturnsClassWithMethods():
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        DEFINE VARIABLE base AS BaseFile       NO-UNDO.
        DEFINE VARIABLE cls  AS ClassFile      NO-UNDO.
        
        insp = NEW ClassInspector("OEMock/Inspection/ClassInspector.cls").
        base = insp:Inspect().
        
        Assert:IsTrue(VALID-OBJECT(base), "Invalid object returned").
        
        IF base:GetClass():IsA("OEMock.Reflection.ClassFile") THEN
        DO:
            cls = DYNAMIC-CAST(base, base:GetClass():TypeName).
            Assert:IsTrue(cls:Methods:Count > 0).
        END.
        ELSE
        DO:
            Assert:Fail("Incompatible object type returned").
        END.
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT insp.
        IF VALID-OBJECT(base) THEN DELETE OBJECT base.
        IF VALID-OBJECT(cls)  THEN DELETE OBJECT cls.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID InspectReturnsClassWithConstructors():
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        DEFINE VARIABLE base AS BaseFile       NO-UNDO.
        DEFINE VARIABLE cls  AS ClassFile      NO-UNDO.
        
        insp = NEW ClassInspector("OEMock/Inspection/ClassInspector.cls").
        base = insp:Inspect().
        
        Assert:IsTrue(VALID-OBJECT(base), "Invalid object returned").
        
        IF base:GetClass():IsA("OEMock.Reflection.ClassFile") THEN
        DO:
            cls = DYNAMIC-CAST(base, base:GetClass():TypeName).
            Assert:IsTrue(cls:Constructors:Count > 0).
        END.
        ELSE
        DO:
            Assert:Fail("Incompatible object type returned").
        END.
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT insp.
        IF VALID-OBJECT(base) THEN DELETE OBJECT base.
        IF VALID-OBJECT(cls)  THEN DELETE OBJECT cls.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID InspectReturnsClassInheritance():
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        DEFINE VARIABLE base AS BaseFile       NO-UNDO.
        DEFINE VARIABLE cls  AS ClassFile      NO-UNDO.
        
        insp = NEW ClassInspector("OEMock/Inspection/ClassInspector.cls").
        base = insp:Inspect().
        
        Assert:IsTrue(VALID-OBJECT(base), "Invalid object returned").
        
        IF base:GetClass():IsA("OEMock.Reflection.ClassFile") THEN
        DO:
            cls = DYNAMIC-CAST(base, base:GetClass():TypeName).
            AssertString:IsNotNullOrEmpty(cls:InheritsFrom).
        END.
        ELSE
        DO:
            Assert:Fail("Incompatible object type returned").
        END.
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT insp.
        IF VALID-OBJECT(base) THEN DELETE OBJECT base.
        IF VALID-OBJECT(cls)  THEN DELETE OBJECT cls.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID InspectCreatesMethodParameters():
        DEFINE VARIABLE insp AS ClassInspector NO-UNDO.
        DEFINE VARIABLE base AS BaseFile       NO-UNDO.
        DEFINE VARIABLE cls  AS ClassFile      NO-UNDO.
        DEFINE VARIABLE meth AS BaseMethod     NO-UNDO.
        
        insp = NEW ClassInspector("OEMock/Tests/Util/ListObject.cls").
        base = insp:Inspect().
        
        Assert:IsTrue(VALID-OBJECT(base), "Invalid object returned").
        
        IF base:GetClass():IsA("OEMock.Reflection.ClassFile") THEN
        DO:
            cls = DYNAMIC-CAST(base, base:GetClass():TypeName).
            
            meth = cls:Methods:MoveFirst().
            Assert:IsTrue(meth:Parameters:Count > 0, STRING(meth:Parameters:Count)).
        END.
        ELSE
        DO:
            Assert:Fail("Incompatible object type returned").
        END.
        
        IF VALID-OBJECT(insp) THEN DELETE OBJECT insp.
        IF VALID-OBJECT(base) THEN DELETE OBJECT base.
        IF VALID-OBJECT(cls)  THEN DELETE OBJECT cls.
    END METHOD.

END CLASS.