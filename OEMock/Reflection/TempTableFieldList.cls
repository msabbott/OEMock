 /*------------------------------------------------------------------------
    File        : TempTableFieldList
    Purpose     : Holds list of TempTableField objects
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.TempTableField.
USING OEMock.Util.BaseList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.TempTableFieldList INHERITS BaseList: 

	CONSTRUCTOR PUBLIC TempTableFieldList():
		SUPER().
	END CONSTRUCTOR.
    
    METHOD PUBLIC LOGICAL AddTempTableField(INPUT fil AS TempTableField):
        RETURN SUPER:AddItem(fil).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC VOID EmptyList():
        SUPER:EmptyList().
    END METHOD.
    
    METHOD PROTECTED TempTableField CastToTempTableField(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS TempTableField NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Reflection.TempTableField")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC TempTableField MoveFirst():
        RETURN CastToTempTableField(GetFirst()).
    END METHOD.
    
    METHOD PUBLIC TempTableField MoveLast():
        RETURN CastToTempTableField(GetLast()).
    END METHOD.
    
    METHOD PUBLIC TempTableField MoveNext():
        RETURN CastToTempTableField(GetNext()).
    END METHOD.
    
    METHOD PUBLIC TempTableField MovePrev():
        RETURN CastToTempTableField(GetPrev()).
    END METHOD.

END CLASS.