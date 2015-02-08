@echo off

rem
rem This is a helper batch file for Windows to build 
rem Pleo applications.
rem

rem add the bin folder to the PATH, so we can find the Pawn compiler
set PATH=..\..\bin;%PATH%

rem call the actual build tool with the project file and the build command
ugobe_project_tool %1.upf rebuild