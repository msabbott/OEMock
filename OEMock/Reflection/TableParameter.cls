/*------------------------------------------------------------------------
    File        : TableParameter
    Purpose     : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseParameter.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.TableParameter INHERITS BaseParameter:

    DEFINE PUBLIC PROPERTY ParameterType AS CHARACTER INITIAL "INPUT" NO-UNDO 
    GET.
    SET.

	CONSTRUCTOR PUBLIC TableParameter(INPUT nam AS CHARACTER):
		SUPER(INPUT nam).
		ASSIGN ParameterType = "INPUT".
	END CONSTRUCTOR.
		
	CONSTRUCTOR PUBLIC TableParameter():
		THIS-OBJECT("").
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC TableParameter( ):

	END DESTRUCTOR.
    
    METHOD OVERRIDE PUBLIC CHARACTER GenerateDefinition():
        DEFINE VARIABLE parm AS CHARACTER NO-UNDO.
        
        IF  TRIM(Name)          NE "" AND Name          NE ?
        AND TRIM(ParameterType) NE "" AND ParameterType NE ? THEN
        DO:
            ASSIGN parm = "~n" + "DEFINE " + ParameterType + " PARAMETER TABLE FOR " + Name + ".".
        END.
        RETURN parm.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC CHARACTER Generate():
        DEFINE VARIABLE parm AS CHARACTER NO-UNDO.
        
        IF  TRIM(Name)          NE "" AND Name          NE ?
        AND TRIM(ParameterType) NE "" AND ParameterType NE ? THEN
        DO:
            ASSIGN parm = "~n" + ParameterType + " TABLE FOR " + Name + ",".
        END.
        RETURN parm.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC CHARACTER Normalise():
        DEFINE VARIABLE parm AS CHARACTER NO-UNDO.
        
        IF  TRIM(Name)          NE "" AND Name          NE ?
        AND TRIM(ParameterType) NE "" AND ParameterType NE ? THEN
        DO: 
            ASSIGN parm = SUBSTITUTE("&1 TABLE &2",
                                     ParameterType,
                                     Name).
        END.
        
        RETURN parm.
    END METHOD.

END CLASS.