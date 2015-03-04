 /*------------------------------------------------------------------------
    File        : Stub
    Purpose     : Represents a Stub testing double.
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.BaseDouble.
USING OEMock.Reflection.BaseFile.
USING OEMock.Generation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Stub INHERITS BaseDouble: 
    
    DEFINE PROTECTED PROPERTY InterfaceGenerator AS OEMock.Generation.StubInterfaceGenerator NO-UNDO
        GET.
        PROTECTED SET.

	CONSTRUCTOR PUBLIC Stub(INPUT fil AS BaseFile, INPUT basedir AS CHARACTER):
		SUPER(fil, baseDir).
		
		IF VALID-OBJECT(File) THEN
		DO:
		    Initialise().
		END.

	END CONSTRUCTOR.
	
	DESTRUCTOR Stub():
	    
	END DESTRUCTOR.
	
	METHOD PROTECTED VOID Initialise():
	    
	    IF VALID-OBJECT(InterfaceGenerator) THEN
	       DELETE OBJECT InterfaceGenerator.
	    
	    InterfaceGenerator = NEW StubInterfaceGenerator().
	    
        IF File:GetClass():IsA("OEMock.Reflection.ClassFile") THEN
        DO:
            InitialiseClass().
        END.
        ELSE IF File:GetClass():IsA("OEMock.Reflection.ProcedureFile") THEN
        DO:
            InitialiseProcedure().
        END.

	END METHOD.
	
	METHOD PROTECTED VOID InitialiseClass():
	    
	    DEFINE VARIABLE clsfile  AS OEMock.Reflection.ClassFile           NO-UNDO.
	    DEFINE VARIABLE basemeth AS OEMock.Reflection.BaseMethod          NO-UNDO.
	    DEFINE VARIABLE meth     AS OEMock.Reflection.Method              NO-UNDO.
	    DEFINE VARIABLE gen      AS OEMock.Generation.StubMethodGenerator NO-UNDO.
	    
	    clsfile = CAST(File, "OEMock.Reflection.ClassFile").
	    
	    /* Attach interface generator */
	    InterfaceGenerator:AttachTo(clsfile).
	    
	    /* Iterate through methods and attach a StubMethodGenerator to it */
	    basemeth = clsfile:Methods:MoveFirst().
	    DO WHILE VALID-OBJECT(basemeth):
	        
	        IF basemeth:GetClass():IsA("OEMock.Reflection.Method") THEN
	        DO:
	            meth = CAST(basemeth, "OEMock.Reflection.Method").
	            gen = NEW StubMethodGenerator().
                MethodGenerators:AddGenerator(meth:Name, gen).
	            gen:AttachTo(meth).
	        END.
	        
	        basemeth = clsfile:Methods:MoveNext().
	    END.

	END METHOD.
	
	METHOD PROTECTED VOID InitialiseProcedure():
        
        DEFINE VARIABLE procfile AS OEMock.Reflection.ProcedureFile          NO-UNDO.
        DEFINE VARIABLE basemeth AS OEMock.Reflection.BaseMethod             NO-UNDO.
        DEFINE VARIABLE proc     AS OEMock.Reflection.Procedure              NO-UNDO.
        DEFINE VARIABLE func     AS OEMock.Reflection.Function               NO-UNDO.
        DEFINE VARIABLE pgen     AS OEMock.Generation.StubProcedureGenerator NO-UNDO.
        DEFINE VARIABLE fgen     AS OEMock.Generation.StubFunctionGenerator  NO-UNDO.
        
        procfile = CAST(File, "OEMock.Reflection.ProcedureFile").
        
        /* Attach interface generator */
        InterfaceGenerator:AttachTo(procfile).
        
        /* Iterate through procedures and attach a StubProcedureGenerator to it */
        basemeth = procfile:Procedures:MoveFirst().
        DO WHILE VALID-OBJECT(basemeth):
            
            IF basemeth:GetClass():IsA("OEMock.Reflection.Procedure") THEN
            DO:
                proc = CAST(basemeth, "OEMock.Reflection.Procedure").
                pgen = NEW StubProcedureGenerator().
                ProcedureGenerators:AddGenerator(proc:Name, pgen).
                pgen:AttachTo(proc).
            END.
            
            basemeth = procfile:Procedures:MoveNext().
        END.
        
        /* Iterate through functions and attach a StubFunctionGenerator to it */
        basemeth = procfile:Functions:MoveFirst().
        DO WHILE VALID-OBJECT(basemeth):
            
            IF basemeth:GetClass():IsA("OEMock.Reflection.Function") THEN
            DO:
                func = CAST(basemeth, "OEMock.Reflection.Function").
                fgen = NEW StubFunctionGenerator().
                FunctionGenerators:AddGenerator(func:Name, fgen).
                fgen:AttachTo(func).
            END.
            
            basemeth = procfile:Functions:MoveNext().
        END.
	END METHOD.
    
    METHOD PUBLIC VOID SetProcedureOutputParameterValue(INPUT procName AS CHARACTER,
                                                        INPUT paramName AS CHARACTER,
                                                        INPUT paramReturnValue AS CHARACTER):
        DEFINE VARIABLE baseGen AS BaseGenerator       NO-UNDO.
        DEFINE VARIABLE methGen AS BaseMethodGenerator NO-UNDO.
        
        baseGen = ProcedureGenerators:GetGenerator(procName).
        
        IF VALID-OBJECT(baseGen) AND baseGen:GetClass():IsA("OEMock.Generation.BaseMethodGenerator") THEN
        DO:
            methGen = DYNAMIC-CAST(baseGen, baseGen:GetClass():TypeName).
            methGen:SetParameterOutputValue(INPUT paramName, INPUT paramReturnValue).
        END.
        
    END METHOD.
    
    METHOD PUBLIC VOID SetFunctionOutputParameterValue(INPUT funcName AS CHARACTER,
                                                       INPUT paramName AS CHARACTER,
                                                       INPUT paramReturnValue AS CHARACTER):
        DEFINE VARIABLE baseGen AS BaseGenerator       NO-UNDO.
        DEFINE VARIABLE methGen AS BaseMethodGenerator NO-UNDO.
        
        baseGen = FunctionGenerators:GetGenerator(funcName).
        
        IF VALID-OBJECT(baseGen) AND baseGen:GetClass():IsA("OEMock.Generation.BaseMethodGenerator") THEN
        DO:
            methGen = DYNAMIC-CAST(baseGen, baseGen:GetClass():TypeName).
            methGen:SetParameterOutputValue(INPUT paramName, INPUT paramReturnValue).
        END.
        
    END METHOD.
    
    METHOD PUBLIC VOID SetFunctionReturnValue(INPUT funcName AS CHARACTER,
                                              INPUT retValue AS CHARACTER):
        DEFINE VARIABLE baseGen AS BaseGenerator     NO-UNDO.
        DEFINE VARIABLE funcGen AS FunctionGenerator NO-UNDO.
        
        baseGen = FunctionGenerators:GetGenerator(funcName).
        
        IF VALID-OBJECT(baseGen) AND baseGen:GetClass():IsA("OEMock.Generation.FunctionGenerator") THEN
        DO:
            funcGen = DYNAMIC-CAST(baseGen, baseGen:GetClass():TypeName).
            funcGen:SetReturnValue(INPUT retValue).
        END.
        
    END METHOD.
    
    METHOD PUBLIC VOID SetMethodOutputParameterValue(INPUT methName AS CHARACTER,
                                                     INPUT paramName AS CHARACTER,
                                                     INPUT paramReturnValue AS CHARACTER):
        DEFINE VARIABLE baseGen AS BaseGenerator       NO-UNDO.
        DEFINE VARIABLE methGen AS BaseMethodGenerator NO-UNDO.
        
        baseGen = MethodGenerators:GetGenerator(methName).
        
        IF VALID-OBJECT(baseGen) AND baseGen:GetClass():IsA("OEMock.Generation.BaseMethodGenerator") THEN
        DO:
            methGen = DYNAMIC-CAST(baseGen, baseGen:GetClass():TypeName).
            methGen:SetParameterOutputValue(INPUT paramName, INPUT paramReturnValue).
        END.
        
    END METHOD.
    
    METHOD PUBLIC VOID SetMethodReturnValue(INPUT methName AS CHARACTER,
                                            INPUT retValue AS CHARACTER):
        DEFINE VARIABLE baseGen AS BaseGenerator   NO-UNDO.
        DEFINE VARIABLE methGen AS MethodGenerator NO-UNDO.
        
        baseGen = MethodGenerators:GetGenerator(methName).
        
        IF VALID-OBJECT(baseGen) AND baseGen:GetClass():IsA("OEMock.Generation.MethodGenerator") THEN
        DO:
            methGen = DYNAMIC-CAST(baseGen, baseGen:GetClass():TypeName).
            methGen:SetReturnValue(INPUT retValue).
        END.
        
    END METHOD.

END CLASS.