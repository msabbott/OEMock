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
    
    DEFINE PUBLIC PROPERTY CompileOnGenerate AS LOGICAL NO-UNDO INITIAL FALSE
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
    
    DEFINE PROTECTED PROPERTY OutputDirectory AS CHARACTER NO-UNDO
    GET.
    PROTECTED SET.
	
	DEFINE PROTECTED PROPERTY OutputFile AS CHARACTER NO-UNDO
	GET.
	PROTECTED SET.
	
	CONSTRUCTOR BaseDouble(INPUT fil AS BaseFile, INPUT basedir AS CHARACTER):
	    SUPER().
	    
	    /* Assign values */
	    ASSIGN File              = fil
	           BaseDirectory     = basedir
	           DeleteOnDestruct  = TRUE
	           CompileOnGenerate = FALSE.
        
        /* Construct objects */
        ASSIGN ProcedureGenerators = NEW NamedGeneratorList()
               FunctionGenerators  = NEW NamedGeneratorList()
               MethodGenerators    = NEW NamedGeneratorList().
	END CONSTRUCTOR.
	
	DESTRUCTOR BaseDouble():
	    DEFINE VARIABLE compFile AS CHARACTER NO-UNDO.
	    
	    IF DeleteOnDestruct AND OutputFile NE ? AND OutputFile NE "" THEN
	    DO:
    	    FILE-INFO:FILE-NAME = OutputFile.
    	    IF FILE-INFO:FILE-TYPE MATCHES "F*W*" THEN
    	    DO:
    	        OS-DELETE VALUE(OutputFile).
    	    END.
    	    
    	    /* Attempt to delete a matching .r file */
    	    ASSIGN compFile = OutputFile 
    	           ENTRY(NUM-ENTRIES(compFile,"."), compFile, ".") = "r". /* Replace last .* with .r */
    	    
            FILE-INFO:FILE-NAME = compFile.
            IF FILE-INFO:FILE-TYPE MATCHES "F*W*" THEN
            DO:
                OS-DELETE VALUE(compFile).
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
	    
	    /* Compile if required */
	    IF CompileOnGenerate = TRUE THEN
	       THIS-OBJECT:Compile().
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
            ASSIGN OutputDirectory = tmpDir.
            
            DO loop = 1 TO NUM-ENTRIES(tmpDir, "/"):
                tmpPath = tmpPath
                        + ENTRY(loop, tmpDir, "/")
                        + "/".
                OS-CREATE-DIR VALUE(tmpPath).
            END.
        END.
	END METHOD.
	
	METHOD PROTECTED VOID Compile():
	    IF  TRIM(OutputFile)      NE "" AND OutputFile      NE ?
	    AND TRIM(OutputDirectory) NE "" AND OutputDirectory NE ? THEN
	    DO:
	       COMPILE VALUE(SEARCH(OutputFile)) SAVE INTO VALUE(OutputDirectory).
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
    
    METHOD PUBLIC VOID AddTempTable(INPUT ttHandle AS HANDLE):
        
        DEFINE VARIABLE ttObject   AS OEMock.Reflection.TempTable NO-UNDO.
        DEFINE VARIABLE ttField    AS OEMock.Reflection.TempTableField NO-UNDO.
        DEFINE VARIABLE ttIndex    AS OEMock.Reflection.TempTableIndex NO-UNDO.
        DEFINE VARIABLE ttIdxField AS OEMock.Reflection.TempTableIndexField NO-UNDO.
        DEFINE VARIABLE ttBuffer   AS HANDLE    NO-UNDO.
        DEFINE VARIABLE fieldLoop  AS INTEGER   NO-UNDO.
        DEFINE VARIABLE bufField   AS HANDLE    NO-UNDO.
        DEFINE VARIABLE indexLoop  AS INTEGER   NO-UNDO.
        DEFINE VARIABLE indexData  AS CHARACTER NO-UNDO.
        DEFINE VARIABLE idxField   AS INTEGER   NO-UNDO.
        
        IF NOT VALID-HANDLE(ttHandle) THEN RETURN.
        
        /* Set properties on object, and fetch buffer handle */
        ASSIGN ttObject                 = NEW OEMock.Reflection.TempTable(INPUT ttHandle:NAME)
               ttObject:NamespacePrefix = ttHandle:NAMESPACE-PREFIX
               ttObject:NamespaceURI    = ttHandle:NAMESPACE-URI
               ttObject:NoUndo          = NOT(ttHandle:UNDO)
               ttBuffer                 = ttHandle:DEFAULT-BUFFER-HANDLE.
               
        /* Loop through buffer information to create field list */
        DO fieldLoop = 1 TO ttBuffer:NUM-FIELDS:
            
            ASSIGN bufField = ttBuffer:BUFFER-FIELD(fieldLoop)
                   ttField  = NEW OEMock.Reflection.TempTableField(INPUT bufField:NAME, INPUT bufField:DATA-TYPE).
                   
            /* Set temp-table field properties */
            ASSIGN ttField:Extent          = bufField:EXTENT
                   ttField:Initial         = bufField:INITIAL
                   ttField:SerializeHidden = bufField:SERIALIZE-HIDDEN
                   ttField:SerializeName   = bufField:SERIALIZE-NAME
                   ttField:XMLDataType     = bufField:XML-DATA-TYPE
                   ttField:XMLNodeType     = bufField:XML-NODE-TYPE
                   ttField:XMLNodeName     = bufField:XML-NODE-NAME.

            ttObject:Fields:AddTempTableField(ttField).
        END.
        
        /* Loop through index information */
        ASSIGN indexLoop = 1
               indexData = ttBuffer:INDEX-INFORMATION(indexLoop).
        
        indexLoop:
        DO WHILE(indexData NE ?):
            
            /* If the name of the index is 'default' and there are only 5 entries in the list, then
             * this is the default index, and there were no explicit indexes added to the temp-table
             */
            IF ENTRY(1, indexData) = "default" AND NUM-ENTRIES(indexData) = 5 THEN LEAVE indexLoop.

            ASSIGN ttIndex           = NEW OEMock.Reflection.TempTableIndex(ENTRY(1, indexData))
                   ttIndex:Unique    = (ENTRY(2,indexData) = "1")
                   ttIndex:Primary   = (ENTRY(3,indexData) = "1")
                   ttIndex:WordIndex = (ENTRY(4,indexData) = "1").
            
            /* Remaining data is field list, following by 0 for ascending, 1 for descending */
            ASSIGN idxField = 5.
            indexFieldLoop:
            DO WHILE(idxField <= NUM-ENTRIES(indexData)):
                
                ASSIGN ttIdxField = NEW OEMock.Reflection.TempTableIndexField(ENTRY(idxField, indexData))
                       ttIdxField:Descending = (ENTRY(idxField + 1, indexData) = "1")
                       idxField = idxField + 2.
                       
                ttIndex:Fields:AddTempTableIndexField(ttIdxField).
            END.
            
            ttObject:Indexes:AddTempTableIndex(ttIndex).
        
            ASSIGN indexLoop = indexLoop + 1
                   indexData = ttBuffer:INDEX-INFORMATION(indexLoop).
        END.
        
        THIS-OBJECT:File:TempTables:AddTempTable(INPUT ttObject).
               
    END METHOD.

END CLASS.