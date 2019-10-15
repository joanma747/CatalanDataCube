@echo off
if "%1"=="" goto help
if "%2"=="" goto help
if "%3"=="" goto help
if "%4"=="" goto help
if "%5"=="" goto help

if "%DATA_HUB_USER%"=="" (
set DATA_HUB_USER=joanma747
set DATA_HUB_PASS=plantar380
set DATA_HUB_UNIT=D:
set DATA_HUB_PATH=datacube\s2_level2a_granule\
set DATA_HUB_UTILS=c:\utils
set DATA_HUB_DC=default
set DATA_HUB_TEMP_VAR=yes
)

if "%4"=="CAT" set DATA_HUB_EXTENT=(0.3 40.3,1.2 40.3,3.5 41.6,3.5 43.0,0.3 43.0,0.3 40.3)
if "%4"=="AB" set DATA_HUB_EXTENT=(18.11140923 68.14038544,19.23601081 68.14038544,19.23601081 68.51245835,18.11140923 68.51245835,18.11140923 68.14038544)
if "%4"=="BW" set DATA_HUB_EXTENT=(13.00158178 48.72539353,13.78570772 48.72539353,13.78570772 49.26283364,13.00158178 49.26283364,13.00158178 48.72539353)
if "%4"=="CM" set DATA_HUB_EXTENT=(3.92302209 43.1532733,5.11933798 43.1532733,5.11933798 43.85535333,3.92302209 43.85535333,3.92302209 43.1532733)
if "%4"=="CL" set DATA_HUB_EXTENT=(20.26697159 54.75263824,21.89517749 54.75263824,21.89517749 55.86160942,20.26697159 55.86160942,20.26697159 54.75263824)
if "%4"=="DA" set DATA_HUB_EXTENT=(27.96394332 44.22086851,30.02064761 44.22086851,30.02064761 45.56759411,27.96394332 45.56759411,27.96394332 44.22086851)
if "%4"=="DO" set DATA_HUB_EXTENT=(-6.98302225 36.58047107,-5.8422666 36.58047107,-5.8422666 37.49197449,-6.98302225 37.49197449,-6.98302225 36.58047107)
if "%4"=="GP" set DATA_HUB_EXTENT=(6.88531536 45.25891255,7.76395899 45.25891255,7.76395899 45.82439925,6.88531536 45.82439925,6.88531536 45.25891255)
if "%4"=="HA" set DATA_HUB_EXTENT=(6.45768635 59.70335359,8.56464941 59.70335359,8.56464941 60.75898529,6.45768635 60.75898529,6.45768635 59.70335359)
if "%4"=="HN" set DATA_HUB_EXTENT=(34.54146273 30.48585094,35.06186567 30.48585094,35.06186567 31.06950009,34.54146273 31.06950009,34.54146273 30.48585094)
if "%4"=="HT" set DATA_HUB_EXTENT=(19.35652981 48.91086668,20.63024922 48.91086668,20.63024922 49.46536439,19.35652981 49.46536439,19.35652981 48.91086668)
if "%4"=="KR" set DATA_HUB_EXTENT=(29.74641485 -26.09614688,32.20037711 -26.09614688,32.20037711 -22.20885923,29.74641485 -22.20885923,29.74641485 -26.09614688)
if "%4"=="LP" set DATA_HUB_EXTENT=(-18.14715031 28.29061857,-17.58739879 28.29061857,-17.58739879 29.0162718,-18.14715031 29.0162718,-18.14715031 28.29061857)
if "%4"=="MO" set DATA_HUB_EXTENT=(-9.42676855 37.18664495,-6.70988993 37.18664495,-6.70988993 39.78538623,-9.42676855 39.78538623,-9.42676855 37.18664495)
if "%4"=="AM" set DATA_HUB_EXTENT=(15.88877085 40.66102019,16.9516224 40.66102019,16.9516224 41.2859881,15.88877085 41.2859881,15.88877085 40.66102019)
if "%4"=="KA" set DATA_HUB_EXTENT=(13.97262413 47.53075189,14.75312502 47.53075189,14.75312502 47.99260693,13.97262413 47.99260693,13.97262413 47.53075189)
if "%4"=="OP" set DATA_HUB_EXTENT=(20.43117478 40.52846885,21.32326007 40.52846885,21.32326007 41.42830907,20.43117478 41.42830907,20.43117478 40.52846885)
if "%4"=="PG" set DATA_HUB_EXTENT=(-8.58198116 41.53940841,-7.6844337 41.53940841,-7.6844337 42.21373539,-8.58198116 42.21373539,-8.58198116 41.53940841)
if "%4"=="SA" set DATA_HUB_EXTENT=(23.65696209 35.06182441,24.36407957 35.06182441,24.36407957 35.5304889,23.65696209 35.5304889,23.65696209 35.06182441)
if "%4"=="SW" set DATA_HUB_EXTENT=(9.83875524 46.44213015,10.516641 46.44213015,10.516641 46.90208881,9.83875524 46.90208881,9.83875524 46.44213015)
if "%4"=="SN" set DATA_HUB_EXTENT=(-3.80775613 36.77725301,-2.41554148 36.77725301,-2.41554148 37.38791781,-3.80775613 37.38791781,-3.80775613 36.77725301)
if "%4"=="WS" set DATA_HUB_EXTENT=(4.48373055 52.75836988,9.41231587 52.75836988,9.41231587 55.17145575,4.48373055 55.17145575,4.48373055 52.75836988)
if "%DATA_HUB_EXTENT%"=="" goto help

%DATA_HUB_UNIT%
cd %DATA_HUB_UNIT%\%DATA_HUB_PATH%
echo.
echo Downloading...
%DATA_HUB_UTILS%\wget --no-check-certificate --user=%DATA_HUB_USER% --password=%DATA_HUB_PASS%  --output-document=%1_%2_%3_%4_%5.xml "https://scihub.copernicus.eu/dhus/search?q=\"Sentinel-2\" producttype:\"S2MSI2A\" footprint:\"Intersects(POLYGON(%DATA_HUB_EXTENT%))\" beginposition:[%1T00:00:00.000Z TO %2T23:59:59.999Z] endposition:[%1T00:00:00.000Z TO %2T23:59:59.999Z] cloudcoverpercentage:[0 TO %3]&rows=100&start=%5"
if errorlevel 1 goto report_error

echo.
echo Transforming to batch...
python ..\shub_list.py %1_%2_%3_%4_%5.xml --output %1_%2_%3_%4_%5.bat
if errorlevel 1 goto report_error

call %1_%2_%3_%4_%5.bat

echo.
echo Success: %1 to %2 starting in granule %5 (0-%3%% of clouds) for area %4 was included in the datacube!

set DATA_HUB_TEMP_VAR=yes
if "%DATA_HUB_TEMP_VAR%"=="yes" (
set DATA_HUB_USER=
set DATA_HUB_PASS=
set DATA_HUB_UNIT=
set DATA_HUB_PATH=
set DATA_HUB_UTILS=
set DATA_HUB_EXTENT=
set DATA_HUB_TEMP_VAR=
)

goto set_back

:report_error
echo.
echo !!ERROR!!: Cannot download %1 to %2 starting in granule %5 (0-%3%% of clouds) for area %4
goto set_back


:set_back
set DATA_HUB_TEMP_VAR=yes
if "%DATA_HUB_TEMP_VAR%"=="yes" (
set DATA_HUB_USER=
set DATA_HUB_PASS=
set DATA_HUB_UNIT=
set DATA_HUB_PATH=
set DATA_HUB_UTILS=
set DATA_HUB_DC=
set DATA_HUB_TEMP_VAR=
)

goto end_bat

:help
echo Downloads the list of granule from the Sentinel and index it in the datacube
echo.
echo Syntax:
echo s2_l2a_atom start_date end_date cloud_percentage area_abrev start_number
echo Example s2_l2a_atom 2017-06-05 2018-11-25 20 CAT 0
echo.
echo.
echo The batch produces a final line about the success or failure of the process as well as a new line in the s2_l2s_ok.lst on success or a new in the s3_l2s_errror.lst on failure.

:end_bat
