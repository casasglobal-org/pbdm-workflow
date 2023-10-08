#!/usr/bin/env python
#Python script to download the hourly data  of ERA5 from CDS for a specific year for a Euro-MED  Domain
import os.path
import cdsapi
import numpy as np
c = cdsapi.Client() 
var="tp"# "t2m' 'tp' 'ssrd' 'wind' 'td2m'
variable="total_precipitation", #  "surface_pressure",  total_precipitation surface_solar_radiation_downwards "10m_wind_speed" #variable="2m_dewpoint_temperature"
#param="167.128" # ps 134 t2m 167
yearini=2020
yearfin=2021
dataset="ERA5"

for i in range(yearini, yearfin):
		file_path = "/home/alex/DATI/" + dataset +  "/" + str(i) + "/"
		directory = os.path.dirname(file_path)
		print(directory)
		if not os.path.exists(directory):
		    os.makedirs(directory)
		target= "/home/alex/DATI/" + dataset + "/" + str(i) + "/EU-" + var + "." + str(i) + ".nc"
		c.retrieve(
		    'reanalysis-era5-single-levels',
            {
				'product_type':'reanalysis',
				'format':'netcdf',
				'variable': variable,
				'year':str(i),
				'month':['01','02','03','04','05','06','07','08','09','10','11','12'],
				'day':[
					'01','02','03',
					'04','05','06',
					'07','08','09',
					'10','11','12',
					'13','14','15',
					'16','17','18',
					'19','20','21',
					'22','23','24',
					'25','26','27',
					'28','29','30',
					'31'
				],
				'time':[
					'00:00','01:00','02:00',
					'03:00','04:00','05:00',
					'06:00','07:00','08:00',
					'09:00','10:00','11:00',
					'12:00','13:00','14:00',
					'15:00','16:00','17:00',
					'18:00','19:00','20:00',
					'21:00','22:00','23:00'
				],
				'area': ['72/-22/27/45'],
            },
			target)

