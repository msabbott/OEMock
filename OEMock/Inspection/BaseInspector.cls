/*------------------------------------------------------------------------
    File        : BaseInspector
    Purpose     : Base class for an XML-XREF inspector 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Inspection.BaseInspector:
    
    DEFINE PROTECTED VARIABLE hDocument   AS HANDLE    NO-UNDO.
    DEFINE PROTECTED VARIABLE hDocRoot    AS HANDLE    NO-UNDO.
    DEFINE PROTECTED VARIABLE hSrcElement AS HANDLE    NO-UNDO.
    DEFINE PROTECTED VARIABLE XrefFile    AS CHARACTER NO-UNDO.
    
	DEFINE PUBLIC PROPERTY FileName AS CHARACTER NO-UNDO 
	GET.
	PROTECTED SET.
	
    CONSTRUCTOR BaseInspector(INPUT fname AS CHARACTER):
        SUPER().

        FileName = fname.
        XrefFile = GUID(GENERATE-UUID) + ".xref.xml".
    END CONSTRUCTOR.

	DESTRUCTOR PUBLIC BaseInspector():

	END DESTRUCTOR.
	
	METHOD PUBLIC BaseFile Inspect():
	    
	    DEFINE VARIABLE iSrcNode AS INTEGER NO-UNDO.
	    DEFINE VARIABLE iRefNode AS INTEGER NO-UNDO.
        DEFINE VARIABLE hRefNode AS HANDLE  NO-UNDO.	    
	    
	    /* Compile the file to an XML-XREF */
	    CompileFile().
        
        /* Delete objects if exist, and create new */
        IF VALID-HANDLE(hDocument) THEN DELETE OBJECT hDocument.
        CREATE X-DOCUMENT hDocument.
        
        IF VALID-HANDLE(hDocRoot) THEN DELETE OBJECT hDocRoot.
        CREATE X-NODEREF hDocRoot.
	    
        IF VALID-HANDLE(hSrcElement) THEN DELETE OBJECT hSrcElement.
        CREATE X-NODEREF hSrcElement.
        
        CREATE X-NODEREF hRefNode.
	    /* Initialise and start parsing */
	    hDocument:SUPPRESS-NAMESPACE-PROCESSING = TRUE.
        hDocument:LOAD("FILE", XrefFile, FALSE).
        
        hDocument:GET-DOCUMENT-ELEMENT(hDocRoot).

        DO iSrcNode = 1 TO hDocRoot:NUM-CHILDREN:
            hDocRoot:GET-CHILD(hSrcElement, iSrcNode).
            IF hSrcElement:SUBTYPE = "ELEMENT" AND hSrcElement:NAME = "Source" THEN
            DO:
                DO iRefNode = 1 TO hSrcElement:NUM-CHILDREN:
                    hSrcElement:GET-CHILD(hRefNode, iRefNode).
                    IF hRefNode:SUBTYPE = "ELEMENT" AND hRefNode:NAME = "Reference" THEN
                        ProcessRefNode(INPUT hRefNode).
                END.
            END.
        END.
        
        RETURN ?.
        
        FINALLY:
            OS-DELETE VALUE(XrefFile).
            IF VALID-HANDLE(hDocument)   THEN DELETE OBJECT hDocument.
            IF VALID-HANDLE(hDocRoot)    THEN DELETE OBJECT hDocRoot.
            IF VALID-HANDLE(hSrcElement) THEN DELETE OBJECT hSrcElement.
        END FINALLY.
	    
	END METHOD.
	
	METHOD PROTECTED VOID CompileFile():
	    
	    COMPILE VALUE(FileName)
	       XREF-XML VALUE(XrefFile).
	END.
	
	METHOD PROTECTED VOID ProcessRefNode(INPUT hRefNode AS HANDLE):
	    /* Do nothing in parent class */
	END METHOD.
	
	METHOD PROTECTED BaseParameter CreateParameter (INPUT hParamNode AS HANDLE):
	    
	    DEFINE VARIABLE ParamMode AS CHARACTER NO-UNDO.
	    DEFINE VARIABLE ParamName AS CHARACTER NO-UNDO.
	    DEFINE VARIABLE ParamType AS CHARACTER NO-UNDO.
	    
	    DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
	    
	    /* Factory method. Based on the information passed through hParamNode,
	     * build the appropriate child class of BaseParameter
	     */
	     
	    /* Pull information from Node */
	    ASSIGN ParamMode = hParamNode:GET-ATTRIBUTE("Parameter-mode")
	           ParamName = hParamNode:GET-ATTRIBUTE("Parameter-name")
	           ParamType = hParamNode:GET-ATTRIBUTE("Parameter-type").
	    
	    /* Determine appropriate class */
	    IF ParamMode = "INPUT" OR ParamMode = "OUTPUT" OR ParamMode = "INPUT-OUTPUT" THEN
	    DO:
	        IF LOOKUP(ParamType, "CHARACTER,INTEGER,HANDLE,ROWID,MEMPTR,DECIMAL,DATE,DATETIME,DATETIME-TZ") > 0 THEN
	        DO:
	            parm = NEW OEMock.Reflection.PrimitiveParameter(ParamName, ParamType). 
	        END.
	    END.
	    
	    RETURN parm.
	END METHOD.
	
	METHOD PROTECTED LONGCHAR ExtractTextValue(INPUT hNodeRef AS HANDLE):
	    DEFINE VARIABLE res       AS LONGCHAR NO-UNDO.
	    DEFINE VARIABLE hTextNode AS HANDLE NO-UNDO.
	    DEFINE VARIABLE child     AS INTEGER NO-UNDO.
	    
	    CREATE X-NODEREF hTextNode.
	    
	    DO child = 1 TO hNodeRef:NUM-CHILDREN:
	        hNodeRef:GET-CHILD(hTextNode, child).
	        ASSIGN res = res + hTextNode:NODE-VALUE.
	    END.
	    
	    RETURN res.
	END METHOD.

END CLASS.