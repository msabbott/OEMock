 /*------------------------------------------------------------------------
    File        : EventList
    Purpose     : Holds list of Event objects
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.Event.
USING OEMock.Util.BaseList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.EventList INHERITS BaseList: 

	CONSTRUCTOR PUBLIC EventList():
		SUPER().
	END CONSTRUCTOR.
    
    METHOD PUBLIC LOGICAL AddEvent(INPUT fil AS Event):
        RETURN SUPER:AddItem(fil).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC VOID EmptyList():
        SUPER:EmptyList().
    END METHOD.
    
    METHOD PROTECTED Event CastToEvent(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS Event NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Reflection.Event")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC Event MoveFirst():
        RETURN CastToEvent(GetFirst()).
    END METHOD.
    
    METHOD PUBLIC Event MoveLast():
        RETURN CastToEvent(GetLast()).
    END METHOD.
    
    METHOD PUBLIC Event MoveNext():
        RETURN CastToEvent(GetNext()).
    END METHOD.
    
    METHOD PUBLIC Event MovePrev():
        RETURN CastToEvent(GetPrev()).
    END METHOD.

END CLASS.