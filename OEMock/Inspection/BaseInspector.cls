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
            IF VALID-HANDLE(hDocument) THEN DELETE OBJECT hDocument.
            IF VALID-HANDLE(hDocRoot)  THEN DELETE OBJECT hDocRoot.
        END FINALLY.
	    
	END METHOD.
	
	METHOD PROTECTED VOID CompileFile():
	    
	    COMPILE VALUE(FileName)
	       XREF-XML VALUE(XrefFile).
	       
	    FINALLY:
	        OS-DELETE VALUE(XrefFile).
	    END FINALLY.
	END.
	
	METHOD PROTECTED VOID ProcessRefNode(INPUT hRefNode AS HANDLE):
	    /* Do nothing in parent class */
	END METHOD.

END CLASS.