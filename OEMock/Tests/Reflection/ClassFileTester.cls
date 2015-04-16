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
    METHOD PUBLIC VOID ConstructorCreatesInterfacesList():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        
        Assert:IsTrue(VALID-OBJECT(clsfile:Interfaces)).
        
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
    METHOD PUBLIC VOID ConstructorCreatesUsingList():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        
        Assert:IsTrue(VALID-OBJECT(clsfile:UsingList)).
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesTempTablesList():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        
        Assert:IsTrue(VALID-OBJECT(clsfile:TempTables)).
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID ConstructorCreatesDataSetsList():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        
        Assert:IsTrue(VALID-OBJECT(clsfile:DataSets)).
        
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
    METHOD PUBLIC VOID ConstructHandlesClassNamesWithSpaces():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "Examples.Example 3.ClassToStub").
        
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
    METHOD PUBLIC VOID GenerateCreatesUsingStatementsFromList():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        clsfile:UsingList:Add("OEMock.Tests.*").

        AssertString:Contains(clsfile:Generate(), 
                              "USING Progress.Lang.*",
                              STRING(clsfile:Generate())).
                              
        AssertString:Contains(clsfile:Generate(), 
                              "USING OEMock.Tests.*",
                              STRING(clsfile:Generate())).
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesUsingStatementsNoDuplicateProgressLangStar():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        DEFINE VARIABLE txt     AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE ind     AS INTEGER   NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        clsfile:UsingList:Add("Progress.Lang.*").
        
        txt = clsfile:Generate().
        ind = INDEX(txt, "USING Progress.Lang.*").
        
        /* Verify it is not found after first instance */
        Assert:AreEqual(INDEX(txt,"USING Progress.Lang.*", ind + 1),
                        0).

        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateCreatesUsingStatementsWithSpaces():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        clsfile:UsingList:Add("Examples.Example 3.ClassToStub").

        AssertString:Contains(clsfile:Generate(), 
                              'USING "Examples.Example 3.ClassToStub".',
                              STRING(clsfile:Generate())).
        
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
    METHOD PUBLIC VOID GenerateObservesTempTables():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        DEFINE VARIABLE outp    AS LONGCHAR  NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        clsfile:TempTables:AddTempTable(NEW OEMock.Reflection.TempTable('ttName')).
        
        outp = clsfile:Generate().
        AssertString:Contains(outp, "DEFINE TEMP-TABLE ttName"). 
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesDataSets():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        DEFINE VARIABLE outp    AS LONGCHAR  NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        clsfile:DataSets:AddDataSet(NEW OEMock.Reflection.DataSet('dsName')).
        
        outp = clsfile:Generate().
        AssertString:Contains(outp, "DEFINE DATASET dsName"). 
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesMethods():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        DEFINE VARIABLE outp    AS LONGCHAR  NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        clsfile:Methods:AddMethod(NEW Method('MethName', 'CHARACTER')).
        
        outp = clsfile:Generate().
        AssertString:Contains(outp, 'METHOD PUBLIC CHARACTER MethName ():').
        AssertString:Contains(outp, "END METHOD.").
        
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
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesInterfaces():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "OEMock.Tests.Util.ListObject").
        clsfile:Interfaces:Add("DummyInterface").
        clsfile:Interfaces:Add("DummyInterface2").

        AssertString:Contains(clsfile:Generate(), 
                              "CLASS " + clsFile:TypeName + "  IMPLEMENTS DummyInterface, DummyInterface2").
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID GenerateObservesSpacesInClassPackage():
        DEFINE VARIABLE clsfile AS ClassFile NO-UNDO.
        
        clsfile = NEW ClassFile("FileName", "Examples.Example 3.ClassToStub").

        AssertString:Contains(clsfile:Generate(), 
                              'CLASS "' + clsFile:TypeName + '" ').
        
        IF VALID-OBJECT(clsfile) THEN DELETE OBJECT clsfile.
    END METHOD.

END CLASS.