/*------------------------------------------------------------------------
    File        : List
    Purpose     : List class for holding objecs
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Util.BaseList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Util.List INHERITS BaseList: 

	CONSTRUCTOR PUBLIC List():
		SUPER().
	END CONSTRUCTOR.
    
    METHOD OVERRIDE PUBLIC LOGICAL AddItem(INPUT pItem AS Progress.Lang.Object):
        RETURN SUPER:AddItem(pItem).
    END METHOD.
    
    METHOD OVERRIDE PUBLIC VOID EmptyList():
        SUPER:EmptyList().
    END METHOD.
    
    METHOD OVERRIDE PUBLIC Progress.Lang.Object GetFirst():
        RETURN SUPER:GetFirst().
    END METHOD.
    
    METHOD OVERRIDE PUBLIC Progress.Lang.Object GetLast():
        RETURN SUPER:GetLast().
    END METHOD.
    
    METHOD OVERRIDE PUBLIC Progress.Lang.Object GetNext():
        RETURN SUPER:GetNext().
    END METHOD.
    
    METHOD OVERRIDE PUBLIC Progress.Lang.Object GetPrev():
        RETURN SUPER:GetPrev().
    END METHOD.

END CLASS.