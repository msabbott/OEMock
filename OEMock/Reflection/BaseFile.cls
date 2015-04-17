/*------------------------------------------------------------------------
    File        : BaseFile
    Purpose     : Holds information on a code file
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Util.StringList.
USING OEMock.Reflection.TempTableList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.BaseFile:
    
	DEFINE PUBLIC PROPERTY FileName AS CHARACTER NO-UNDO 
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY FileType AS CHARACTER NO-UNDO 
	GET.
	SET.

    DEFINE PUBLIC PROPERTY UsingList AS OEMock.Util.StringList NO-UNDO 
    GET.
    PROTECTED SET.  

    DEFINE PUBLIC PROPERTY TempTables AS OEMock.Reflection.TempTableList NO-UNDO 
    GET.
    PROTECTED SET. 
	
	CONSTRUCTOR BaseFile(INPUT fname AS CHARACTER):
	    SUPER().
	    ASSIGN FileName  = fname.
               UsingList = NEW StringList(). 
               TempTables = NEW TempTableList().
    END CONSTRUCTOR. 
    
    DESTRUCTOR BaseFile():
        IF VALID-OBJECT(UsingList) THEN DELETE OBJECT UsingList.
        IF VALID-OBJECT(TempTables) THEN DELETE OBJECT TempTables.
    END DESTRUCTOR.
    
    METHOD PUBLIC LONGCHAR Generate():
        RETURN "".
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateUsing():
        DEFINE VARIABLE res  AS LONGCHAR  NO-UNDO.
        DEFINE VARIABLE ref  AS CHARACTER NO-UNDO.

        IF UsingList:Count > 0 THEN
        DO:
            /* Loop through Procedures */
            ref = UsingList:MoveFirst().
            DO WHILE (ref NE ? AND ref NE ""):
                ASSIGN res  = SUBSTITUTE("&1&2USING &3.",
                                         res,
                                         CHR(10) + CHR(13),
                                         IF INDEX(ref, " ") > 0 THEN '"' + ref + '"' ELSE ref).
                       ref = UsingList:MoveNext().
            END.
            
            res = TRIM(res).
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".
        
        /* Check that reference to Progress.Lang.* is present in list */
        IF  INDEX(res, "USING Progress.Lang.*.") = 0
        AND INDEX(res, "USING Progress.Lang.Object.") = 0 THEN
        DO:
            ASSIGN res = SUBSTITUTE("USING Progress.Lang.*.&1&2",
                                    CHR(10) + CHR(13),
                                    res).
        END.
        
        RETURN res.
    END METHOD.

END CLASS.