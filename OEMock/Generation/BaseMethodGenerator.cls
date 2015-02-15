/*------------------------------------------------------------------------
    File        : BaseMethodGenerator
    Purpose     : Base class for generators for any class or procedure file
                  methods (equiv to OEMock.Reflection.BaseMethod) 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.BaseGenerator.
USING OEMock.Util.NamedStringList.
USING OEMock.Reflection.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.BaseMethodGenerator INHERITS BaseGenerator: 
    
    DEFINE PRIVATE PROPERTY BaseMethod AS OEMock.Reflection.BaseMethod NO-UNDO
    GET.
    SET. 
    
	DEFINE PUBLIC PROPERTY ParameterOutputValues AS OEMock.Util.NamedStringList NO-UNDO 
	GET.
	PROTECTED SET. 

    CONSTRUCTOR BaseMethodGenerator():
        SUPER().
        
        /* Create objects */
        ParameterOutputValues = NEW NamedStringList().
    END CONSTRUCTOR.
    
    DESTRUCTOR BaseMethodGenerator():
        IF VALID-OBJECT(ParameterOutputValues) THEN DELETE OBJECT ParameterOutputValues.
    END DESTRUCTOR.
    
    METHOD PUBLIC VOID SetParameterOutputValue(INPUT paramName AS CHARACTER, INPUT paramValue AS CHARACTER):
        
        DEFINE VARIABLE parm AS OEMock.Reflection.BaseParameter NO-UNDO.
        DEFINE VARIABLE prim AS OEMock.Reflection.PrimitiveParameter NO-UNDO.

        IF VALID-OBJECT(THIS-OBJECT:BaseMethod) THEN
        DO:        
            /* Find parameter */
            parm = THIS-OBJECT:BaseMethod:Parameters:MoveFirst().
            DO WHILE VALID-OBJECT(parm):
                IF parm:Name = paramName THEN
                DO:
                    /* Detect parameter type and format correctly */
                    IF(parm:GetClass():IsA("OEMock.Reflection.PrimitiveParameter")) THEN
                    DO:
                        prim = CAST(parm, "OEMock.Reflection.PrimitiveParameter").
                        CASE prim:DataType:
                            WHEN 'CHARACTER' THEN
                            DO:
                                IF NOT (paramValue MATCHES ("'*'") OR paramValue MATCHES ('"*"')) AND paramValue NE ? THEN
                                DO:
                                    paramValue = SUBSTITUTE('"&1"', paramValue).
                                END.
                            END.
                        END CASE.
                    END.
            
                    /* Assign into list of output values */
                    ParameterOutputValues:AddValue(paramName, paramValue).
                END.
            END.
        END.
        
    END METHOD.
    
    METHOD PROTECTED VOID AttachTo(INPUT meth AS OEMock.Reflection.BaseMethod):
        THIS-OBJECT:BaseMethod = meth.
    END METHOD.

END CLASS.