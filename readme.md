OEMock
======

A library for creating testing doubles for use with OEUnit in Progress OpenEdge. 
OEMock supports the creation of Stub and Mock test doubles.

Please note that although OEMock functions, it is alpha-quality software and should not be used in production.

Bug reports, issues and pull-requests are very welcome.

Installation Instructions
-------------------------
To install OEMock, simply download the source from the master branch, and add the root directory to your PROPATH. More information is contained in the project's Wiki pages.

Dependencies and Requirements
-----------------------------

* Assertion support in Mock doubles is provided from the OEUnit testing framework.
 * Install this as per the instructions for this framework.
* Further documentation can be found in the project's Wiki pages.

Examples
--------
A number of examples are provided with OEMock, and are held in the Examples/ directory. Further information on the examples is held in the project's Wiki pages.

Documentation
-------------
Documentation for OEMock can be found in the project's [Wiki pages](../../wiki). The following documentation is available:
* Requirements and Dependencies
* Installation Instructions
* Class/Interface References
* Example information

Change Log
----------
A full changelog is maintained in [CHANGELOG.md](CHANGELOG.md) for this project, the list below are the most recent releases.

**v0.2-alpha** - 2015/04/22
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

**v0.1-alpha** - 2015/03/20
* Initial release.
 * Functional, but does not provide many features.
 * See release notes for list of known issues and limitations.