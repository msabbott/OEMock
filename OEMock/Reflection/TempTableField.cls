 /*------------------------------------------------------------------------
    File        : TempTableField
    Purpose     : Represents a field on a temp-table
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.TempTableField:
    
	DEFINE PUBLIC PROPERTY DataType AS CHARACTER NO-UNDO 
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY Extent AS INTEGER INITIAL 0 NO-UNDO 
	GET.
	SET(INPUT arg AS INTEGER):
       IF arg < 0 OR arg = ? THEN
            ASSIGN arg = 0.

       THIS-OBJECT:Extent = arg.
	END SET.
	 

	DEFINE PUBLIC PROPERTY Initial AS CHARACTER INITIAL "" NO-UNDO 
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY Name AS CHARACTER NO-UNDO 
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY SerializeHidden AS LOGICAL INITIAL FALSE NO-UNDO 
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY SerializeName AS CHARACTER NO-UNDO 
	GET.
	SET. 
	
    DEFINE PUBLIC PROPERTY XMLDataType AS CHARACTER NO-UNDO 
    GET.
    SET. 
    
    DEFINE PUBLIC PROPERTY XMLNodeType AS CHARACTER NO-UNDO 
    GET.
    SET. 
    
    DEFINE PUBLIC PROPERTY XMLNodeName AS CHARACTER NO-UNDO 
    GET.
    SET. 

	CONSTRUCTOR PUBLIC TempTableField(INPUT nam AS CHARACTER, INPUT dType AS CHARACTER):
		SUPER ().
		
		ASSIGN DataType        = dType
		       Name            = nam
		       Extent          = 0
		       Initial         = ""
		       SerializeHidden = FALSE
		       SerializeName   = ""
		       XMLDataType     = "" 
               XMLNodeType     = ""
               XMLNodeName     = "".
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC TempTableField():

	END DESTRUCTOR.
	
	METHOD PUBLIC LONGCHAR Generate():
	    DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
	    DEFINE VARIABLE init AS CHARACTER NO-UNDO.
	    
	    ASSIGN res = SUBSTITUTE("FIELD &1 AS &2",
	                            Name,
	                            DataType).
	    
	    IF Initial NE "" THEN
	    DO:
	        ASSIGN Init = Initial.
	        
	        /* Check for values that need to be formatted */
	        IF (DataType = "CHARACTER" OR DataType = "LONGCHAR") AND Init NE ? THEN
	        DO:
	            ASSIGN Init = SUBSTITUTE('"&1"', Init).
	        END.
	        
	        ASSIGN res = SUBSTITUTE("&1 INITIAL &2",
	                                res,
	                                Init).
	    END.
	    
	    IF Extent GT 0 AND Extent NE ? THEN
	    DO:
	        ASSIGN res = SUBSTITUTE("&1 EXTENT &2",
                                    res,
                                    TRIM(STRING(THIS-OBJECT:Extent, ">>>>>>>>>>>>>>>>>>>9"))).
	    END.
	    
	    IF SerializeHidden EQ TRUE THEN
	    DO:
	        ASSIGN res = SUBSTITUTE("&1 SERIALIZE-HIDDEN",
                                    res).
	    END.
        
        IF TRIM(SerializeName) NE "" AND SerializeName NE ? AND SerializeName NE Name THEN /* Same as 'Name' by default */
        DO:
            ASSIGN res = SUBSTITUTE("&1 SERIALIZE-NAME ~"&2~"",
                                    res,
                                    SerializeName).
        END.
        
        IF TRIM(XMLDataType) NE "" AND XMLDataType NE ? THEN
        DO:
            ASSIGN res = SUBSTITUTE("&1 XML-DATA-TYPE ~"&2~"",
                                    res,
                                    XMLDataType).
        END.
        

        IF TRIM(XMLNodeType) NE "" AND XMLNodeType NE ? AND TRIM(XMLNodeType) NE "ELEMENT" THEN /* "ELEMENT" is default */
        DO:
            ASSIGN res = SUBSTITUTE("&1 XML-NODE-TYPE ~"&2~"",
                                    res,
                                    XMLNodeType).
        END.
        
        
        IF TRIM(XMLNodeName) NE "" AND XMLNodeName NE ? AND XMLNodeName NE SerializeName THEN /* Same as 'SerializeName' by default */
        DO:
            ASSIGN res = SUBSTITUTE("&1 XML-NODE-NAME ~"&2~"",
                                    res,
                                    XMLNodeName).
        END.
	    
	    /* Ensure appropriate spacing between this statement and the next */
	    ASSIGN res = res + CHR(13).
	    
	    RETURN res.
	END METHOD.

END CLASS.