 /*------------------------------------------------------------------------
    File        : OEMock
    Purpose     : Controller object for creating test doubles. 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.OEMock:
    
    DEFINE PUBLIC STATIC PROPERTY DebugMode AS LOGICAL NO-UNDO INITIAL FALSE
        GET.
        SET.
    
    DEFINE PUBLIC STATIC PROPERTY OutputDir AS CHARACTER NO-UNDO INITIAL ?
        GET.
        PROTECTED SET.
    
    METHOD PROTECTED STATIC VOID SetOutputDir():
        IF OutputDir = ? THEN
        DO:
            OutputDir = GUID(GENERATE-UUID) + "/".
            OS-CREATE-DIR VALUE(OutputDir).
        END.
    END METHOD.
    
    METHOD PROTECTED STATIC VOID InsertIntoPropath():
        
        IF OutputDir = ? OR OutputDir = "" THEN RETURN.
        
        IF LOOKUP(OutputDir, PROPATH) = 0 THEN
            PROPATH = OutputDir + "," + PROPATH.
    END METHOD.
    
    METHOD PROTECTED STATIC VOID RemoveFromPropath():
        
        IF OutputDir = ? OR OutputDir = "" THEN RETURN.
        
        IF LOOKUP(OutputDir, PROPATH) > 0 THEN
            PROPATH = REPLACE(PROPATH, OutputDir + ",", "").
    END METHOD.
    
    METHOD PUBLIC STATIC VOID CleanUp():
        IF NOT DebugMode THEN
            OS-DELETE VALUE(OutputDir) RECURSIVE.
        RemoveFromProPath().
        OutputDir = ?.
    END METHOD.
    
    METHOD PUBLIC STATIC OEMock.Stub StubClass(INPUT fname AS CHARACTER):
        DEFINE VARIABLE insp AS OEMock.Inspection.ClassInspector NO-UNDO.
        DEFINE VARIABLE stb  AS OEMock.Stub NO-UNDO.
        
        SetOutputDir().
        InsertIntoPropath().
        
        insp = NEW OEMock.Inspection.ClassInspector(fname).
        
        IF VALID-OBJECT(insp) THEN
        DO:
            stb = NEW OEMock.Stub(INPUT insp:Inspect(), INPUT OutputDir).
            IF DebugMode THEN stb:DeleteOnDestruct = FALSE.
        END.
        
        RETURN stb.
    END METHOD.
    
    METHOD PUBLIC STATIC OEMock.Stub StubProcedure(INPUT fname AS CHARACTER):
        DEFINE VARIABLE insp AS OEMock.Inspection.ProcedureInspector NO-UNDO.
        DEFINE VARIABLE stb  AS OEMock.Stub NO-UNDO.
        
        SetOutputDir().
        InsertIntoPropath().
        
        insp = NEW OEMock.Inspection.ProcedureInspector(fname).
        
        IF VALID-OBJECT(insp) THEN
        DO:
            stb = NEW OEMock.Stub(INPUT insp:Inspect(), INPUT OutputDir).
            IF DebugMode THEN stb:DeleteOnDestruct = FALSE.
        END.
        
        RETURN stb.
    END METHOD.

END CLASS.