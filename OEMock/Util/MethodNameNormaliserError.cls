 /*------------------------------------------------------------------------
    File        : MethodNameNormaliserError
    Purpose     : Error class for parsing errors in MethodNameNormaliser
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Lang.AppError.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Util.MethodNameNormaliserError INHERITS AppError: 

  CONSTRUCTOR PUBLIC MethodNameNormaliserError(INPUT msg AS CHARACTER):
    SUPER(msg, 0).
  END CONSTRUCTOR.

END CLASS.