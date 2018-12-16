# -*- coding: utf-8 -*-
"""
Created on Fri Nov 16 16:25:28 2018

BAsed on this documentation http://nbviewer.jupyter.org/github/opendatacube/datacube-core/blob/develop/examples/notebooks/Datacube_Summary.ipynb

@author: Joan Masó
"""

import datacube
import matplotlib.pyplot

dc = datacube.Datacube(app='dc-example')

print(dc)

#Show the list of products.
p=dc.list_products()
print(p.to_string())

#Show the list of measurements
m=dc.list_measurements()
print(m.to_string())

#LOADING the INGESTED data

#Load 40x40 pixels of the existing time slices
nbar_ing = dc.load(product='s2a_level2a_utm31_10', x=(450000, 451000), y=(4650000, 4651000), crs='EPSG:32631', output_crs='EPSG:32631', resolution=(-25, 25), resampling='cubic')

#Show 40x40 pixels of the existing time slices as text. the resutls has dimensions, coordinates, variables and attributes (the crs)
print(nbar_ing)

#Show only the data values as text
print(nbar_ing.data_vars)

#Show only the B03 band of the data
B03=nbar_ing.green
print(B03)

#Show only the number of cells in each dimension
print(B03.shape)

#plots x/y images (one for each time slice)
print(B03.plot(col='time',col_wrap=3))

#LOADING and comparing it iwth the INDEXED data (slower)

nbar = dc.load(product='s2a_level2a_granule', x=(450000, 451000), y=(4650000, 4651000), crs='EPSG:32631', output_crs='EPSG:32631', resolution=(-25, 25), resampling='cubic')
B03=nbar.B03_10m
print(B03.shape)
print(B03.plot(col='time',col_wrap=3))