# plplot-windows-bin
Provide a binary distribution for PLplot on Windows, even if only ad hoc and limited to Fortran

# PLplot, version 5.13.0

Binary distribution for Windows and Intel Fortran of PLplot.

## Official website

   http://plplot.sf.net


## Usage

```
fortpl.bat options source-file.f90
```

Compile (and link) the program, include directory with
module intermediate files as well as library for PLplot
automatically added

```
plplot_vars.bat
```

Set environment variables for running programs using PLplot


## Build

The libraries were built with MSVC++ version 18 (2013), 64 bits
and Intel Fortran 2015.

Build type: Release.

Tested with both Intel Fortran 2015 and 2017.


## Contents

```
   Directories:
   \bin      - DLLs and drivers (created with Intel Fortran 2015,
               Release mode)
   \data     - font and palette files used by PLplot
   \doc      - HTML-file pointing to the official site
   \examples - source code for the standard examples (Fortran only)
   \include  - module intermediate files (created with Intel Fortran 2015)
   \lib      - import libraries for the link step

   Batch files:
   plplot_vars.bat - set the environment variables for running Fortran
                     programs that use PLplot
   fortpl.bat      - auxiliary batch file to help with compiling and
                     linking such programs
```


## Installation procedure

  * Select the directory in which to install the files
  * The batch files are automatically updated


## Examples

The examples use a library called `plfortrandemolib`, it has to be
compiled first.

