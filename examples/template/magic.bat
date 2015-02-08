echo off
echo --- STARTING THE MAGIC SCRIPT ---

for  %%f in (*.upf) do set input=%%f
set toSD=%input%
set toSD=%toSD:upf=urf%
set fail=0

IF DEFINED input (
    echo --- BUILDING ---
    C:\Users\Christianson\"Google Drive"\"Second Sem"\"Mechatronics Design"\PrbDK\bin\upf_project_tool.exe %input% rebuild
    echo %input%
    echo --- BUILDING COMPLETE ---  

    IF EXIST G:\ (
        echo copying to microSD...
        copy build\%toSD% G:\
    ) else (
        set fail=1
        echo *** ERROR: PLEASE INSERT MICROSD ***
    )
) ELSE (
    set fail=1
    echo *** .upf FILE DOES NOT EXIST ***
)

IF %fail%==1 (
    echo *** SCRIPT FAILED ***
) ELSE (

    echo --- DONE SUCCESFULLY! ---
)

echo on
