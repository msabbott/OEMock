/*------------------------------------------------------------------------
    File        : PrimitiveParameter
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseParameter.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.PrimitiveParameter INHERITS BaseParameter:
		
	DEFINE PUBLIC PROPERTY AddNoUndo AS LOGICAL NO-UNDO INITIAL TRUE
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY DataType AS CHARACTER NO-UNDO 
	GET.
	SET. 

	DEFINE PUBLIC PROPERTY ParameterType AS CHARACTER INITIAL "INPUT" NO-UNDO 
	GET.
	SET. 

	CONSTRUCTOR PUBLIC PrimitiveParameter(INPUT nam AS CHARACTER, INPUT dType AS CHARACTER):
		SUPER(INPUT nam).
		ASSIGN AddNoUndo     = TRUE
		       DataType      = dType
		       ParameterType = "INPUT".
	END CONSTRUCTOR.
		
	CONSTRUCTOR PUBLIC PrimitiveParameter():
		THIS-OBJECT("","").
	END CONSTRUCTOR.
    
    METHOD OVERRIDE PUBLIC CHARACTER GenerateDefinition():
        DEFINE VARIABLE parm AS CHARACTER NO-UNDO.
        
        IF  TRIM(Name)          NE "" AND Name          NE ?
        AND TRIM(ParameterType) NE "" AND ParameterType NE ?
        AND TRIM(DataType)      NE "" AND DataType      NE ? THEN
        DO: 
            ASSIGN parm = SUBSTITUTE("&1&2DEFINE &3 PARAMETER &4 AS &5 &6.",
                                     CHR(10),
                                     CHR(13),
                                     ParameterType,
                                     Name,
                                     DataType,
                                     (IF AddNoUndo THEN "NO-UNDO" ELSE "")).
        END.
        RETURN parm.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC CHARACTER Generate():
        DEFINE VARIABLE parm AS CHARACTER NO-UNDO.
        
        IF  TRIM(Name)          NE "" AND Name          NE ?
        AND TRIM(ParameterType) NE "" AND ParameterType NE ?
        AND TRIM(DataType)      NE "" AND DataType      NE ? THEN
        DO: 
            ASSIGN parm = SUBSTITUTE("&1&2&3 &4 AS &5,",
                                     CHR(10),
                                     CHR(13),
                                     ParameterType,
                                     Name,
                                     DataType).
        END.
        RETURN parm.
    END METHOD.

END CLASS.