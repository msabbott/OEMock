/*------------------------------------------------------------------------
    File        : ClassToStub
    Purpose     : Class that will be stubbed out during tests 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS "Examples.Example 3.ClassToStub":
    
    CONSTRUCTOR ClassToStub():
    END CONSTRUCTOR.
    
    DESTRUCTOR ClassToStub():
    END DESTRUCTOR.
    
    METHOD PUBLIC CHARACTER GetUserName():
        /* For the purposes of this example, this returns a simple string */
        RETURN "Joe Bloggs Jnr.".
    END METHOD.

END CLASS.