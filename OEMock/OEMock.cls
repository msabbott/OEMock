 /*------------------------------------------------------------------------
    File        : OEMock
    Purpose     : Controller object for creating test doubles. 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.OEMock: 
    
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
    
    METHOD PUBLIC STATIC VOID CleanUp():
        OS-DELETE VALUE(OutputDir) RECURSIVE.
        OutputDir = ?.
    END METHOD.
    
    METHOD PUBLIC STATIC OEMock.Stub StubClass(INPUT fname AS CHARACTER):
        DEFINE VARIABLE insp AS OEMock.Inspection.ClassInspector NO-UNDO.
        DEFINE VARIABLE stb  AS OEMock.Stub NO-UNDO.
        
        SetOutputDir().
        
        insp = NEW OEMock.Inspection.ClassInspector(fname).
        
        IF VALID-OBJECT(insp) THEN
        DO:
            stb = NEW OEMock.Stub(INPUT insp:Inspect(), INPUT OutputDir).
        END.
        
        RETURN stb.
    END METHOD.

END CLASS.