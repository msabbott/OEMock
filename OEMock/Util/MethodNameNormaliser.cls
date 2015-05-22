/*------------------------------------------------------------------------
    File        : MethodNameNormaliser
    Purpose     : Defines functionality for normalising a class methods name
                  and for finding a method from a list based on a
                  semi-normalised input
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.Method.
USING OEMock.Reflection.BaseParameter.

ROUTINE-LEVEL ON ERROR UNDO, THROW.

CLASS OEMock.Util.MethodNameNormaliser: 
		
	CONSTRUCTOR PUBLIC MethodNameNormaliser():
		SUPER().
	END CONSTRUCTOR.

	DESTRUCTOR PUBLIC MethodNameNormaliser():
	END DESTRUCTOR.
	
	METHOD PUBLIC STATIC CHARACTER Normalise(INPUT meth AS OEMock.Reflection.Method):
	    DEFINE VARIABLE res AS CHARACTER NO-UNDO.
	    DEFINE VARIABLE parm AS BaseParameter NO-UNDO.
	    
	    IF VALID-OBJECT(meth) THEN
	    DO:
	        ASSIGN res = meth:Name.
	        
	        IF meth:Parameters:Count > 0 THEN
	        DO:
	            ASSIGN res = res + "(".
	            
	            ASSIGN parm = meth:Parameters:MoveFirst().
	            DO WHILE VALID-OBJECT(parm):
	                ASSIGN res = res
	                           + parm:Normalise()
	                           + ", ".
	                ASSIGN parm = meth:Parameters:MoveNext().
	            END.
	            
	            ASSIGN res = TRIM(res, ", ") + ")".
	        END.
	    END.
	    
	    RETURN res.
	END METHOD.

END CLASS.