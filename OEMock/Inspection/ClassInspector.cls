 /*------------------------------------------------------------------------
    File        : ClassInspector
    Purpose     : Inspector for class files
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.*.
USING OEMock.Inspection.BaseInspector.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Inspection.ClassInspector INHERITS BaseInspector:
    
    DEFINE PROTECTED VARIABLE BuiltClass AS ClassFile NO-UNDO. 
		
	CONSTRUCTOR PUBLIC ClassInspector(INPUT fname AS CHARACTER):
		SUPER(INPUT fname).
	END CONSTRUCTOR.
	
	METHOD OVERRIDE PUBLIC BaseFile Inspect():
	    SUPER:Inspect().
        RETURN BuiltClass.
	END METHOD.
    
    METHOD OVERRIDE PROTECTED VOID ProcessRefNode(INPUT hRefNode AS HANDLE):
        DEFINE VARIABLE objId AS CHARACTER NO-UNDO.
        DEFINE VARIABLE iNode AS INTEGER   NO-UNDO.
        DEFINE VARIABLE hNode AS HANDLE    NO-UNDO.
        
        DEFINE VARIABLE AccessMode AS CHARACTER   NO-UNDO.
        DEFINE VARIABLE Meth       AS Method      NO-UNDO.
        DEFINE VARIABLE Const      AS CONSTRUCTOR NO-UNDO.
        
        CREATE X-NODEREF hNode.

        /* Fetch object-identifer */
        ASSIGN objId = hRefNode:GET-ATTRIBUTE("Object-identifier").
        
        /* Process based on reference type */
        CASE hRefNode:GET-ATTRIBUTE("Reference-type"):
            
            WHEN "CLASS" THEN
            DO:
                IF VALID-OBJECT(BuiltClass) THEN
                    DELETE OBJECT BuiltClass.
                BuiltClass = NEW ClassFile(FileName, objId).
            END.
            
            WHEN "CONSTRUCTOR" THEN
            DO:
                Const = NEW Constructor(objId).
                DO iNode = 1 TO hRefNode:NUM-CHILDREN:
                    hRefNode:GET-CHILD(hNode, iNode).
                    IF hNode:SUBTYPE NE "ELEMENT" THEN NEXT.
                    CASE hNode:NAME:
                        WHEN "Parameter-ref" THEN
                        DO:
                            Const:Parameters:AddParameter(CreateParameter(hNode)).
                        END.
                    END CASE.
                END.
                
                BuiltClass:Constructors:AddMethod(Const).
            END.
            
            WHEN "METHOD" THEN
            DO:
                Meth = NEW Method(objId, "VOID").
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
                            ASSIGN Meth:ReturnType = ExtractTextValue(hNode).
                        END.
                        WHEN "Parameter-ref" THEN
                        DO:
                            Meth:Parameters:AddParameter(CreateParameter(hNode)).
                        END.
                    END CASE.
                END.

                /* Check access method is "PUBLIC" */
                IF AccessMode = "PUBLIC" THEN
                    BuiltClass:Methods:AddMethod(Meth).
                ELSE
                    DELETE OBJECT Meth NO-ERROR.
            END.
            
        END CASE.
    END METHOD.

END CLASS.