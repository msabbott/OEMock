/*------------------------------------------------------------------------
    File        : BaseInspector
    Purpose     : Base class for an XML-XREF inspector 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.*.
USING OEMock.Util.Warnings.

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
	    
	    Warnings:Suppress().
	    
	    COMPILE VALUE(FileName)
	       XREF-XML VALUE(XrefFile).
	       
	    Warnings:Restore().
	END.
	
	METHOD PROTECTED VOID ProcessRefNode(INPUT hRefNode AS HANDLE):
	    /* Do nothing in parent class */
	END METHOD.
	
	METHOD PROTECTED BaseParameter CreateParameter (INPUT hParamNode AS HANDLE):
	    
	    DEFINE VARIABLE ParamMode AS CHARACTER NO-UNDO.
	    DEFINE VARIABLE ParamName AS CHARACTER NO-UNDO.
	    DEFINE VARIABLE ParamType AS CHARACTER NO-UNDO.
	    
	    DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
	    DEFINE VARIABLE primparm AS PrimitiveParameter NO-UNDO.
	    DEFINE VARIABLE dsetparm AS DataSetParameter   NO-UNDO.
	    DEFINE VARIABLE tableparm AS TableParameter NO-UNDO.
	    
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
	        IF ParamType = "TABLE" THEN
            DO:
                tableparm = NEW OEMock.Reflection.TableParameter(ParamType).
                tableparm:ParameterType = ParamMode.
                parm = tableparm.
            END.
            ELSE IF ParamMode = "DATASET" THEN
            DO:
                dsetparm = NEW OEMock.Reflection.DataSetParameter(ParamName).
                dsetparm:ParameterType = ParamMode.
                parm = dsetparm.
            END.
            ELSE
	        DO:
	            primparm = NEW OEMock.Reflection.PrimitiveParameter(ParamName, ParamType).
	            primparm:ParameterType = ParamMode.
	            parm = primparm.
	        END.
	    END.
	    ELSE IF ParamMode = "BUFFER" THEN
	    DO:
	        parm = NEW OEMock.Reflection.BufferParameter(ParamName, ParamType).
	    END.
	    
	    RETURN parm.
	END METHOD.
	
	METHOD PROTECTED OEMock.Reflection.DataSet CreateDataSet(INPUT hNodeRef AS HANDLE, INPUT objId AS CHARACTER):
	    
	    DEFINE VARIABLE DSet       AS OEMock.Reflection.DataSet NO-UNDO.
	    DEFINE VARIABLE DRel       AS OEMock.Reflection.DataSetRelation NO-UNDO.
	    DEFINE VARIABLE AccessMode AS CHARACTER NO-UNDO. 
	    DEFINE VARIABLE hNode      AS HANDLE    NO-UNDO.
	    DEFINE VARIABLE hChildNode AS HANDLE    NO-UNDO.
	    DEFINE VARIABLE iNode      AS INTEGER   NO-UNDO.
	    DEFINE VARIABLE iChildNode AS INTEGER   NO-UNDO.
	    
	    CREATE X-NODEREF hNode.
	    CREATE X-NODEREF hChildNode.
	    
	    DSet = NEW OEMock.Reflection.DataSet(objId).
	    
        DO iNode = 1 TO hNodeRef:NUM-CHILDREN:
            hNodeRef:GET-CHILD(hNode, iNode).
            IF hNode:SUBTYPE NE "ELEMENT" THEN NEXT.
            CASE hNode:NAME:
                WHEN "Access-mode" THEN
                DO:
                    hNode:NORMALIZE().
                    ASSIGN AccessMode = ExtractTextValue(hNode).
                END.
                WHEN "Is-static" THEN
                DO:
                    hNode:NORMALIZE().
                    ASSIGN DSet:Static = (ExtractTextValue(hNode) = "true").
                END.
                WHEN "Dataset-Ref" THEN
                DO:
                    /* Dataset-Ref holds useful information about the Dataset
                     * e.g. buffer lists, relations, etc.
                     */
                    DO iChildNode = 1 TO hNode:NUM-CHILDREN:
                        hNode:GET-CHILD(hChildNode, iChildNode).
                        IF hNode:SUBTYPE NE "ELEMENT" THEN NEXT.
                        CASE hChildNode:NAME:
                            WHEN "Buffer-list" THEN
                            DO:
                                DSet:Buffers = ExtractTextValue(hChildNode).
                            END.
                            WHEN "N-prefix" THEN
                            DO:
                                DSet:NamespacePrefix = ExtractTextValue(hChildNode).
                            END.
                            WHEN "N-uri" THEN
                            DO:
                                DSet:NamespaceURI = ExtractTextValue(hChildNode).
                            END.
                            WHEN "Relation" THEN
                            DO:
                                DRel = CreateDataSetRelation(hChildNode).
                                IF VALID-OBJECT(DRel) THEN 
                                    DSet:DataSetRelations:AddDataSetRelation(DRel).
                            END.
                        END CASE.
                    END.
                END.
            END CASE.
        END.

        /* If this is a private object, then return an invalid object */
        IF AccessMode EQ "PRIVATE" THEN DELETE OBJECT DSet NO-ERROR.
	    
	    RETURN DSet.
	    
	END METHOD.
	
	METHOD PRIVATE OEMock.Reflection.DataSetRelation CreateDataSetRelation(INPUT hNodeRef AS HANDLE):
	    
	    DEFINE VARIABLE DRel AS OEMock.Reflection.DataSetRelation NO-UNDO.
        DEFINE VARIABLE hNode      AS HANDLE    NO-UNDO.
        DEFINE VARIABLE iNode      AS INTEGER   NO-UNDO.
        
        CREATE X-NODEREF hNode.
	    
	    DRel = NEW OEMock.Reflection.DataSetRelation(hNodeRef:GET-ATTRIBUTE("Relation-name")).
	    
	    DO iNode = 1 TO hNodeRef:NUM-CHILDREN:
            hNodeRef:GET-CHILD(hNode, iNode).
            IF hNode:SUBTYPE NE "ELEMENT" THEN NEXT.
            CASE hNode:NAME:
                WHEN "Parent-buffer-name" THEN
                DO:
                    hNode:NORMALIZE().
                    ASSIGN DRel:ParentBufferName = ExtractTextValue(hNode).
                END.
                WHEN "Child-buffer-name" THEN
                DO:
                    hNode:NORMALIZE().
                    ASSIGN DRel:ChildBufferName = ExtractTextValue(hNode).
                END.
                WHEN "Relation-list" THEN
                DO:
                    hNode:NORMALIZE().
                    ASSIGN DRel:RelationList = ExtractTextValue(hNode).
                END.
            END CASE.
        END.
	    
	    RETURN DRel.
	    
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