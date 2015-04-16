 /*------------------------------------------------------------------------
    File        : TempTableIndexList
    Purpose     : Holds list of TempTableIndex objects
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.TempTableIndex.
USING OEMock.Util.BaseList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.TempTableIndexList INHERITS BaseList: 

	CONSTRUCTOR PUBLIC TempTableIndexList():
		SUPER().
	END CONSTRUCTOR.
    
    METHOD PUBLIC LOGICAL AddTempTableIndex(INPUT fil AS TempTableIndex):
        RETURN SUPER:AddItem(fil).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC VOID EmptyList():
        SUPER:EmptyList().
    END METHOD.
    
    METHOD PROTECTED TempTableIndex CastToTempTableIndex(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS TempTableIndex NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Reflection.TempTableIndex")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC TempTableIndex MoveFirst():
        RETURN CastToTempTableIndex(GetFirst()).
    END METHOD.
    
    METHOD PUBLIC TempTableIndex MoveLast():
        RETURN CastToTempTableIndex(GetLast()).
    END METHOD.
    
    METHOD PUBLIC TempTableIndex MoveNext():
        RETURN CastToTempTableIndex(GetNext()).
    END METHOD.
    
    METHOD PUBLIC TempTableIndex MovePrev():
        RETURN CastToTempTableIndex(GetPrev()).
    END METHOD.

END CLASS.