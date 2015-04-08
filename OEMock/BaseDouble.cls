 /*------------------------------------------------------------------------
    File        : BaseDouble
    Purpose     : Holds common properties for all types of test doubles
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.*.
USING OEMock.Generation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.BaseDouble:
    
    DEFINE PROTECTED PROPERTY ProcedureGenerators AS OEMock.Generation.NamedGeneratorList NO-UNDO
    GET.
    SET.
        
    DEFINE PROTECTED PROPERTY FunctionGenerators AS OEMock.Generation.NamedGeneratorList NO-UNDO
    GET.
    SET.
        
    DEFINE PROTECTED PROPERTY MethodGenerators AS OEMock.Generation.NamedGeneratorList NO-UNDO
    GET.
    SET.
    
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
	           BaseDirectory    = basedir
	           DeleteOnDestruct = TRUE.
        
        /* Construct objects */
        ASSIGN ProcedureGenerators = NEW NamedGeneratorList()
               FunctionGenerators  = NEW NamedGeneratorList()
               MethodGenerators    = NEW NamedGeneratorList().
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
	    
        IF VALID-OBJECT(ProcedureGenerators) THEN DELETE OBJECT ProcedureGenerators.
        IF VALID-OBJECT(FunctionGenerators)  THEN DELETE OBJECT FunctionGenerators.
        IF VALID-OBJECT(MethodGenerators)    THEN DELETE OBJECT MethodGenerators.
	END DESTRUCTOR.
    
    METHOD PROTECTED VOID Initialise():
        
        IF File:GetClass():IsA("OEMock.Reflection.ClassFile") THEN
        DO:
            InitialiseClass(DYNAMIC-CAST(File, File:GetClass():TypeName)).
        END.
        ELSE IF File:GetClass():IsA("OEMock.Reflection.ProcedureFile") THEN
        DO:
            InitialiseProcedure(DYNAMIC-CAST(File, File:GetClass():TypeName)).
        END.

    END METHOD.
    
    METHOD PROTECTED VOID InitialiseClass(INPUT clsfile AS ClassFile):
    END METHOD.
    
    METHOD PROTECTED VOID InitialiseProcedure(INPUT procfile AS ProcedureFile):
    END METHOD.
	
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
	
	METHOD PROTECTED VOID AddProcedureParameter(INPUT parm AS OEMock.Reflection.BaseParameter):
	    
	    DEFINE VARIABLE procFile AS ProcedureFile NO-UNDO.
	    
	    IF THIS-OBJECT:File:GetClass():IsA("OEMock.Reflection.ProcedureFile") THEN
	    DO:
	        procFile = DYNAMIC-CAST(THIS-OBJECT:File, THIS-OBJECT:File:GetClass():TypeName).
	        procFile:Parameters:AddParameter(parm).
	    END.
	    
	END METHOD.
	
	METHOD PUBLIC VOID AddProcedureParameter(INPUT paramType AS CHARACTER, INPUT nam AS CHARACTER, INPUT dType AS CHARACTER):
	    DEFINE VARIABLE parm AS PrimitiveParameter NO-UNDO.
	    
	    ASSIGN paramType = TRIM(paramType).
	    
	    IF paramType NE "INPUT" AND paramType NE "INPUT-OUTPUT" AND paramType NE "OUTPUT" THEN
	       RETURN.

	    parm = NEW PrimitiveParameter(INPUT nam, INPUT dType).
	    parm:ParameterType = paramType.
	    
	    AddProcedureParameter(parm).
	END METHOD.
	
	METHOD PUBLIC VOID AddProcedureBufferParameter(INPUT nam AS CHARACTER, INPUT tabl AS CHARACTER):
        DEFINE VARIABLE parm AS BufferParameter NO-UNDO.
        
        parm = NEW BufferParameter(INPUT nam, INPUT tabl).
        
        AddProcedureParameter(parm).
	END METHOD.
    
    METHOD PUBLIC VOID AddProcedureDataSetParameter(INPUT nam AS CHARACTER):
        DEFINE VARIABLE parm AS DataSetParameter NO-UNDO.
        
        parm = NEW DataSetParameter(INPUT nam).
        
        AddProcedureParameter(parm).
    END METHOD.

END CLASS.