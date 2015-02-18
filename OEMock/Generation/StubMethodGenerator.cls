/*------------------------------------------------------------------------
    File        : StubMethodGenerator
    Purpose     : Generator for injecting stub Methodality into Methods 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Generation.MethodGenerator.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Generation.StubMethodGenerator INHERITS MethodGenerator: 

    CONSTRUCTOR PUBLIC StubMethodGenerator():
        SUPER ().
    END CONSTRUCTOR.

    DESTRUCTOR PUBLIC StubMethodGenerator():

    END DESTRUCTOR.

END CLASS.