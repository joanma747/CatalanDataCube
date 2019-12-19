# -*- coding: utf-8 -*-
"""
Created on Wed Dec 26 2018

Preparing img files for MiraMon Map server in IMG format.

@author: Joan Masó
"""

import datacube
import click
#from pathlib import Path
#import configparser
import json
#import dateutil.parser
#import datetime
#import struct
#import os
#import pandas
#import numpy
#import subprocess
import logging
import sys
#import shutil

@click.command()
@click.argument('product')
@click.argument('poi')
@click.argument('csv')
@click.option('-env', help="Name of the environment section in the datacube configuration file datacube.conf. Default is 'default'")
@click.option('-crs', help="CRS of the extent and the poi file. Format is 'EPSG:number'. Default is 'EPSG:32631'")
@click.option('-time', nargs=2, help="Temporal extent 2 limits in this order: timemin timemax")
@click.option('-solar-day/-no-solar-day', default=True)
              
def main(product, poi, csv, env, crs, time, solar_day):
    """
    Takes an image from the Data Cube and a list of points and extracts a temporal profile that is stored in a csv file.
    For the moment, the script is specifific for the Sentinel 2 level2a product.
    
    Params: 
    <product> name of the product in th data cube. For the moment only s2a_level2a_utm31 will work
    <band> name of the band to extract the profile ¿or expression with band names?
    <poi> name of a geojson file with the points of interest.
    <csv> prefix of the name of the new output file with the time series result
    
    Catalonia:
    python time_profile.py s2_level2a_utm31_10 D:\datacube\Prova\Vector\poi3.geojson D:\datacube\Prova\Vector\tprofile -crs EPSG:32631 -time 2018-09-28 2018-10-10
    """
    #logging.basicConfig(level=logging.WARNING) no puc posar això per culpa d'un error en le tractament del NetCDF i el v4 i el v5
    logging.basicConfig(level=logging.ERROR)
    log = logging.getLogger('cd-tile_profile_mini')
    try:
        fpoi=open(poi, "r", encoding='utf-8-sig')
        json_poi = json.load(fpoi)
        fpoi.close()
   
        #extent=json_poi["bbox"]
        
        if env is not None:
            dc = datacube.Datacube(app='dc-img', env=env)
        else:
            dc = datacube.Datacube(app='dc-img')
            
        print("Connected to the Data Cube")
        
        query = {}
        query["product"]=product
        if solar_day:
            query["group_by"]='solar_day'
        #if len(extent):
        #    query["x"]=(extent[0], extent[1])
        #    query["y"]=(extent[2], extent[3])
        if crs is not None:
            query["crs"]=crs
        else:
            query["crs"]='EPSG:32631'
            
        if len(time):
            query["time"]=(time[0], time[1])
        
        #i=0
        #for feature in json_poi["features"]:
        print("Recovering point: ", end="")
        for i, feature in enumerate(json_poi["features"]):            
            print(i, end=", ")
            #recupero les dades per aquest punt
            x=feature["geometry"]["coordinates"][0]
            y=feature["geometry"]["coordinates"][1]
            #query["lon"]=(2, 2)
            #query["lat"]=(42, 42)
            query["x"]=(x, x)
            query["y"]=(y, y)
            
            bands=dc.load(**query)
            
            #determine the file name of the csv file where data is saved
            csvfilename = "%s%0*d.csv" % (csv,len(json_poi["features"]),i+1)
            #csvfilename = Path(csv).joinpath(suffixname)
            csvfile=open(csvfilename, "w")
            #escric les coordenades del punt
            csvfile.write("id;%d\n" % i)
            csvfile.write("x;%f\n" % x)
            csvfile.write("y;%f\n" % y)

            #escric les propietats del punt
            #https://realpython.com/iterate-through-dictionary-python/
            for key, value in feature["properties"].items():
                if type(value) is int:
                    csvfile.write("%s;%d\n" % (key, value))
                elif type(value) is float:
                    csvfile.write("%s;%f\n" % (key, value))
                else:
                    csvfile.write("%s;%s\n" % (key, value))
            
            #escric les dates i els valors dels punts
            csvfile.write("time")
            for varname, da in bands.data_vars.items():
                csvfile.write(";%s"%varname)
            csvfile.write("\n")
                
            #"%s" % bands.coords["time"].values[]
            for t, time in enumerate(bands.coords["time"].values):
                csvfile.write("%s" % time)    
                for band_name, da in bands.data_vars.items():
                    csvfile.write(";%d" % bands.data_vars[band_name].values[t,0,0])
                csvfile.write("\n")
            
            csvfile.close()
            
            #i=i+1
    
        print("Done")            
        return 0
    except:
        log.exception('Exception from main():')
        sys.exit(1) 
        return 1

if __name__ == '__main__':
    main()
