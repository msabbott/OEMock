/*------------------------------------------------------------------------
    File        : BufferParameter
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseParameter.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.BufferParameter INHERITS BaseParameter:
		
	DEFINE PUBLIC PROPERTY TableName AS CHARACTER NO-UNDO 
	GET.
	SET. 

	CONSTRUCTOR PUBLIC BufferParameter(INPUT nam AS CHARACTER, INPUT tablenam AS CHARACTER):
		SUPER(INPUT nam).
		ASSIGN TableName = tablenam.
	END CONSTRUCTOR.
		
	CONSTRUCTOR PUBLIC BufferParameter():
		THIS-OBJECT("","").
	END CONSTRUCTOR.
    
    METHOD OVERRIDE PUBLIC CHARACTER GenerateDefinition():
        DEFINE VARIABLE parm AS CHARACTER NO-UNDO.
        
        IF  TRIM(Name)      NE "" AND Name      NE ?
        AND TRIM(TableName) NE "" AND TableName NE ? THEN
        DO: 
            ASSIGN parm = "~n"
                        + "DEFINE PARAMETER BUFFER " + Name + " FOR " + TableName + ".".
        END.
        RETURN parm.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC CHARACTER Generate():
        DEFINE VARIABLE parm AS CHARACTER NO-UNDO.
        
        IF  TRIM(Name)      NE "" AND Name      NE ?
        AND TRIM(TableName) NE "" AND TableName NE ? THEN
        DO:
            ASSIGN parm = "~n"
                        + "BUFFER " + Name + " FOR " + TableName + ",".
        END.
        RETURN parm.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC CHARACTER Normalise():
        DEFINE VARIABLE parm AS CHARACTER NO-UNDO.
        
        IF TRIM(TableName) NE "" AND TableName NE ? THEN
        DO: 
            ASSIGN parm = SUBSTITUTE("BUFFER &1",
                                     TableName).
        END.
        
        RETURN parm.
    END METHOD.

END CLASS.