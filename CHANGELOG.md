OEMock ChangeLog
================

v0.2-alpha - 2015/04/22
-----------------------
* Support for DataSets.
 * DataSets are identified in procedures and classes
 * DataSet parameters are now identified
* Support for Temp-Tables
 * Although it is not currently possible to support automatic detection of Temp-Tables, they can be manually added to a test double through method calls.
* Support for procedure file parameter
 * Although it is not currently possible to support automatic detection of parameters declared in the main block of a procedure, they can be manually added to a test double through method calls.
* Table Parameters are correctly identified in class methods, functions and procedures
* Ability to define expected parameter values for use in Expectations
* Documentation has been moved into OEMock Wiki

v0.1-alpha - 2015/03/20
-----------------------
* Initial release.
 * Functional, but does not provide many features.
 * See release notes for list of known issues and limitations.