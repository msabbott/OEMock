 /*------------------------------------------------------------------------
    File        : NamedGeneratorList
    Purpose     : Holds a named list of Generator objects 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Util.BaseNamedList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.NamedGeneratorList INHERITS BaseNamedList: 

	CONSTRUCTOR PUBLIC NamedGeneratorList():
		SUPER ().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC NamedGeneratorList():

	END DESTRUCTOR.
    
    METHOD PUBLIC OVERRIDE VOID EmptyList():
        SUPER:EmptyList().
    END METHOD.
    
    METHOD PROTECTED OEMock.Generation.BaseGenerator CastToBaseGenerator(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS OEMock.Generation.BaseGenerator NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Generation.BaseGenerator")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC OEMock.Generation.BaseGenerator GetGenerator(INPUT nam AS CHARACTER):
        RETURN CastToBaseGenerator(SUPER:GetValue(nam)).
    END METHOD.
    
    METHOD PUBLIC LOGICAL HasGenerator(INPUT nam AS CHARACTER):
        RETURN SUPER:HasValue(nam).
    END METHOD.
    
    METHOD PUBLIC VOID AddGenerator(INPUT nam AS CHARACTER, INPUT obj AS OEMock.Generation.BaseGenerator):
        SUPER:AddValue(nam, obj).
    END METHOD.
	
	

END CLASS.