 /*------------------------------------------------------------------------
    File        : TempTable
    Purpose     : Represents a Temp-Table in code.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.TempTable:
        
    DEFINE PUBLIC PROPERTY Name AS CHARACTER NO-UNDO 
    GET.
    PROTECTED SET.
        
    DEFINE PUBLIC PROPERTY NamespacePrefix AS CHARACTER NO-UNDO 
    GET.
    SET.
        
    DEFINE PUBLIC PROPERTY NamespaceURI AS CHARACTER NO-UNDO 
    GET.
    SET.

	DEFINE PUBLIC PROPERTY NoUndo AS LOGICAL INITIAL TRUE NO-UNDO 
	GET.
	SET.

    DEFINE PUBLIC PROPERTY Static AS LOGICAL INITIAL FALSE NO-UNDO 
    GET.
    SET.
    
    CONSTRUCTOR PUBLIC TempTable(INPUT nam AS CHARACTER):
        SUPER().
        
        ASSIGN Name               = nam
               NamespacePrefix    = ""
               NamespaceURI       = ""
               NoUndo             = TRUE
               THIS-OBJECT:Static = FALSE.
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC TempTable():
    END DESTRUCTOR.
    
    METHOD PUBLIC LONGCHAR Generate():
        
        DEFINE VARIABLE res AS LONGCHAR        NO-UNDO.
        
        res = SUBSTITUTE("DEFINE &2TEMP-TABLE &3&4&5&6&1",
                         CHR(10),
                         (IF THIS-OBJECT:Static THEN "STATIC " ELSE ""),
                         NAME,
                         (IF NoUndo THEN " NO-UNDO " ELSE ""),
                         (IF NamespacePrefix NE ? AND NamespacePrefix NE "" THEN "NAMESPACE-PREFIX ~"" + NamespacePrefix + "~" " ELSE ""),
                         (IF NamespaceURI    NE ? AND NamespaceURI    NE "" THEN "NAMESPACE-URI ~""    + NamespaceURI    + "~" " ELSE "")).
        RETURN res.
    END METHOD.
    
    

END CLASS.