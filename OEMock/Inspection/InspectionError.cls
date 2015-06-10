/*------------------------------------------------------------------------
    File        : InspectionError
    Purpose     : Application error class for errors during inspection 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Progress.Lang.AppError.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Inspection.InspectionError INHERITS AppError: 

END CLASS.