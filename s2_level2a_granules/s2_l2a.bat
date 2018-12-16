@echo off
if "%1"=="" goto help
if "%2"=="" goto help

if "%DATA_HUB_USER%"=="" (
set DATA_HUB_USER=
set DATA_HUB_PASS=
set DATA_HUB_UNIT=D:
set DATA_HUB_PATH=datacube\s2_level2a_granule\
set DATA_HUB_UTILS=c:\utils
set DATA_HUB_TEMP_VAR=yes
)

%DATA_HUB_UNIT%
cd %DATA_HUB_UNIT%\%DATA_HUB_PATH%

echo.
if exist %1.zip (
echo %1 already downloaded
goto zip
)
echo Downloading...
%DATA_HUB_UTILS%\wget --content-disposition --continue --user=%DATA_HUB_USER% --password=%DATA_HUB_PASS% "%2"
if errorlevel 1 goto report_error

:zip
echo.
if exist %1.SAFE (
echo %1 already extracted
) else (
echo.
echo Extracting...
%DATA_HUB_UTILS%\pkzipc %1.zip -extract -directories -times=all -overwrite=all
if errorlevel 1 goto report_error
)

echo.
if exist %1.yaml (
echo %1 already transformed to metadata and probably indexed
goto report_escape
) else (
echo Transforming metadata...
python s2_l2a_prepare.py %1.SAFE\MTD_MSIL2A.xml --output %1.yaml
if errorlevel 1 goto report_error

echo.
echo Indexing...
datacube dataset add %1.yaml
if errorlevel 1 goto report_error
)

echo.
echo Success: 
echo %1 
echo was included in the datacube!
echo Success: %1 >>s2_l2a_ok.lst 
goto set_back

:report_error
echo.
echo !!ERROR!!: Cannot include 
echo %1 
echo in the datacube.
echo !!ERROR!!: %1 >>s2_l2a_error.lst 
goto set_back

:report_escape
echo.
echo Escaped:
echo %1 
echo assumed already in the datacube.
echo escaped: %1 >>s2_l2a_no_need.lst 
goto set_back


:set_back
set DATA_HUB_TEMP_VAR=yes
if "%DATA_HUB_TEMP_VAR%"=="yes" (
set DATA_HUB_USER=
set DATA_HUB_PASS=
set DATA_HUB_UNIT=
set DATA_HUB_PATH=
set DATA_HUB_UTILS=
set DATA_HUB_TEMP_VAR=
)

goto end_bat

:help
echo Downloads a granule from the Sentinel and index it in the datacube
echo.
echo Syntax:
echo s2_l2a granule_name(no path or extension) "download_url"
echo Example s2_l2a S2A_MSIL2A_20181114T104301_N0210_R008_T31TCG_20181114T140426 "https://scihub.copernicus.eu/dhus/odata/v1/Products('1d5245c5-7bc0-4d4f-acda-d7f1a7399a9e')/$value"
echo.
echo You can get both parameters by using https://scihub.copernicus.eu/dhus and clicking in the eye of any result an selecting copying and pasting the first 2 lines of the box
echo.
echo The batch produces a final line about the success or failure of the process as well as a new line in the s2_l2s_ok.lst on success or a new in the s3_l2s_errror.lst on failure.

:end_bat
