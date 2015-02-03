/*------------------------------------------------------------------------
    File        : ProcedureFile
    Purpose     : Represents a procedural ABL file 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseFile.
USING OEMock.Reflection.MethodList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.ProcedureFile INHERITS BaseFile: 

	DEFINE PUBLIC PROPERTY Functions AS OEMock.Reflection.MethodList NO-UNDO 
	GET.
	PROTECTED SET. 

    DEFINE PUBLIC PROPERTY Procedures AS OEMock.Reflection.MethodList NO-UNDO 
    GET.
    PROTECTED SET. 

	CONSTRUCTOR PUBLIC ProcedureFile(INPUT fname AS CHARACTER):
		SUPER(INPUT fname).
		
		/* Create objects */
		Functions  = NEW MethodList().
		Procedures = NEW MethodList().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC ProcedureFile():

	END DESTRUCTOR.
	
	METHOD OVERRIDE PUBLIC LONGCHAR Generate():
	    DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
	    
	    ASSIGN res = SUBSTITUTE("&1&2&3&4&5&6&7",
	                            GenerateFunctionForwards(),
	                            CHR(10),
	                            CHR(13),
                                GenerateProcedures(),
                                CHR(10),
                                CHR(13),
                                GenerateFunctions()).

        RETURN res.
	END METHOD.
	
	METHOD PROTECTED LONGCHAR GenerateFunctionForwards():
	    DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE meth AS OEMock.Reflection.BaseMethod NO-UNDO.
        
        /* Loop through functions */
        meth = Functions:MoveFirst().
        DO WHILE VALID-OBJECT(meth):
            IF meth:RequireForward THEN
                ASSIGN res = res + meth:GenerateForward()
                           + CHR(10) + CHR(13).
            ASSIGN meth = Functions:MoveNext().
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
	END METHOD.
	
	METHOD PROTECTED LONGCHAR GenerateProcedures():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE meth AS OEMock.Reflection.BaseMethod NO-UNDO.
        
        /* Loop through Procedures */
        meth = Procedures:MoveFirst().
        DO WHILE VALID-OBJECT(meth):
            ASSIGN res  = res + meth:Generate()
                        + CHR(10) + CHR(13)
                   meth = Procedures:MoveNext().
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
	END METHOD.

    METHOD PROTECTED LONGCHAR GenerateFunctions():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE meth AS OEMock.Reflection.BaseMethod NO-UNDO.
        
        /* Loop through functions */
        meth = Functions:MoveFirst().
        DO WHILE VALID-OBJECT(meth):
            ASSIGN res  = res + meth:Generate()
                              + CHR(10) + CHR(13)
                   meth = Functions:MoveNext().
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
    END METHOD. 
END CLASS.