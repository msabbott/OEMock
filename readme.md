OEMock
======

A library for creating testing doubles for use with OEUnit in Progress OpenEdge. 
OEMock supports the creation of Stub and Mock test doubles.

Please note that although OEMock functions, it is alpha-quality software and should not be used in production.

Installation Instructions
-------------------------
To install OEMock, simply download the source from the master branch, and add the root directory to your PROPATH.

Dependencies and Requirements
-----------------------------

* Assertion support in Mock doubles is provided from the OEUnit testing framework.
 * Install this as per the instructions for this framework.

Usage
-----

* In each test class, include the package "OEMock.*"
* Creation of Stub test doubles is through the static methods OEMock:StubClass and OEMock:StubProcedure.
 * Each method accepts a file name parameter for the class or procedure file to create the test double for.
  * Ensure that the path is a relative path from the PROPATH.
 * This will return an OEMock.Stub object.
 * Output parameter and return values can be specified with the methods SetProcedureOutputParameterValue, SetFunctionOutputParameterValue, SetMethodOutputParameterValue, SetFunctionReturnValue and SetMethodReturnValue.
* Creation of Mock test doubles is through the static methods OEMock:MockClass and OEMock:MockProcedure.
 * Each method accepts a file name parameter for the class or procedure file to create the test double for.
  * Ensure that the path is a relative path from the PROPATH.
 * This will return an OEMock.Mock object.
 * Output parameter and return values can be specified with the methods SetProcedureOutputParameterValue, SetFunctionOutputParameterValue, SetMethodOutputParameterValue, SetFunctionReturnValue and SetMethodReturnValue.
 * Expectations can be added to mocked files methods, procedures or functions by calling the Expect method on a Mock object.
  * This will return an OEMock.Expectation.Expectation object.
   * Use the following methods to set expectations regarding the number of times a Method, Function, or Procedure is called
    * CalledAtLeast(integer) - Validates the number of times the method, function or procedure is called is more than or equal the value of the integer parameter.
    * CalledAtMost(integer) - Validates the number of times the method, function or procedure is called is less than or equal to the value of the integer parameter.
    * CalledAtExactly(integer) - Validates the number of times the method, function or procedure is called is exactly the value of the integer parameter.
    * CalledOnlyOnce() - Validates the number of times the method, function or procedure is exactly once.
    * NeverCalled() - Validates that the method, function or procedure is never called.
* Once the initialisation of the test double object is complete, call the method 'Generate()' on the object.
 * A temporary directory structure will be created at this point, and placed at the front of the session's PROPATH value.
* After your test is complete, delete the test double object.
 * This will delete any temporary files created for the test double.
* At the end of all tests, call the static method OEMock:CleanUp()
 * This will delete all temporary files and directories created by test doubles, and remove any changes made to the PROPATH value.