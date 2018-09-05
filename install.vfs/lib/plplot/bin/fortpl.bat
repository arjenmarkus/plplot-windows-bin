@echo off
rem
rem Straightforward batch file to assist in compiling Fortran programs
rem using PLplot
rem

setlocal

set PLPLOT_INC=INSTALLDIR\include
set PLPLOT_FLIB=INSTALLDIR\lib\plplotfortran.lib

@echo on
ifort %1 %2 %3 %4 %5 %6 %7 %8 %9 -I"%PLPLOT_INC%" "%PLPLOT_FLIB%"
@echo off

endlocal
