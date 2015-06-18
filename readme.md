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
A full changelog is maintained in [CHANGELOG.md](CHANGELOG.md) for this project. The list below is of the most recent releases.

**v0.4-alpha** - 2015/06/18
* Add functionality to automatically compile a test double after it is generated
* Raise a more meaningful error when a syntax error is found in a file being stubbed/mocked.
* Fix error when recording BUFFER, TABLE and DATASET parameter values in a mocked file.
 * These values are no longer recorded and expectations should not be raised on these parameters
 * This will be resolved in a later release (see issue #30)
* Resolve issue when producing a test double on a large source file with the SUBSTITUTE command (error 11311)
* Fix issue with table parameters not being regenerated correctly
* Reduce the amount of options output on a temp-table in a test double to prevent creating a statement longer than maximum allowed value.
* Code generated now uses "~n" as a line ending, rather than CHR(13)
 * This should aid with debugging generated code, but should have no impact during use.
* Missing temp-table definitions in unit tests for OEMock have been added.

**v0.3-alpha** - 2015/05/21
* Support for class events
* Issues with failing unit tests resolved
* Code generated now uses CHR(13) as a line ending, not CHR(10) + CHR(13)
 * This should aid with debugging generated code, but should have no impact during use.
* Introduction of CHANGELOG.md, and sections moved from readme.md.

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