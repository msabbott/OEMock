 /*------------------------------------------------------------------------
    File        : TempTableIndexFieldList
    Purpose     : Holds list of TempTableIndexField objects
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.TempTableIndexField.
USING OEMock.Util.BaseList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.TempTableIndexFieldList INHERITS BaseList: 

	CONSTRUCTOR PUBLIC TempTableIndexFieldList():
		SUPER().
	END CONSTRUCTOR.
    
    METHOD PUBLIC LOGICAL AddTempTableIndexField(INPUT fil AS TempTableIndexField):
        RETURN SUPER:AddItem(fil).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC VOID EmptyList():
        SUPER:EmptyList().
    END METHOD.
    
    METHOD PROTECTED TempTableIndexField CastToTempTableIndexField(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS TempTableIndexField NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Reflection.TempTableIndexField")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC TempTableIndexField MoveFirst():
        RETURN CastToTempTableIndexField(GetFirst()).
    END METHOD.
    
    METHOD PUBLIC TempTableIndexField MoveLast():
        RETURN CastToTempTableIndexField(GetLast()).
    END METHOD.
    
    METHOD PUBLIC TempTableIndexField MoveNext():
        RETURN CastToTempTableIndexField(GetNext()).
    END METHOD.
    
    METHOD PUBLIC TempTableIndexField MovePrev():
        RETURN CastToTempTableIndexField(GetPrev()).
    END METHOD.

END CLASS.