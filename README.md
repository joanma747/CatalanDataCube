# CatalanDataCube
Catalan Open Data Cube

## Set up the environment on Windows
### Setup Miniconda and "datacube"
This are some python code and some scripts that I needed to start working with the Open Data Cube (https://www.opendatacube.org/) on Windows.

We have downloaded the Miniconda from here:
https://conda.io/docs/user-guide/install/windows.html
and used Miniconda3 4.5.11 (64 bits setup): Miniconda3-latest-Windows-x86_64.exe

Additional steps are:
Add the conda-forge channel: conda config --add channels conda-forge

Create a virtual environment in conda: conda create --name cubeenv python=3.6 datacube

Activate the virtual environment: conda activate cubeenv

Install other packages: conda install jupyter matplotlib scipy

### Setup PostGreSQL
We have downloaded the PostGreSQL from here:
https://www.enterprisedb.com/downloads/postgres-postgresql-downloads
selecting the version postgresql-10.5-2-windows-x64.

To make the pgAdmin4 to work there is a need to setup the vcredist_x86 from: http://www.microsoft.com/en-us/download/details.aspx?id=29

I created the "datacube" database directly in pgAdmin4.

Opening the miniconda console I was a bit difficult to figure out where the configuration file datacube.conf should be. 
It seems that it look sfor it in the following locations.
* c:\etc\datacube.conf
* c:\users\{username}\.datacube.conf
* c:\datacube.conf (current location of the miniconda console).
I decided for "c:\users\{username}"

A configuration file needs to be created. After that we can create the database schemas with:
datacube -v system init

### How to use Sentinel2 L2A (Analysis Ready Data)
