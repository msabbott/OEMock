/*------------------------------------------------------------------------
    File        : BaseMethodGenerator
    Purpose     : Base class for generators for any class or procedure file
                  methods (equiv to OEMock.Reflection.BaseMethod) 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.BaseGenerator.
USING OEMock.Util.NamedStringList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.BaseMethodGenerator INHERITS BaseGenerator: 
    
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
        
        /* Find parameter */
        /* Detect parameter type and format correctly */

        /* Assign into list of output values */
        ParameterOutputValues:AddValue(paramName, paramValue).
        
    END METHOD.

END CLASS.