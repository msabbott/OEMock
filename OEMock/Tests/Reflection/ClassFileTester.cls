 /*------------------------------------------------------------------------
    File        : ClassFileTester
    Purpose     : Unit tests for ClassFile class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Reflection.ClassFileTester: 
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesConstructorList():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        
        Assert:IsTrue(VALID-OBJECT(clsfile:Constructors)).
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesGeneratorsList():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        
        Assert:IsTrue(VALID-OBJECT(clsfile:Generators)).
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesMethodList():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        
        Assert:IsTrue(VALID-OBJECT(clsfile:Methods)).
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsTypeName():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        
        Assert:AreEqual(clsfile:TypeName, "OEMock.Tests.Util.ListObject").
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsPackage():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        
        Assert:AreEqual(clsfile:Package, "OEMock.Tests.Util").
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorSetsBlankInheritsFrom():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        
        Assert:AreEqual(clsfile:InheritsFrom, "").
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test(Expected='Progress.Lang.SysError').
    METHOD PUBLIC VOID ConstructorRaisesErrorWithInvalidClassName():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Invalid.Class.Name").
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesUsingStatements():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        
        AssertString:Contains(clsfile:Generate(), 
                              "USING Progress.Lang.*").
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesClass():
        DEFINE VARIABLE clsCode AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        clsCode = clsFile:Generate().

        AssertString:Contains(clsCode, 
                              "CLASS " + clsFile:TypeName + " :").

        AssertString:Contains(clsCode, 
                              "END CLASS.").
                              
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesMethods():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        clsfile:Methods:AddMethod(NEW Method('MethName', 'CHARACTER')).
        
        AssertString:Contains(clsfile:Generate(), 
                              'METHOD PUBLIC CHARACTER MethName ():' + CHR(10) + CHR(13) + "END METHOD.").
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesInheritsFroms():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        clsfile:InheritsFrom = "OEMock.DummyObject".

        AssertString:Contains(clsfile:Generate(), 
                              "CLASS " + clsFile:TypeName + " INHERITS " + clsFile:InheritsFrom + " :").
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.

END CLASS.