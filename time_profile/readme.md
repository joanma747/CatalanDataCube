# Extracting a time profile from GeoJSON points

The program is at
D:\datacube\ScriptsPython\time_profile.py  (dins de \\OGC4)

Sintax is:
```
python time_profile.py s2_level2a_utm31_10 D:\datacube\Prova\Vector\poi3.geojson D:\datacube\Prova\Vector\tprofile -crs EPSG:32631 -time 2018-09-28 2018-10-10
```
A file poi3.geojson is an examples with 3 points. A GeoJSON file can be created with the MiraMon MSA called JSONMM 
Time parameter is optional but useful to extract an exact single year.

The result is a list of CSV files each one like this:

```
id;0
x;421354.000000
y;4571773.000000
Categoria;1
lloc;Pista Aeroport BCN
time;blue;green;red;nir;veg1;veg2;veg3;snowicecloud;snowicecloud2;veg4;scl;aerosol;water_vapour
2018-09-28T10:55:15.685000000;-999;-999;-999;-999;-999;-999;-999;-999;-999;-999;-999;-999;-999
2018-09-30T10:44:11.965000000;2160;2404;2576;2674;2726;2641;2724;3408;3188;2763;5;1872;2931
2018-10-03T10:56:19.632000000;-999;-999;-999;-999;-999;-999;-999;-999;-999;-999;-999;-999;-999
2018-10-05T10:48:40.944000000;1974;2304;2546;2664;2738;2645;2685;3367;2994;2763;5;1811;2793
2018-10-10T10:40:18.457000000;2810;2814;2752;3064;2995;3036;3061;2460;2267;3044;9;2871;7076
```
"categoria and "lloc" are the original properties of the GeoJSON points (reproduced in the csv for convenience).
After that comes the names of the bands and their values.

