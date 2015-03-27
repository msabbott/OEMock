 /*------------------------------------------------------------------------
    File        : DataSetList
    Purpose     : Holds list of DataSet objects
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.DataSet.
USING OEMock.Util.BaseList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.DataSetList INHERITS BaseList: 

	CONSTRUCTOR PUBLIC DataSetList():
		SUPER().
	END CONSTRUCTOR.
    
    METHOD PUBLIC LOGICAL AddDataSet(INPUT fil AS DataSet):
        RETURN SUPER:AddItem(fil).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC VOID EmptyList():
        SUPER:EmptyList().
    END METHOD.
    
    METHOD PROTECTED DataSet CastToDataSet(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS DataSet NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Reflection.DataSet")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC DataSet MoveFirst():
        RETURN CastToDataSet(GetFirst()).
    END METHOD.
    
    METHOD PUBLIC DataSet MoveLast():
        RETURN CastToDataSet(GetLast()).
    END METHOD.
    
    METHOD PUBLIC DataSet MoveNext():
        RETURN CastToDataSet(GetNext()).
    END METHOD.
    
    METHOD PUBLIC DataSet MovePrev():
        RETURN CastToDataSet(GetPrev()).
    END METHOD.

END CLASS.