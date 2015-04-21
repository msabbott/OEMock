 /*------------------------------------------------------------------------
    File        : TempTableList
    Purpose     : Holds list of TempTable objects
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.TempTable.
USING OEMock.Util.BaseList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.TempTableList INHERITS BaseList: 

	CONSTRUCTOR PUBLIC TempTableList():
		SUPER().
	END CONSTRUCTOR.
    
    METHOD PUBLIC LOGICAL AddTempTable(INPUT fil AS TempTable):
        RETURN SUPER:AddItem(fil).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC VOID EmptyList():
        SUPER:EmptyList().
    END METHOD.
    
    METHOD PROTECTED TempTable CastToTempTable(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS TempTable NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Reflection.TempTable")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC TempTable MoveFirst():
        RETURN CastToTempTable(GetFirst()).
    END METHOD.
    
    METHOD PUBLIC TempTable MoveLast():
        RETURN CastToTempTable(GetLast()).
    END METHOD.
    
    METHOD PUBLIC TempTable MoveNext():
        RETURN CastToTempTable(GetNext()).
    END METHOD.
    
    METHOD PUBLIC TempTable MovePrev():
        RETURN CastToTempTable(GetPrev()).
    END METHOD.

END CLASS.