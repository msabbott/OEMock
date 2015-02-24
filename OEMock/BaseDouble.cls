 /*------------------------------------------------------------------------
    File        : BaseDouble
    Purpose     : Holds common properties for all types of test doubles
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseFile.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.BaseDouble:
    
    DEFINE PUBLIC PROPERTY DeleteOnDestruct AS LOGICAL NO-UNDO INITIAL TRUE
    GET.
    SET.
    
	DEFINE PUBLIC PROPERTY File AS BaseFile NO-UNDO
	GET.
	SET.
	
	DEFINE PROTECTED PROPERTY BaseDirectory AS CHARACTER NO-UNDO
	GET.
	PROTECTED SET.
	
	DEFINE PROTECTED PROPERTY OutputFile AS CHARACTER NO-UNDO
	GET.
	PROTECTED SET.
	
	CONSTRUCTOR BaseDouble(INPUT fil AS BaseFile, INPUT basedir AS CHARACTER):
	    SUPER().
	    
	    /* Assign values */
	    ASSIGN File             = fil
	           BaseDirectory    = basedir.
	           DeleteOnDestruct = TRUE.
	END CONSTRUCTOR.
	
	DESTRUCTOR BaseDouble():
	    IF DeleteOnDestruct THEN
	    DO:
    	    FILE-INFO:FILE-NAME = OutputFile.
    	    IF FILE-INFO:FILE-TYPE MATCHES "F*W*" THEN
    	    DO:
    	        OS-DELETE VALUE(OutputFile).
    	    END.
	    END.
	END DESTRUCTOR.
	
	METHOD PUBLIC VOID Generate():
	    CreateDirectory().
	    
	    /* Store output file name */
	    OutputFile = BaseDirectory + THIS-OBJECT:File:FileName.
	    
	    /* Save to file */
	    COPY-LOB OBJECT File:Generate() TO FILE OutputFile.
	END METHOD.
	
	METHOD PROTECTED VOID CreateDirectory():
	    
	    DEFINE VARIABLE tmpDir  AS CHARACTER NO-UNDO.
	    DEFINE VARIABLE tmpPath AS CHARACTER NO-UNDO.
	    DEFINE VARIABLE loop    AS INTEGER NO-UNDO.
	    
	    /* Ensure that the BaseDirectory is set */
	    IF BaseDirectory = "" OR BaseDirectory = ? THEN
	       BaseDirectory = "./".

	    IF File:GetClass():IsA("OEMock.Reflection.ClassFile") THEN
        DO:
            tmpDir = BaseDirectory
                   + REPLACE(CAST(File, "OEMock.Reflection.ClassFile"):Package,".", "/")
                   + "/".
        END.
        ELSE IF File:GetClass():IsA("OEMock.Reflection.ProcedureFile") THEN
        DO:
            IF OPSYS = "Win32" THEN
                tmpDir = REPLACE(THIS-OBJECT:File:FileName, "~\", "/").
            ELSE
                tmpDir = THIS-OBJECT:File:FileName.
    
            tmpDir = BaseDirectory
                   + SUBSTRING(tmpDir, 1, R-INDEX(tmpDir, "/")).
        END.
        
        IF tmpDir NE ? AND tmpDir NE "" THEN
        DO:
            DO loop = 1 TO NUM-ENTRIES(tmpDir, "/"):
                tmpPath = tmpPath
                        + ENTRY(loop, tmpDir, "/")
                        + "/".
                OS-CREATE-DIR VALUE(tmpPath).
            END.
        END.
	END METHOD.

END CLASS.