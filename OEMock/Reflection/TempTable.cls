 /*------------------------------------------------------------------------
    File        : TempTable
    Purpose     : Represents a Temp-Table in code.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.TempTableField.
USING OEMock.Reflection.TempTableFieldList.
USING OEMock.Reflection.TempTableIndex.
USING OEMock.Reflection.TempTableIndexList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.TempTable:
    
    DEFINE PUBLIC PROPERTY Fields AS OEMock.Reflection.TempTableFieldList NO-UNDO
    GET.
    PROTECTED SET.
    
    DEFINE PUBLIC PROPERTY Indexes AS OEMock.Reflection.TempTableIndexList NO-UNDO
    GET.
    PROTECTED SET.
        
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
        
        ASSIGN THIS-OBJECT:Fields  = NEW TempTableFieldList()
               THIS-OBJECT:Indexes = NEW TempTableIndexList()
               Name                = nam
               NamespacePrefix     = ""
               NamespaceURI        = ""
               NoUndo              = TRUE
               THIS-OBJECT:Static  = FALSE.
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC TempTable():
        IF VALID-OBJECT(THIS-OBJECT:Fields)  THEN DELETE OBJECT THIS-OBJECT:Fields.
        IF VALID-OBJECT(THIS-OBJECT:Indexes) THEN DELETE OBJECT THIS-OBJECT:Indexes.
    END DESTRUCTOR.
    
    METHOD PUBLIC LONGCHAR Generate():
        
        DEFINE VARIABLE res AS LONGCHAR       NO-UNDO.
        DEFINE VARIABLE fld AS TempTableField NO-UNDO.
        DEFINE VARIABLE idx AS TempTableIndex NO-UNDO.
        
        res = SUBSTITUTE("DEFINE &2TEMP-TABLE &3&4&5&6&1",
                         CHR(10),
                         (IF THIS-OBJECT:Static THEN "STATIC " ELSE ""),
                         NAME,
                         (IF NoUndo THEN " NO-UNDO " ELSE ""),
                         (IF NamespacePrefix NE ? AND NamespacePrefix NE "" THEN "NAMESPACE-PREFIX ~"" + NamespacePrefix + "~" " ELSE ""),
                         (IF NamespaceURI    NE ? AND NamespaceURI    NE "" THEN "NAMESPACE-URI ~""    + NamespaceURI    + "~" " ELSE "")).

        /* Build field list */
        fld = THIS-OBJECT:Fields:MoveFirst().
        DO WHILE(VALID-OBJECT(fld)):
            res = res + " " + fld:Generate().
            fld = THIS-OBJECT:Fields:MoveNext().
        END.
        
        /* Build index list */
        idx = THIS-OBJECT:Indexes:MoveFirst().
        DO WHILE(VALID-OBJECT(idx)):
            res = res + " " + idx:Generate().
            idx = THIS-OBJECT:Indexes:MoveNext().
        END.

        /* Trim contents and add ending fullstop */
        ASSIGN res = TRIM(TRIM(res),".") + ".".
                                 
        RETURN res.
    END METHOD.
    
END CLASS.