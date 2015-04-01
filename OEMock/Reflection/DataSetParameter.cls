/*------------------------------------------------------------------------
    File        : DataSetParameter
    Purpose     : Represents a DataSet parameter
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseParameter.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.DataSetParameter INHERITS BaseParameter:

    DEFINE PUBLIC PROPERTY ParameterType AS CHARACTER INITIAL "INPUT" NO-UNDO 
    GET.
    SET.

    CONSTRUCTOR PUBLIC DataSetParameter(INPUT nam AS CHARACTER):
        SUPER(INPUT nam).
        ASSIGN ParameterType = "INPUT".
    END CONSTRUCTOR.
        
    CONSTRUCTOR PUBLIC DataSetParameter():
        THIS-OBJECT("").
    END CONSTRUCTOR.
    
    METHOD OVERRIDE PUBLIC CHARACTER GenerateDefinition():
        DEFINE VARIABLE parm AS CHARACTER NO-UNDO.
        
        IF  TRIM(Name)          NE "" AND Name          NE ?
        AND TRIM(ParameterType) NE "" AND ParameterType NE ? THEN
        DO: 
            ASSIGN parm = SUBSTITUTE("&1&2DEFINE &3 PARAMETER DATASET FOR &4.",
                                     CHR(10),
                                     CHR(13),
                                     ParameterType,
                                     Name).
        END.
        RETURN parm.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC CHARACTER Generate():
        DEFINE VARIABLE parm AS CHARACTER NO-UNDO.
        
        IF  TRIM(Name)          NE "" AND Name          NE ?
        AND TRIM(ParameterType) NE "" AND ParameterType NE ? THEN
        DO: 
            ASSIGN parm = SUBSTITUTE("&1&2&3 DATASET FOR &4,",
                                     CHR(10),
                                     CHR(13),
                                     ParameterType,
                                     Name).
        END.
        RETURN parm.
    END METHOD.

END CLASS.