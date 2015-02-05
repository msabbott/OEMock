 /*------------------------------------------------------------------------
    File        : ClassFile
    Purpose     : Represents an ABL class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseFile.
USING OEMock.Reflection.MethodList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.ClassFile INHERITS BaseFile: 
     
    DEFINE PROTECTED PROPERTY ClassRef AS Progress.Lang.Class NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY Constructors AS OEMock.Reflection.MethodList NO-UNDO 
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

    CONSTRUCTOR PUBLIC ClassFile(INPUT fname AS CHARACTER, INPUT cname AS CHARACTER):
        SUPER(INPUT fname).
        
        /* Find class reference and store it */
        ClassRef = Progress.Lang.Class:GetClass(cname).
        
        /* Create objects */
        Constructors = NEW MethodList().
        Methods      = NEW MethodList().
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC ClassFile():
        IF VALID-OBJECT(Constructors) THEN DELETE OBJECT Constructors.
        IF VALID-OBJECT(Methods)      THEN DELETE OBJECT Methods.
        IF VALID-OBJECT(ClassRef)     THEN DELETE OBJECT ClassRef.
    END DESTRUCTOR.
    
    METHOD PROTECTED LONGCHAR GenerateUsing():
        DEFINE VARIABLE refs AS LONGCHAR NO-UNDO.
        
        ASSIGN refs = "USING Progress.Lang.*." + CHR(10) + CHR(13).

        RETURN refs.
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateClass():
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
        
        ASSIGN res = SUBSTITUTE("CLASS &1:&2&3&2&4&2END CLASS.&2",
                                TypeName,
                                CHR(10) + CHR(13),
                                GenerateConstructors(),
                                GenerateMethods()).
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
    
    METHOD OVERRIDE PUBLIC LONGCHAR Generate():
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
        
        ASSIGN res = SUBSTITUTE("&1&2",
                                GenerateUsing(),
                                GenerateClass()).

        RETURN res.        
    END METHOD.

END CLASS.