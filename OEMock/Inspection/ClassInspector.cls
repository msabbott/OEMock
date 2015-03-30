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
        DEFINE VARIABLE objId      AS CHARACTER NO-UNDO.
        DEFINE VARIABLE iNode      AS INTEGER   NO-UNDO.
        DEFINE VARIABLE iChildNode AS INTEGER   NO-UNDO.
        DEFINE VARIABLE hNode      AS HANDLE    NO-UNDO.
        DEFINE VARIABLE hChildNode AS HANDLE    NO-UNDO.
        DEFINE VARIABLE i          AS INTEGER   NO-UNDO.
        DEFINE VARIABLE list       AS CHARACTER NO-UNDO.
        
        DEFINE VARIABLE AccessMode AS CHARACTER   NO-UNDO.
        DEFINE VARIABLE Meth       AS Method      NO-UNDO.
        DEFINE VARIABLE Const      AS CONSTRUCTOR NO-UNDO.
        
        DEFINE VARIABLE DSet       AS OEMock.Reflection.DataSet NO-UNDO.
        
        CREATE X-NODEREF hNode.
        CREATE X-NODEREF hChildNode.

        /* Fetch object-identifer */
        ASSIGN objId = hRefNode:GET-ATTRIBUTE("Object-identifier").
        
        /* Process based on reference type */
        CASE hRefNode:GET-ATTRIBUTE("Reference-type"):
            
            WHEN "CLASS" THEN
            DO:
                IF VALID-OBJECT(BuiltClass) THEN
                    DELETE OBJECT BuiltClass.
                BuiltClass = NEW ClassFile(FileName, objId).

                DO iNode = 1 TO hRefNode:NUM-CHILDREN:
                    hRefNode:GET-CHILD(hNode, iNode).
                    IF hNode:SUBTYPE NE "ELEMENT" THEN NEXT.
                    CASE hNode:NAME:
                        WHEN "Class-Ref" THEN
                        DO:
                            /* Class-Ref holds useful information about the class
                             * e.g. inheritance and interface lists
                             */
                            DO iChildNode = 1 TO hNode:NUM-CHILDREN:
                                hNode:GET-CHILD(hChildNode, iChildNode).
                                IF hNode:SUBTYPE NE "ELEMENT" THEN NEXT.
                                CASE hChildNode:NAME:
                                    WHEN "Inherited-list" THEN
                                    DO:
                                        BuiltClass:InheritsFrom = TRIM(ENTRY(1,ExtractTextValue(hChildNode), " ")).
                                    END.
                                    WHEN "Implements-list" THEN
                                    DO:
                                        list = ExtractTextValue(hChildNode).
                                        DO i = 1 TO NUM-ENTRIES(list, " "):
                                            BuiltClass:Interfaces:Add(TRIM(ENTRY(i, list, " "))).
                                        END.
                                    END.
                                END CASE.
                            END.
                        END.
                    END CASE.
                END.
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
            
            WHEN "DATASET" THEN
            DO:
                /* Use parent method to interpret into a DataSet object */
                DSet = CreateDataSet(hRefNode, objId).

                /* If valid object, then add to list of DataSets */
                IF VALID-OBJECT(DSet) THEN BuiltClass:DataSets:AddDataSet(DSet).
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
                        WHEN "Is-static" THEN
                        DO:
                            hNode:NORMALIZE().
                            ASSIGN Meth:Static = (ExtractTextValue(hNode) = "true").
                        END.
                        WHEN "Is-abstract" THEN
                        DO:
                            hNode:NORMALIZE().
                            ASSIGN Meth:Abstract = (ExtractTextValue(hNode) = "true").
                        END.
                        WHEN "Object-Context" THEN
                        DO:
                            list = ExtractTextValue(hNode).
                            ASSIGN Meth:Override = (list MATCHES "*OVERRIDE*")
                                   Meth:Final    = (list MATCHES "*FINAL*").
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