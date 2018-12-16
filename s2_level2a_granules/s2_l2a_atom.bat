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
echo Downloading...
%DATA_HUB_UTILS%\wget --no-check-certificate --user=%DATA_HUB_USER% --password=%DATA_HUB_PASS%  --output-document=%1_%2_%3.xml "https://scihub.copernicus.eu/dhus/search?q=\"Sentinel-2\" producttype:\"S2MSI2A\" footprint:\"Intersects(POLYGON((0.3 40.3,1.2 40.3,3.5 41.6,3.5 43.0,0.3 43.0,0.3 40.3)))\" beginposition:[%1T00:00:00.000Z TO %2T23:59:59.999Z] endposition:[%1T00:00:00.000Z TO %2T23:59:59.999Z] cloudcoverpercentage:[0 TO 20]&rows=100&start=%3"
if errorlevel 1 goto report_error

echo.
echo Transforming to batch...
python ..\shub_list.py %1_%2_%3.xml --output %1_%2_%3.bat
if errorlevel 1 goto report_error

call %1_%2_%3.bat

echo.
echo Success: %1 to %2 starting in %3 was included in the datacube!

set DATA_HUB_TEMP_VAR=yes
if "%DATA_HUB_TEMP_VAR%"=="yes" (
set DATA_HUB_USER=
set DATA_HUB_PASS=
set DATA_HUB_UNIT=
set DATA_HUB_PATH=
set DATA_HUB_UTILS=
set DATA_HUB_TEMP_VAR=
)

goto set_back

:report_error
echo.
echo !!ERROR!!: Cannot download %1 to %2 starting in granule %3
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
echo Downloads the list of granule from the Sentinel and index it in the datacube
echo.
echo Syntax:
echo s2_l2a_atom start_date end_date start_number
echo Example s2_l2a_atom 2017-06-05 2018-11-25 0
echo.
echo.
echo The batch produces a final line about the success or failure of the process as well as a new line in the s2_l2s_ok.lst on success or a new in the s3_l2s_errror.lst on failure.

:end_bat
