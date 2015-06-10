 /*------------------------------------------------------------------------
    File        : ClassFile
    Purpose     : Represents an ABL class
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.BaseFile.
USING OEMock.Reflection.MethodList.
USING OEMock.Generation.GeneratorList.
USING OEMock.Util.StringList.
USING OEMock.Reflection.DataSetList.
USING OEMock.Reflection.EventList.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Reflection.ClassFile INHERITS BaseFile: 
     
    DEFINE PROTECTED PROPERTY ClassRef AS Progress.Lang.Class NO-UNDO 
    GET.
    SET. 

    DEFINE PUBLIC PROPERTY Constructors AS OEMock.Reflection.MethodList NO-UNDO 
    GET.
    PROTECTED SET. 

    DEFINE PUBLIC PROPERTY DataSets AS OEMock.Reflection.DataSetList NO-UNDO 
    GET.
    PROTECTED SET. 

    DEFINE PUBLIC PROPERTY Events AS OEMock.Reflection.EventList NO-UNDO 
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

    CONSTRUCTOR PUBLIC ClassFile(INPUT fname AS CHARACTER, INPUT cname AS CHARACTER):
        SUPER(INPUT fname).
        
        /* Find class reference and store it */
        ClassRef = Progress.Lang.Class:GetClass(cname).
        
        /* Create objects */
        Constructors = NEW MethodList().
        Methods      = NEW MethodList().
        Generators   = NEW GeneratorList().
        Interfaces   = NEW StringList().
        DataSets     = NEW DataSetList().
        Events       = NEW EventList().
             
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC ClassFile():
        IF VALID-OBJECT(Constructors) THEN DELETE OBJECT Constructors.
        IF VALID-OBJECT(Methods)      THEN DELETE OBJECT Methods.
        IF VALID-OBJECT(ClassRef)     THEN DELETE OBJECT ClassRef.
        IF VALID-OBJECT(Generators)   THEN DELETE OBJECT Generators.
        IF VALID-OBJECT(Interfaces)   THEN DELETE OBJECT Interfaces.
        IF VALID-OBJECT(DataSets)     THEN DELETE OBJECT DataSets.
        IF VALID-OBJECT(Events)       THEN DELETE OBJECT Events.
    END DESTRUCTOR.
    
    METHOD PROTECTED LONGCHAR GenerateClass():
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO.

        ASSIGN res = "CLASS " + (IF INDEX(TypeName, " ") > 0 THEN '"' + TypeName + '"' ELSE TypeName) + " "
                   + (IF InheritsFrom NE ? AND TRIM(InheritsFrom) NE "" THEN "INHERITS " + TRIM(InheritsFrom) + " " ELSE "")
                   + GenerateInterfaces() + ":"
                   + CHR(13) + GenerateTempTables()
                   + CHR(13) + GenerateDataSets()
                   + CHR(13) + GenerateConstructors()
                   + CHR(13) + GenerateMethods()
                   + CHR(13) + Generators:Generate()
                   + CHR(13) + GenerateEvents()
                   + CHR(13) + "END CLASS." + CHR(13).
                              
        RETURN res.
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateTempTables():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE ttab AS OEMock.Reflection.TempTable NO-UNDO.
        
        /* Loop through datasets */
        ttab = TempTables:MoveFirst().
        DO WHILE VALID-OBJECT(ttab):
            ASSIGN res  = res + ttab:Generate()
                        + CHR(13)
                   ttab = TempTables:MoveNext().
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateDataSets():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE dset AS OEMock.Reflection.DataSet NO-UNDO.
        
        /* Loop through datasets */
        dset = DataSets:MoveFirst().
        DO WHILE VALID-OBJECT(dset):
            ASSIGN res  = res + dset:Generate()
                        + CHR(13)
                   dset = DataSets:MoveNext().
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateEvents():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE evnt AS OEMock.Reflection.Event NO-UNDO.
        
        /* Loop through datasets */
        evnt = Events:MoveFirst().
        DO WHILE VALID-OBJECT(evnt):
            ASSIGN res  = res + evnt:Generate()
                        + CHR(13)
                   evnt = Events:MoveNext().
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
    END METHOD.
    
    METHOD PROTECTED LONGCHAR GenerateConstructors():
        DEFINE VARIABLE res  AS LONGCHAR NO-UNDO.
        DEFINE VARIABLE meth AS OEMock.Reflection.BaseMethod NO-UNDO.
        
        /* Loop through Procedures */
        meth = Constructors:MoveFirst().
        DO WHILE VALID-OBJECT(meth):
            ASSIGN res  = res + meth:Generate()
                        + CHR(13)
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
                        + CHR(13)
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
                ASSIGN res  = res + ", " + intf
                       intf = Interfaces:MoveNext().
            END.
            
            ASSIGN res = " IMPLEMENTS " + TRIM(res, ", ").
        END.
        
        /* Sanity check output */
        IF res = ? THEN res = "".

        RETURN res.
    END METHOD.
    
    METHOD OVERRIDE PUBLIC LONGCHAR Generate():
        DEFINE VARIABLE res AS LONGCHAR NO-UNDO.
        
        ASSIGN res = GenerateUsing() + CHR(13)
                   + GenerateClass().

        RETURN res.        
    END METHOD.

END CLASS.