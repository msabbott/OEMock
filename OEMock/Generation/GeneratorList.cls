/*------------------------------------------------------------------------
    File        : GeneratorList
    Purpose     : Implements a class holding BaseGenerator objects
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Util.BaseList.
USING OEMock.Generation.BaseGenerator.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.GeneratorList INHERITS BaseList: 

	CONSTRUCTOR PUBLIC GeneratorList():
		SUPER ().
	END CONSTRUCTOR.
	
	METHOD PUBLIC LOGICAL AddGenerator(INPUT parm AS BaseGenerator):
	    RETURN SUPER:AddItem(parm).
	END METHOD.
	
	METHOD OVERRIDE PUBLIC VOID EmptyList():
	    SUPER:EmptyList().
	END METHOD.
	
	METHOD PROTECTED BaseGenerator CastToBaseGenerator(INPUT obj AS Progress.Lang.Object):
        DEFINE VARIABLE res AS BaseGenerator NO-UNDO.
        IF VALID-OBJECT(obj) AND obj:GetClass():IsA("OEMock.Generation.BaseGenerator")THEN
        DO:
            res = DYNAMIC-CAST(obj, obj:GetClass():TypeName).
        END.
        RETURN res.
	END METHOD.
    
    METHOD PUBLIC BaseGenerator MoveFirst():
        RETURN CastToBaseGenerator(GetFirst()).
    END METHOD.
    
    METHOD PUBLIC BaseGenerator MoveLast():
        RETURN CastToBaseGenerator(GetLast()).
    END METHOD.
    
    METHOD PUBLIC BaseGenerator MoveNext():
        RETURN CastToBaseGenerator(GetNext()).
    END METHOD.
    
    METHOD PUBLIC BaseGenerator MovePrev():
        RETURN CastToBaseGenerator(GetPrev()).
    END METHOD.
    
    METHOD PUBLIC LONGCHAR Generate():
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO INITIAL "".
        DEFINE VARIABLE gen AS BaseGenerator NO-UNDO.
        
        /* Loop through Procedures */
        gen = MoveFirst().
        DO WHILE VALID-OBJECT(gen):
            ASSIGN res  = res + gen:Generate()
                        + CHR(10) + CHR(13)
                   gen = MoveNext().
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
    END METHOD.
    
    METHOD PUBLIC LONGCHAR GenerateProcedural():
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO INITIAL "".
        DEFINE VARIABLE gen AS BaseGenerator NO-UNDO.
        
        /* Loop through Procedures */
        gen = MoveFirst().
        DO WHILE VALID-OBJECT(gen):
            ASSIGN res  = res + gen:GenerateProcedural()
                        + CHR(10) + CHR(13)
                   gen = MoveNext().
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
    END METHOD.

END CLASS.