/*------------------------------------------------------------------------
    File        : ClassToMock
    Purpose     : Class that will be Mocked out during tests 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS "Examples.Example 5.ClassToMock":
    
    CONSTRUCTOR ClassToMock():
    END CONSTRUCTOR.
    
    DESTRUCTOR ClassToMock():
    END DESTRUCTOR.
    
    METHOD PUBLIC CHARACTER GetUserName():
        /* For the purposes of this example, this returns a simple string */
        RETURN "Joe Bloggs Jnr.".
    END METHOD.

END CLASS.