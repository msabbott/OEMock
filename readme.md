OEMock
======

A library for creating testing doubles for use with OEUnit in Progress OpenEdge. 
OEMock supports the creation of Stub test doubles, with Mock support currently in progress.

Please note that this is early stage development, and the functionality is far from complete.

Installation Instructions
-------------------------
To install OEMock, simply download the source from the master branch, and add the root directory to your PROPATH.

Dependencies and Requirements
-----------------------------

* Assertion support in Mock doubles will be provided by using the OEUnit testing framework.
 * Install this as per the instructions for this framework.

Usage
-----

* In each test class, include the package "OEMock.*"
* Creation of Stub test doubles is through the static methods OEMock:StubClass and OEMock:StubProcedure.
 * Each method accepts a file name parameter for the class or procedure file to create the test double for.
  * Ensure that the path is a relative path from the PROPATH.
 * This will return an OEMock.Stub object.
* Once the initialisation of the Stub object is complete, call the method 'Generate()' on the Stub object.
 * A temporary directory structure will be created at this point, and placed at the front of the session's PROPATH value.
* After your test is complete, delete the Stub object.
* At the end of all tests, call the static method OEMock:CleanUp()
 * This will delete all temporary files and directories created by test doubles, and remove any changes made to the PROPATH value.