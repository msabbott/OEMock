/*------------------------------------------------------------------------
    File        : MockMethodGenerator
    Purpose     : Generator for injecting stub Methodality into Methods 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.MethodGenerator.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.MockMethodGenerator INHERITS MethodGenerator: 

    CONSTRUCTOR PUBLIC MockMethodGenerator():
        SUPER ().
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC MockMethodGenerator():

    END DESTRUCTOR.

END CLASS.