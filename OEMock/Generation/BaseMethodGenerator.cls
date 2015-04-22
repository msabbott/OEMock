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
            paramLoop:
            DO WHILE VALID-OBJECT(parm):
                IF parm:Name = paramName THEN
                DO:
                    /* Detect parameter type and format correctly */
                    IF(parm:GetClass():IsA("OEMock.Reflection.PrimitiveParameter")) THEN
                    DO:
                        prim = CAST(parm, "OEMock.Reflection.PrimitiveParameter").
                        CASE prim:DataType:
                            WHEN "CHARACTER" OR WHEN "LONGCHAR" THEN
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
                    
                    /* Parameter found, break from loop */
                    LEAVE paramLoop.
                END.
                parm = THIS-OBJECT:BaseMethod:Parameters:MoveNext().
            END.
        END.
        
    END METHOD.
    
    METHOD PUBLIC VOID AttachToBaseMethod(INPUT meth AS OEMock.Reflection.BaseMethod):
        THIS-OBJECT:BaseMethod = meth.
        meth:Generators:AddGenerator(THIS-OBJECT).
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateVariableDefinitions():
        RETURN "".
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateParameterAssignment():
        
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO INITIAL "".
        DEFINE VARIABLE parm AS OEMock.Reflection.BaseParameter NO-UNDO.
        
        IF VALID-OBJECT(THIS-OBJECT:BaseMethod) THEN
        DO:        
            /* Find parameter */
            parm = THIS-OBJECT:BaseMethod:Parameters:MoveFirst().
            paramLoop:
            DO WHILE VALID-OBJECT(parm):
                IF ParameterOutputValues:HasValue(parm:Name) THEN
                DO:
                    res = SUBSTITUTE("&1&2&3 = &4",
                                     res,
                                     CHR(13),
                                     parm:Name,
                                     ParameterOutputValues:GetValue(parm:Name)).
                END.
                parm = THIS-OBJECT:BaseMethod:Parameters:MoveNext().
            END.
            
            ASSIGN res = TRIM(res).
            
            IF res NE ? AND res NE "" THEN
                ASSIGN res = SUBSTITUTE("ASSIGN &1.&2",
                                        res,
                                        CHR(13)).
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".
        
        RETURN res.
        
    END METHOD.
    
    METHOD OVERRIDE PUBLIC LONGCHAR Generate():
        RETURN TRIM(SUBSTITUTE("&2&1&3&1&4",
                               CHR(13),
                               GenerateVariableDefinitions(),
                               GenerateParameterAssignment(),
                               GenerateAdditionalContents())).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC LONGCHAR GenerateProcedural():
        RETURN TRIM(SUBSTITUTE("&2&1&3&1&4",
                               CHR(13),
                               GenerateVariableDefinitions(),
                               GenerateParameterAssignment(),
                               GenerateProceduralAdditionalContents())).
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateAdditionalContents():
        RETURN "".
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateProceduralAdditionalContents():
        RETURN "".
    END METHOD.

END CLASS.