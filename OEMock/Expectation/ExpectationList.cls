/*------------------------------------------------------------------------
    File        : ExpectationList
    Purpose     : Holds a list of expectations 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Util.BaseList.
USING OEMock.Expectation.BaseExpectation.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Expectation.ExpectationList INHERITS BaseList: 
		
	CONSTRUCTOR PUBLIC ExpectationList():
		SUPER().
	END CONSTRUCTOR.
    
    METHOD PUBLIC LOGICAL AddExpectation(INPUT parm AS BaseExpectation):
        RETURN SUPER:AddItem(parm).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC VOID EmptyList():
        SUPER:EmptyList().
    END METHOD.
    
    METHOD PROTECTED BaseExpectation CastToBaseExpectation(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS BaseExpectation NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Expectation.BaseExpectation")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
    END METHOD.
    
    METHOD PUBLIC BaseExpectation MoveFirst():
        RETURN CastToBaseExpectation(GetFirst()).
    END METHOD.
    
    METHOD PUBLIC BaseExpectation MoveLast():
        RETURN CastToBaseExpectation(GetLast()).
    END METHOD.
    
    METHOD PUBLIC BaseExpectation MoveNext():
        RETURN CastToBaseExpectation(GetNext()).
    END METHOD.
    
    METHOD PUBLIC BaseExpectation MovePrev():
        RETURN CastToBaseExpectation(GetPrev()).
    END METHOD.

END CLASS.