/*------------------------------------------------------------------------
    File        : Function
    Purpose     : Represents an ABL function
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.ReturningMethod.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.Function INHERITS ReturningMethod: 

    CONSTRUCTOR PUBLIC Function(INPUT dType AS CHARACTER):
        THIS-OBJECT(?, dType).
    END CONSTRUCTOR.

    CONSTRUCTOR PUBLIC Function(INPUT nam AS CHARACTER, INPUT dType AS CHARACTER):
        SUPER(nam,dType).
        RequireForward = TRUE.
    END CONSTRUCTOR.
    
    METHOD OVERRIDE PUBLIC LONGCHAR Generate():
        
        DEFINE VARIABLE func AS LONGCHAR NO-UNDO.
        
        /* Name and return type must be set */
        IF TRIM(Name)        NE "" AND Name       NE ?   
        AND TRIM(ReturnType) NE "" AND ReturnType NE ? THEN
        DO:
            ASSIGN func = GenerateDeclaration() + ":".
                                     
            ASSIGN func = SUBSTITUTE("&1&2&3&2",
                                     func,
                                     CHR(10) + CHR(13),
                                     Generators:Generate()).
                                     
            ASSIGN func = SUBSTITUTE("&1&2&3END FUNCTION.",
                                     func,
                                     CHR(10),
                                     CHR(13)).
        END.
        
        RETURN func.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC LONGCHAR GenerateForward():
        
        DEFINE VARIABLE fwd AS LONGCHAR NO-UNDO.
        
        /* Name and return type must be set */
        IF TRIM(Name)        NE "" AND Name       NE ?   
        AND TRIM(ReturnType) NE "" AND ReturnType NE ? THEN
        DO:
            ASSIGN fwd = GenerateDeclaration() + " FORWARD.".
        END.
        
        RETURN fwd.
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateDeclaration():
        
        DEFINE VARIABLE declaration AS LONGCHAR NO-UNDO.
        
        /* Name and return type must be set */
        IF TRIM(Name)        NE "" AND Name       NE ?   
        AND TRIM(ReturnType) NE "" AND ReturnType NE ? THEN
        DO:
            ASSIGN declaration = SUBSTITUTE("FUNCTION &1 RETURNS &2 (&3)",
                                            Name,
                                            ReturnType,
                                            GenerateParameters()).
        END.
        
        RETURN declaration.
    END METHOD.

END CLASS.