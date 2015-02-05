/*------------------------------------------------------------------------
    File        : WarningsTester
    Purpose     : Unit tests for Warnings class 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEUnit.Assertion.*.
USING OEMock.Util.Warnings.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Tests.Util.WarningsTester:
    
    @Test.
    METHOD PUBLIC VOID SuppressChangesWarnings():
        DEFINE VARIABLE SuppressedWarnings AS CHARACTER NO-UNDO.
        
        ASSIGN SuppressedWarnings = SESSION:SUPPRESS-WARNINGS-LIST.
        
        Warnings:Suppress().
        
        Assert:AreNotEqual(SESSION:SUPPRESS-WARNINGS-LIST, SuppressedWarnings).
        
        FINALLY:
            Warnings:Restore().
        END FINALLY.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID RestoreRestoresWarnings():
        DEFINE VARIABLE SuppressedWarnings AS CHARACTER NO-UNDO.
        
        ASSIGN SuppressedWarnings = SESSION:SUPPRESS-WARNINGS-LIST.
        
        Warnings:Suppress().
        
        Assert:AreNotEqual(SESSION:SUPPRESS-WARNINGS-LIST, SuppressedWarnings).
        
        Warnings:Restore().
        
        Assert:AreEqual(SESSION:SUPPRESS-WARNINGS-LIST, SuppressedWarnings).
        
        FINALLY:
            Warnings:Restore().
        END FINALLY.
    END METHOD.

END CLASS.