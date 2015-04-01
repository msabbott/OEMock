 /*------------------------------------------------------------------------
    File        : DataSetRelationList
    Purpose     : Holds list of DataSetRelation objects
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.DataSetRelation.
USING OEMock.Util.BaseList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.DataSetRelationList INHERITS BaseList: 

	CONSTRUCTOR PUBLIC DataSetRelationList():
		SUPER().
	END CONSTRUCTOR.
    
    METHOD PUBLIC LOGICAL AddDataSetRelation(INPUT fil AS DataSetRelation):
        RETURN SUPER:AddItem(fil).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC VOID EmptyList():
        SUPER:EmptyList().
    END METHOD.
    
    METHOD PROTECTED DataSetRelation CastToDataSetRelation(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS DataSetRelation NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Reflection.DataSetRelation")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC DataSetRelation MoveFirst():
        RETURN CastToDataSetRelation(GetFirst()).
    END METHOD.
    
    METHOD PUBLIC DataSetRelation MoveLast():
        RETURN CastToDataSetRelation(GetLast()).
    END METHOD.
    
    METHOD PUBLIC DataSetRelation MoveNext():
        RETURN CastToDataSetRelation(GetNext()).
    END METHOD.
    
    METHOD PUBLIC DataSetRelation MovePrev():
        RETURN CastToDataSetRelation(GetPrev()).
    END METHOD.

END CLASS.