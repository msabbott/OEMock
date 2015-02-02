 
 /*------------------------------------------------------------------------
    File        : MethodList
    Purpose     : Holds list of BaseMethod objects
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseMethod.
USING OEMock.Util.BaseList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.MethodList INHERITS BaseList: 

		
	CONSTRUCTOR PUBLIC MethodList (  ):
		SUPER ().
		
	END CONSTRUCTOR.
    
    METHOD PUBLIC LOGICAL AddMethod(INPUT fil AS BaseMethod):
        RETURN SUPER:AddItem(fil).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC VOID EmptyList():
        SUPER:EmptyList().
    END METHOD.
    
    METHOD PROTECTED BaseMethod CastToBaseMethod(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS BaseMethod NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Reflection.BaseMethod")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC BaseMethod MoveFirst():
        RETURN CastToBaseMethod(GetFirst()).
    END METHOD.
    
    METHOD PUBLIC BaseMethod MoveLast():
        RETURN CastToBaseMethod(GetLast()).
    END METHOD.
    
    METHOD PUBLIC BaseMethod MoveNext():
        RETURN CastToBaseMethod(GetNext()).
    END METHOD.
    
    METHOD PUBLIC BaseMethod MovePrev():
        RETURN CastToBaseMethod(GetPrev()).
    END METHOD.

END CLASS.