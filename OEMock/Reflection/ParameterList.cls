/*------------------------------------------------------------------------
    File        : ParameterList
    Purpose     : Implements a class holding BaseParameter objects
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Util.BaseList.
USING OEMock.Reflection.BaseParameter.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.ParameterList INHERITS BaseList: 

	CONSTRUCTOR PUBLIC ParameterList():
		SUPER ().
	END CONSTRUCTOR.
	
	METHOD PUBLIC LOGICAL AddParameter(INPUT parm AS BaseParameter):
	    SUPER:AddItem(parm).
	END METHOD.
	
	METHOD OVERRIDE PUBLIC VOID EmptyList():
	    SUPER:EmptyList().
	END METHOD.
	
	METHOD PROTECTED BaseParameter CastToBaseParameter(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS BaseParameter NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Reflection.BaseParameter")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
	END METHOD.
    
    METHOD PUBLIC BaseParameter MoveFirst():
        RETURN CastToBaseParameter(GetFirst()).
    END METHOD.
    
    METHOD PUBLIC BaseParameter MoveLast():
        RETURN CastToBaseParameter(GetLast()).
    END METHOD.
    
    METHOD PUBLIC BaseParameter MoveNext():
        RETURN CastToBaseParameter(GetNext()).
    END METHOD.
    
    METHOD PUBLIC BaseParameter MovePrev():
        RETURN CastToBaseParameter(GetPrev()).
    END METHOD.

END CLASS.