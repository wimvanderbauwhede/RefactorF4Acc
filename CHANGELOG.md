# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
The versioning convention is as follows:

* Versions only apply to the master branch
* All versions have a corresponding tag
* The version number reflects the release date:
    - 1.1.0: 1 Nov 2018
    - Major version increments each year
    - Minor version increments each quarter
    - Patch version increments inside a quarter, ad-hoc

## [5.1.1] - 2024-01-17
    - Fixed placement of 'implicit none'
    - Removed some experimental features that are not in the main branch

## [5.1.0] - 2023-10-23
    - Better support for F90/F95 features, see `LIMITATIONS.md` for details
    - Better errors and warnings
    - Better documentation of limitations, see `LIMITATIONS.md` 
    - More NIST tests pass, and in the process a lot of bugs were fixed
    - Better documentation of configuration options, see `CONFIGURATION.md`
    - Inlining of function and subroutine calls

## [2.1.1] - 2020-07-27
### Fixes
    - Removed stray croak/carp debug messages
    - Fixed bug in casting of arguments with same name as dummies
## [2.1.0] - 2020-07-22
### Fixes
- Too many to list, in particular the parser is now much more robust
### Features
- Improved README
- Support for EQUIVALENCE and non-aligned COMMON blocks
- Support for casting when turning COMMON variables into subroutine arguments
- Some support for BLOCK DATA
- An interactive mode to generate an initial config file
- Option to inline include files  

## [1.2.0] - 2019-03-08
### Fixes
- Include statement detection in Inventory is now case insensitive.
- Compiler does now only generate trailing comments in debug mode
- NIST test suite now used $FC for the Fortran compiler rather than a hardcoded name
- Better warning for unsupported features
- Fixed a bug in parsing of read/write statements


