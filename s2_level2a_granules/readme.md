# Batchs
This folder contains all bats and python codes necessary to download S2A and S2B processed at level L2A (ARD) automatically and upload them in the datacube

## How to download granules from sentinel 2 Level 2a
You have to use the s2_l2a_atom.py

This program need wget.exe
It downloads the list of images needed, analizes the list and creates a batch that downloads them one by one. It is limited to a maximum of 100 granules.

Syntax:
s2_l2a_atom start_date end_date cloud_percentage area_abrev start_number
Example s2_l2a_atom 2017-06-05 2018-11-25 80 CAT 0

area_abrev can be CAT or two letter abbreviations of the ECOPotential protected areas. It is easy to add new regions.
start_number use 0 the first time (for the granules from 1 to 100...) and, 100 for the granules from 101 to 200, 200 for the granules from 201 to 300...

The batch produces a final line about the success or failure of the process as well as a new line in the s2_l2s_ok.lst on success or a new in the s3_l2s_errror.lst on failure.

Internally requires shub_list.py and s2_l2a.bat
