@echo off
rem
rem Define the environment variables for running programs using PLplot
rem

rem set PLPLOT_DIR=d:\plplot-svn\install-win\plplot
set PLPLOT_DIR=INSTALLDIR

set PATH=%PLPLOT_DIR%\bin;%PATH%
set PLPLOT_LIB=%PLPLOT_DIR%\data
set PLPLOT_DRV_DIR=%PLPLOT_DIR%\bin
