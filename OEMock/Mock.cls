/*------------------------------------------------------------------------
    File        : Mock
    Purpose     : Represents a Mock test double
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.BaseDouble.
USING OEMock.Reflection.*.
USING OEMock.Generation.*.
USING OEMock.Expectation.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Mock INHERITS BaseDouble:
    
    DEFINE PUBLIC PROPERTY Expectations AS OEMock.Expectation.ExpectationList NO-UNDO
        GET.
        PROTECTED SET.
    
    DEFINE PROTECTED PROPERTY InterfaceGenerator AS OEMock.Generation.MockInterfaceGenerator NO-UNDO
        GET.
        PROTECTED SET.
		
	CONSTRUCTOR PUBLIC Mock(INPUT fil AS BaseFile, INPUT basedir AS CHARACTER):
		SUPER(fil, baseDir).
		
		Expectations = NEW ExpectationList().
		
		IF VALID-OBJECT(File) THEN
		DO:
		    Initialise().
		END.

	END CONSTRUCTOR.

	DESTRUCTOR Mock():
	    IF VALID-OBJECT(Expectations)       THEN DELETE OBJECT Expectations.
	    IF VALID-OBJECT(InterfaceGenerator) THEN DELETE OBJECT InterfaceGenerator.
	END DESTRUCTOR.
    
    METHOD OVERRIDE PROTECTED VOID Initialise():
        
        IF VALID-OBJECT(InterfaceGenerator) THEN
           DELETE OBJECT InterfaceGenerator.
        
        InterfaceGenerator = NEW MockInterfaceGenerator().
        
        SUPER:Initialise().

    END METHOD.
    
    METHOD OVERRIDE PROTECTED VOID InitialiseClass(INPUT clsfile AS ClassFile):
        
        DEFINE VARIABLE basemeth AS OEMock.Reflection.BaseMethod          NO-UNDO.
        DEFINE VARIABLE meth     AS OEMock.Reflection.Method              NO-UNDO.
        DEFINE VARIABLE gen      AS OEMock.Generation.MockMethodGenerator NO-UNDO.
        
        /* Attach interface generator */
        InterfaceGenerator:AttachTo(clsfile).
        
        /* Add OEMock to list of uses */
        clsfile:UsingList:Add("OEMock.*").
        
        /* Iterate through methods and attach a MockMethodGenerator to it */
        basemeth = clsfile:Methods:MoveFirst().
        DO WHILE VALID-OBJECT(basemeth):
            
            IF basemeth:GetClass():IsA("OEMock.Reflection.Method") THEN
            DO:
                meth = CAST(basemeth, "OEMock.Reflection.Method").
                gen = NEW MockMethodGenerator().
                MethodGenerators:AddGenerator(meth:Name, gen).
                gen:AttachTo(meth).
            END.
            
            basemeth = clsfile:Methods:MoveNext().
        END.

    END METHOD.
    
    METHOD OVERRIDE PROTECTED VOID InitialiseProcedure(INPUT procfile AS ProcedureFile):
        
        DEFINE VARIABLE basemeth AS OEMock.Reflection.BaseMethod             NO-UNDO.
        DEFINE VARIABLE proc     AS OEMock.Reflection.Procedure              NO-UNDO.
        DEFINE VARIABLE func     AS OEMock.Reflection.Function               NO-UNDO.
        DEFINE VARIABLE pgen     AS OEMock.Generation.MockProcedureGenerator NO-UNDO.
        DEFINE VARIABLE fgen     AS OEMock.Generation.MockFunctionGenerator  NO-UNDO.
        
        /* Attach interface generator */
        InterfaceGenerator:AttachTo(procfile).
        
        /* Add OEMock to list of uses */
        procfile:UsingList:Add("OEMock.*").
        
        /* Iterate through procedures and attach a MockProcedureGenerator to it */
        basemeth = procfile:Procedures:MoveFirst().
        DO WHILE VALID-OBJECT(basemeth):
            
            IF basemeth:GetClass():IsA("OEMock.Reflection.Procedure") THEN
            DO:
                proc = CAST(basemeth, "OEMock.Reflection.Procedure").
                pgen = NEW MockProcedureGenerator().
                ProcedureGenerators:AddGenerator(proc:Name, pgen).
                pgen:AttachTo(proc).
            END.
            
            basemeth = procfile:Procedures:MoveNext().
        END.
        
        /* Iterate through functions and attach a MockFunctionGenerator to it */
        basemeth = procfile:Functions:MoveFirst().
        DO WHILE VALID-OBJECT(basemeth):
            
            IF basemeth:GetClass():IsA("OEMock.Reflection.Function") THEN
            DO:
                func = CAST(basemeth, "OEMock.Reflection.Function").
                fgen = NEW MockFunctionGenerator().
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
    
    METHOD PUBLIC Expectation Expect(INPUT methName AS CHARACTER):
        
        DEFINE VARIABLE expect AS Expectation NO-UNDO.
        
        expect = NEW Expectation(methName).
        Expectations:AddExpectation(expect).
        
        RETURN expect.
    END METHOD.
    
    METHOD PUBLIC VOID AssertIsSatisfied():
        DEFINE VARIABLE expect AS BaseExpectation NO-UNDO.
        expect = Expectations:MoveFirst().
        DO WHILE VALID-OBJECT(expect)
            ON ERROR UNDO, THROW:
            expect:AssertIsSatisfied().
            expect = Expectations:MoveNext().
        END.
    END METHOD.

END CLASS.