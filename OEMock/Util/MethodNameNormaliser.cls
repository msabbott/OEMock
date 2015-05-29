/*------------------------------------------------------------------------
    File        : MethodNameNormaliser
    Purpose     : Defines functionality for normalising a class methods name
                  and for finding a method from a list based on a
                  semi-normalised input
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OEMock.Reflection.Method.
USING OEMock.Reflection.BaseParameter.
USING OEMock.Util.MethodNameNormaliserError.

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
	
	METHOD PUBLIC STATIC CHARACTER Sanitise_old(INPUT meth AS CHARACTER):
	    
	    /* Convert a user-input string, into a valid normalised method name.
	     * N.B. At this stage, there is no guarantee that the mentod exists,
	     * we are just sanitising the input
	     */
	     
	    DEFINE VARIABLE methName AS CHARACTER NO-UNDO.
	    DEFINE VARIABLE params   AS CHARACTER NO-UNDO.
	    DEFINE VARIABLE startPos AS INTEGER NO-UNDO.
	    DEFINE VARIABLE endPos AS INTEGER NO-UNDO.
	     
	    /* Separate into method name and parameters */
	    ASSIGN methName = ENTRY(1, meth, "(").
	    
	    IF NUM-ENTRIES(meth, "(") > 1 THEN
	    DO:
	        ASSIGN startPos = INDEX(meth, "(")
	               endPos   = INDEX(meth, ")", startPos + 1).
	        
	        IF endPos = -1 THEN ASSIGN endPos = LENGTH(meth).
	        
	        ASSIGN params = SUBSTRING(meth, startPos + 1, (endPos - startPos) - 1)
	               params = TRIM(params, " ()[]." + CHR(10) + CHR(13)).
	    END.
	    
	    /* Correct methName */
	    ASSIGN methName = TRIM(methName).
	    
	    /* If there are any spaces, commas, semi-colons, etc the stop the name before that point */
	    
	    
	    
	END METHOD.
    
    METHOD PUBLIC STATIC CHARACTER Sanitise(INPUT meth AS CHARACTER):
        
        /* Convert a user-input string, into a valid normalised method name.
         * N.B. At this stage, there is no guarantee that the mentod exists,
         * we are just sanitising the input.
         * This uses a right-hand parse method.
         */
         
        DEFINE VARIABLE methName    AS CHARACTER NO-UNDO.
        DEFINE VARIABLE params      AS CHARACTER NO-UNDO.
        DEFINE VARIABLE paramStart  AS INTEGER   NO-UNDO INITIAL 0.
        DEFINE VARIABLE paramEnd    AS INTEGER   NO-UNDO INITIAL 0.
        DEFINE VARIABLE parm        AS CHARACTER NO-UNDO.
        DEFINE VARIABLE fixedParams AS CHARACTER NO-UNDO.
        DEFINE VARIABLE fixedParam  AS CHARACTER NO-UNDO.
        DEFINE VARIABLE word        AS CHARACTER NO-UNDO.
        
        DEFINE VARIABLE invalidMethNameChars AS CHARACTER NO-UNDO.
        DEFINE VARIABLE iLoop                AS INTEGER   NO-UNDO.
        DEFINE VARIABLE iParamLoop           AS INTEGER   NO-UNDO.
        DEFINE VARIABLE lastWord             AS LOGICAL   NO-UNDO.
        DEFINE VARIABLE validateObject       AS LOGICAL   NO-UNDO.
        
        ASSIGN paramEnd = R-INDEX(meth, ")").
        
        IF paramEnd > 0 THEN
        DO:
            ASSIGN paramStart = R-INDEX(meth, "(", paramEnd).
        END.
        
        /* If a parameter start and end were both found, the use these values */
        IF paramStart > 0 AND paramEnd > 0 THEN
            ASSIGN params = SUBSTRING(meth, paramStart + 1, (paramEnd - 1) - paramStart)
                   methName = SUBSTRING(meth, 1, paramStart - 1).
        ELSE
            ASSIGN params   = ""
                   methName = meth.
                   
        /* Process method name */
        ASSIGN methName = TRIM(methName).
        
        /* If there are any spaces, commas or brackets, then use the first entry */
        ASSIGN invalidMethNameChars = " ,.:;()[]~{}'~"@"
                                    + CHR(10) + CHR(13).
        DO iLoop = 1 TO LENGTH(invalidMethNameChars):
            ASSIGN methName = ENTRY(1,methName, SUBSTRING(invalidMethNameChars, iLoop, 1)).
        END.
        
        /* Process parameters */
        IF params NE "" AND params NE ? THEN
        DO:
            DO iLoop = 1 TO NUM-ENTRIES(params, ","):
                parm = TRIM(ENTRY(iLoop, params, ",")).
                
                ASSIGN validateObject = TRUE
                       lastWord       = FALSE.
                
                ParamWord:
                DO iParamLoop = 1 TO NUM-ENTRIES(parm, " "):
                    
                    ASSIGN word = TRIM(ENTRY(iParamLoop, parm, " ")).
                    
                    /* If this is a blank word, then move to the next one */
                    IF word = "" OR word = ? THEN NEXT ParamWord.
                
                    /* The first word could be 'INPUT', 'OUTPUT' or 'INPUT-OUTPUT'. If not,
                     * then the first word in the fixed parameter should be 'INPUT'
                     */
                    IF iParamLoop = 1 THEN
                    DO:
                        CASE word:
                            WHEN "OUTPUT" THEN
                            DO:
                                ASSIGN fixedParam = "OUTPUT ".
                                NEXT ParamWord.
                            END.
                            
                            WHEN "INPUT-OUTPUT" THEN
                            DO:
                                ASSIGN fixedParam = "INPUT-OUTPUT ".
                                NEXT ParamWord.
                            END.
                            
                            WHEN "INPUT" THEN
                            DO:
                                ASSIGN fixedParam = "INPUT ".
                                NEXT ParamWord.
                            END.
                            
                            OTHERWISE
                            DO:
                                ASSIGN fixedParam = "INPUT ".
                            END.
                            
                        END CASE.
                    END.
                    
                    /* Check for 'BUFFER', 'DATASET' or 'TABLE' as a word */
                    CASE word:
                        
                        WHEN "BUFFER" THEN
                        DO:
                            ASSIGN fixedParam     = fixedParam + "BUFFER "
                                   validateObject = FALSE.
                            NEXT ParamWord.
                        END.
                        
                        WHEN "DATASET" THEN
                        DO:
                            ASSIGN fixedParam     = fixedParam + "DATASET "
                                   validateObject = FALSE.
                            NEXT ParamWord.
                        END.
                        
                        WHEN "TABLE" THEN
                        DO:
                            ASSIGN fixedParam     = fixedParam + "TABLE "
                                   validateObject = FALSE.
                            NEXT ParamWord.
                        END.
                        
                        /* Otherwise, validate as a data type */
                        
                        WHEN "CHARACTER" OR WHEN "CHAR" THEN
                        DO:
                            ASSIGN fixedParam = fixedParam + "CHARACTER"
                                   lastWord   = TRUE.
                        END.
                        
                        WHEN "LONGCHAR" THEN
                        DO:
                            ASSIGN fixedParam = fixedParam + "LONGCHAR"
                                   lastWord   = TRUE.
                        END.
                        
                        /* If not recognised as a built in data-type, try to find a class of that type */
                        OTHERWISE
                        DO:
                            IF validateObject = FALSE THEN
                            DO:
                                ASSIGN fixedParam = fixedParam + word.
                            END.
                            ELSE
                            DO:
                                DO ON ERROR UNDO, THROW:
                                    
                                    IF NOT VALID-OBJECT(Progress.Lang.Class:GetClass(word)) THEN
                                    DO:
                                        /* Not a valid class, so raise an error */
                                        RETURN ERROR NEW MethodNameNormaliserError(SUBSTITUTE("Could not interpret data-type '&1'", word)).
                                    END.
                                    ELSE
                                    DO:
                                        ASSIGN fixedParam = fixedParam + Progress.Lang.Class:GetClass(word):TypeName
                                               lastWord   = TRUE.
                                    END.
                                    
                                    CATCH e AS Progress.Lang.Error :
                                        /* Not a valid class, so raise an error */
                                        RETURN ERROR NEW MethodNameNormaliserError(SUBSTITUTE("Could not interpret data-type '&1'", word)).
                                    END CATCH.
                                END.
                            END.
                        END.
                        
                    END.
                    
                    /* If this is the last word in the parameter, then we should leave the param word loop */
                    IF lastWord THEN LEAVE ParamWord.
                END.
                
                fixedParams = fixedParams + "," + fixedParam.
            END.
            
            ASSIGN params = TRIM(fixedParams, ",").
            /*MESSAGE "Got parameters" params VIEW-AS ALERT-BOX.*/
            
            IF params NE ? AND params NE "" THEN 
                ASSIGN params = "(" + params + ")".
            ELSE
                ASSIGN params = "".
        END.
        
        /*MESSAGE "Got to method name:" methName.*/
        
        RETURN methName + params.
        
    END METHOD.

END CLASS.