/*------------------------------------------------------------------------
    File        : ProcedureFile
    Purpose     : Represents a procedural ABL file 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseFile.
USING OEMock.Reflection.MethodList.
USING OEMock.Generation.GeneratorList.
USING OEMock.Reflection.DataSetList.
USING OEMock.Reflection.ParameterList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.ProcedureFile INHERITS BaseFile: 

	DEFINE PUBLIC PROPERTY DataSets AS OEMock.Reflection.DataSetList NO-UNDO 
	GET.
	PROTECTED SET. 

    DEFINE PUBLIC PROPERTY Functions AS OEMock.Reflection.MethodList NO-UNDO 
    GET.
    PROTECTED SET. 

    DEFINE PUBLIC PROPERTY Generators AS OEMock.Generation.GeneratorList NO-UNDO 
    GET.
    PROTECTED SET. 

    DEFINE PUBLIC PROPERTY Parameters AS OEMock.Reflection.ParameterList NO-UNDO 
    GET.
    PROTECTED SET. 

    DEFINE PUBLIC PROPERTY Procedures AS OEMock.Reflection.MethodList NO-UNDO 
    GET.
    PROTECTED SET. 

	CONSTRUCTOR PUBLIC ProcedureFile(INPUT fname AS CHARACTER):
		SUPER(INPUT fname).
		
		/* Create objects */
		DataSets   = NEW DataSetList().
		Functions  = NEW MethodList().
		Procedures = NEW MethodList().
		Generators = NEW GeneratorList().
		Parameters = NEW ParameterList().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC ProcedureFile():
        IF VALID-OBJECT(DataSets)   THEN DELETE OBJECT DataSets.
	    IF VALID-OBJECT(Functions)  THEN DELETE OBJECT Functions.
	    IF VALID-OBJECT(Procedures) THEN DELETE OBJECT Procedures.
        IF VALID-OBJECT(Generators) THEN DELETE OBJECT Generators.
        IF VALID-OBJECT(Parameters) THEN DELETE OBJECT Parameters.
	END DESTRUCTOR.
	
	METHOD OVERRIDE PUBLIC LONGCHAR Generate():
	    DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
	    
	    ASSIGN res = SUBSTITUTE("&1&2&1&3&1&4&1&5&1&6&1&7&1&8",
	                            CHR(10) + CHR(13),
	                            GenerateUsing(),
	                            GenerateDataSets(),
	                            GenerateParameters(),
	                            GenerateFunctionForwards(),
	                            Generators:GenerateProcedural(),
                                GenerateProcedures(),
                                GenerateFunctions()).

        RETURN res.
	END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateDataSets():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSet NO-UNDO.
        
        /* Loop through datasets */
        dset = DataSets:MoveFirst().
        DO WHILE VALID-OBJECT(dset):
            ASSIGN res  = res + dset:Generate()
                        + CHR(10) + CHR(13)
                   dset = DataSets:MoveNext().
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateParameters():
        DEFINE VARIABLE res AS CHARACTER NO-UNDO.
        DEFINE VARIABLE parm AS OEMock.Reflection.BaseParameter NO-UNDO.
        
        /* Loop through parameters */
        parm = Parameters:MoveFirst().
        DO WHILE VALID-OBJECT(parm):
            ASSIGN res  = res + parm:GenerateDefinition()
                   parm = Parameters:MoveNext().
        END. 
        
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