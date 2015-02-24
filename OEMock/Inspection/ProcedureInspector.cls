 /*------------------------------------------------------------------------
    File        : ProcedureInspector
    Purpose     : Inspector for class files
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.*.
USING OEMock.Inspection.BaseInspector.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Inspection.ProcedureInspector INHERITS BaseInspector:
    
    DEFINE PROTECTED VARIABLE BuiltProc AS ProcedureFile NO-UNDO. 
		
	CONSTRUCTOR PUBLIC ProcedureInspector(INPUT fname AS CHARACTER):
		SUPER(INPUT fname).
	END CONSTRUCTOR.
	
	METHOD OVERRIDE PUBLIC BaseFile Inspect():
	    SUPER:Inspect().
        RETURN BuiltProc.
	END METHOD.
    
    METHOD OVERRIDE PROTECTED VOID ProcessRefNode(INPUT hRefNode AS HANDLE):
        DEFINE VARIABLE objId AS CHARACTER NO-UNDO.
        DEFINE VARIABLE iNode AS INTEGER   NO-UNDO.
        DEFINE VARIABLE hNode AS HANDLE    NO-UNDO.
        
        DEFINE VARIABLE AccessMode AS CHARACTER NO-UNDO.
        DEFINE VARIABLE Proc       AS Procedure NO-UNDO.
        DEFINE VARIABLE Func       AS Function  NO-UNDO.

        CREATE X-NODEREF hNode.
        
        /* Check that procedure file object exists */
        IF NOT VALID-OBJECT(BuiltProc) THEN
            BuiltProc = NEW ProcedureFile(FileName).

        /* Fetch object-identifer */
        ASSIGN objId = hRefNode:GET-ATTRIBUTE("Object-identifier").
        
        /* Process based on reference type */
        CASE hRefNode:GET-ATTRIBUTE("Reference-type"):
            
            WHEN "PROCEDURE" THEN
            DO:
                Proc = NEW Procedure(objId).
                DO iNode = 1 TO hRefNode:NUM-CHILDREN:
                    hRefNode:GET-CHILD(hNode, iNode).
                    IF hNode:SUBTYPE NE "ELEMENT" THEN NEXT.
                    CASE hNode:NAME:
                        WHEN "Access-mode" THEN
                        DO:
                            
                            hNode:NORMALIZE().
                            ASSIGN AccessMode = ExtractTextValue(hNode).
                            
                        END.
                        WHEN "Parameter-ref" THEN
                        DO:
                            Proc:Parameters:AddParameter(CreateParameter(hNode)).
                        END.
                    END CASE.
                END.

                /* Check access method is not "PRIVATE" */
                IF AccessMode NE "PRIVATE" THEN
                    BuiltProc:Procedures:AddMethod(Proc).
                ELSE
                    DELETE OBJECT Proc NO-ERROR.
            END.

            WHEN "FUNCTION" THEN
            DO:
                Func = NEW Function(objId, "VOID").
                DO iNode = 1 TO hRefNode:NUM-CHILDREN:
                    hRefNode:GET-CHILD(hNode, iNode).
                    IF hNode:SUBTYPE NE "ELEMENT" THEN NEXT.
                    CASE hNode:NAME:
                        WHEN "Access-mode" THEN
                        DO:
                            hNode:NORMALIZE().
                            ASSIGN AccessMode = ExtractTextValue(hNode).
                        END.
                        WHEN "Detail" THEN
                        DO:
                            hNode:NORMALIZE().
                            ASSIGN Func:ReturnType = ExtractTextValue(hNode).
                        END.
                        WHEN "Parameter-ref" THEN
                        DO:
                            Func:Parameters:AddParameter(CreateParameter(hNode)).
                        END.
                    END CASE.
                END.

                /* Check access method is not "PRIVATE" */
                IF AccessMode NE "PRIVATE" THEN
                    BuiltProc:Functions:AddMethod(Func).
                ELSE
                    DELETE OBJECT Func NO-ERROR.
            END.
        END CASE.
        
    END METHOD.

END CLASS.