 /*------------------------------------------------------------------------
    File        : ClassFile
    Purpose     : Represents an ABL class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseFile.
USING OEMock.Reflection.MethodList.
USING OEMock.Generation.GeneratorList.
USING OEMock.Util.StringList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.ClassFile INHERITS BaseFile: 
     
    DEFINE PROTECTED PROPERTY ClassRef AS Progress.Lang.Class NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY Constructors AS OEMock.Reflection.MethodList NO-UNDO 
    GET.
    PROTECTED SET. 

    DEFINE PUBLIC PROPERTY Generators AS OEMock.Generation.GeneratorList NO-UNDO 
    GET.
    PROTECTED SET. 
    
    DEFINE PUBLIC PROPERTY InheritsFrom AS CHARACTER NO-UNDO INITIAL ""
    GET.
    SET.

	DEFINE PUBLIC PROPERTY Interfaces AS OEMock.Util.StringList NO-UNDO 
	GET.
	PROTECTED SET. 

    DEFINE PUBLIC PROPERTY Methods AS OEMock.Reflection.MethodList NO-UNDO 
    GET.
    PROTECTED SET. 

    DEFINE PUBLIC PROPERTY Package AS CHARACTER NO-UNDO 
    GET():
        IF VALID-OBJECT(ClassRef) THEN
            RETURN ClassRef:Package.
        ELSE
            RETURN ?.
    END GET.

    DEFINE PUBLIC PROPERTY TypeName AS CHARACTER NO-UNDO 
    GET():
        IF VALID-OBJECT(ClassRef) THEN
            RETURN ClassRef:TypeName.
        ELSE
            RETURN ?.
    END GET.

	DEFINE PUBLIC PROPERTY UsingList AS OEMock.Util.StringList NO-UNDO 
	GET.
	PROTECTED SET. 

    CONSTRUCTOR PUBLIC ClassFile(INPUT fname AS CHARACTER, INPUT cname AS CHARACTER):
        SUPER(INPUT fname).
        
        /* Find class reference and store it */
        ClassRef = Progress.Lang.Class:GetClass(cname).
        
        /* Create objects */
        Constructors = NEW MethodList().
        Methods      = NEW MethodList().
        Generators   = NEW GeneratorList().
        Interfaces   = NEW StringList().
        UsingList    = NEW StringList().        
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC ClassFile():
        IF VALID-OBJECT(Constructors) THEN DELETE OBJECT Constructors.
        IF VALID-OBJECT(Methods)      THEN DELETE OBJECT Methods.
        IF VALID-OBJECT(ClassRef)     THEN DELETE OBJECT ClassRef.
        IF VALID-OBJECT(Generators)   THEN DELETE OBJECT Generators.
        IF VALID-OBJECT(Interfaces)   THEN DELETE OBJECT Interfaces.
        IF VALID-OBJECT(UsingList)    THEN DELETE OBJECT UsingList.
    END DESTRUCTOR.
    
    METHOD PROTECTED LONGCHAR GenerateUsing():
        DEFINE VARIABLE res  AS LONGCHAR  NO-UNDO.
        DEFINE VARIABLE ref  AS CHARACTER NO-UNDO.

        IF UsingList:Count > 0 THEN
        DO:
            /* Loop through Procedures */
            ref = UsingList:MoveFirst().
            DO WHILE (ref NE ? AND ref NE ""):
                ASSIGN res  = SUBSTITUTE("&1&2USING &3.",
                                         res,
                                         CHR(10) + CHR(13),
                                         IF INDEX(ref, " ") > 0 THEN '"' + ref + '"' ELSE ref).
                       ref = UsingList:MoveNext().
            END.
            
            res = TRIM(res).
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".
        
        /* Check that reference to Progress.Lang.* is present in list */
        IF  INDEX(res, "USING Progress.Lang.*.") = 0
        AND INDEX(res, "USING Progress.Lang.Object.") = 0 THEN
        DO:
            ASSIGN res = SUBSTITUTE("USING Progress.Lang.*.&1&2",
                                    CHR(10) + CHR(13),
                                    res).
        END.
        
        RETURN res.
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateClass():
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
        
        ASSIGN res = SUBSTITUTE("CLASS &2 &3&4:"
                              + "&1&5"
                              + "&1&6"
                              + "&1&7"
                              + "&1END CLASS.&1",
                                CHR(10) + CHR(13),
                                IF INDEX(TypeName, " ") > 0 THEN '"' + TypeName + '"' ELSE TypeName,
                                (IF InheritsFrom NE ? AND TRIM(InheritsFrom) NE "" THEN "INHERITS " + TRIM(InheritsFrom) + " " ELSE ""),
                                GenerateInterfaces(),
                                GenerateConstructors(),
                                GenerateMethods(),
                                Generators:Generate()).
        RETURN res.
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateConstructors():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE meth AS OEMock.Reflection.BaseMethod NO-UNDO.
        
        /* Loop through Procedures */
        meth = Constructors:MoveFirst().
        DO WHILE VALID-OBJECT(meth):
            ASSIGN res  = res + meth:Generate()
                        + CHR(10) + CHR(13)
                   meth = Constructors:MoveNext().
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateMethods():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE meth AS OEMock.Reflection.BaseMethod NO-UNDO.
        
        /* Loop through Procedures */
        meth = Methods:MoveFirst().
        DO WHILE VALID-OBJECT(meth):
            ASSIGN res  = res + meth:Generate()
                        + CHR(10) + CHR(13)
                   meth = Methods:MoveNext().
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateInterfaces():
        DEFINE VARIABLE res  AS LONGCHAR  NO-UNDO.
        DEFINE VARIABLE intf AS CHARACTER NO-UNDO.
        
        IF Interfaces:COUNT > 0 THEN
        DO:
            /* Loop through Procedures */
            intf = Interfaces:MoveFirst().
            DO WHILE (intf NE ? AND intf NE ""):
                ASSIGN res  = SUBSTITUTE("&1, &2",
                                         res,
                                         intf).
                       intf = Interfaces:MoveNext().
            END.
            
            ASSIGN res = SUBSTITUTE(" IMPLEMENTS &1",
                                    TRIM(res, ", ")).
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC LONGCHAR Generate():
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
        
        ASSIGN res = SUBSTITUTE("&2&1&3",
                                CHR(10) + CHR(13),
                                GenerateUsing(),
                                GenerateClass()).

        RETURN res.        
    END METHOD.

END CLASS.