/*------------------------------------------------------------------------
    File        : ClassToTest
    Purpose     : Class to be tested in Unit Tests
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING "Examples.Example 5.ClassToMock".

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS "Examples.Example 5.ClassToTest": 
    
    CONSTRUCTOR ClassToTest():
    END CONSTRUCTOR.
    
    DESTRUCTOR ClassToTest():
    END DESTRUCTOR.
    
    METHOD PUBLIC CHARACTER SayHello():
        
        DEFINE VARIABLE clsUsers    AS ClassToMock NO-UNDO.
        DEFINE VARIABLE MessageText AS CHARACTER   NO-UNDO.
        
        clsUsers = NEW ClassToMock().
        MessageText = clsUsers:GetUserName().
        
        CASE MessageText:
    
            WHEN ? THEN
            DO:
                ASSIGN MessageText = "Hello World".
            END.
            
            WHEN "" THEN
            DO:
                ASSIGN MessageText = "Hello, person with no name".
            END.
            
            OTHERWISE
            DO:
                ASSIGN MessageText = "Hello, " + MessageText.
            END.
        END CASE.
        
        RETURN MessageText.
        
        FINALLY:
            IF VALID-OBJECT(clsUsers) THEN DELETE OBJECT clsUsers.
        END.
        
    END METHOD.

END CLASS.